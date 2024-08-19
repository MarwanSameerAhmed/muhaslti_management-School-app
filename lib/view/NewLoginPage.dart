import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Account.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/view/TestScreen.dart';
import 'package:muhaslti/view/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cryptography/cryptography.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  State<NewLoginPage> createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage>
    with WidgetsBindingObserver {
  TextEditingController UserNameLogin = TextEditingController();
  TextEditingController PasswordLogin = TextEditingController();
  bool rememberUser = false;
  bool _obs = true;
  final LocalAuthentication auth = LocalAuthentication();
  final _localAuth = LocalAuthentication();
  bool firstTimeLogin = true;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool _savedDataMessageShown = false;
  bool _firstTimeMessageShown = false;
  bool _isLoginChecked = false;
  final algorithm = AesGcm.with256bits();
  late SecretKey encryptionKey;
  bool fingerprintEnabled = false;
  bool isFirstLogin = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.removeObserver(this);

    initEncryptionKey().then((_) {
      checkFirstTimeLogin();
    });
    UserNameLogin.clear();
    PasswordLogin.clear();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      UserNameLogin.clear();
      PasswordLogin.clear();
    }
  }

  Future<void> initEncryptionKey() async {
    String? storedKey = await secureStorage.read(key: 'encryptionKey');
    if (storedKey == null) {
      encryptionKey = await algorithm.newSecretKey();
      final keyData = await encryptionKey.extractBytes();
      await secureStorage.write(
          key: 'encryptionKey', value: base64Encode(keyData));
    } else {
      try {
        final keyData = base64Decode(storedKey);
        encryptionKey = SecretKey(keyData);
      } catch (e) {
        print('Error initializing encryption key: $e');
        encryptionKey = await algorithm.newSecretKey();
        final keyData = await encryptionKey.extractBytes();
        await secureStorage.write(
            key: 'encryptionKey', value: base64Encode(keyData));
      }
    }
  }

  Future<String> encryptData(String data) async {
    try {
      final nonce = algorithm.newNonce();
      final secretBox = await algorithm.encrypt(
        utf8.encode(data),
        secretKey: encryptionKey,
        nonce: nonce,
      );
      return '${base64Encode(nonce)}:${base64Encode(secretBox.cipherText)}:${base64Encode(secretBox.mac.bytes)}';
    } catch (e) {
      print('Error during encryption: $e');
      return '';
    }
  }

  Future<String> decryptData(String data) async {
    try {
      final parts = data.split(':');
      if (parts.length != 3) {
        throw Exception('Invalid encrypted data format');
      }

      final nonce = base64Decode(parts[0]);
      final cipherText = base64Decode(parts[1]);
      final mac = Mac(base64Decode(parts[2]));
      final secretBox = SecretBox(
        cipherText,
        nonce: nonce,
        mac: mac,
      );

      final clearText = await algorithm.decrypt(
        secretBox,
        secretKey: encryptionKey,
      );

      return utf8.decode(clearText);
    } catch (e) {
      print('Error during decryption: $e');
      return '';
    }
  }

  Future<void> checkFirstTimeLogin() async {
    String? encryptedUsername = await secureStorage.read(key: 'username');
    String? encryptedPassword = await secureStorage.read(key: 'password');

    if (encryptedUsername == null || encryptedPassword == null) {
      showFirstTimeLoginMessage();
      setState(() {
        isFirstLogin = true;
      });
    } else {
      setState(() {
        isFirstLogin = false;
      });
      checkSavedLogin();
    }
  }

  void saveLoginData(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      String encryptedUsername = await encryptData(username);
      String encryptedPassword = await encryptData(password);
      await secureStorage.write(key: 'username', value: encryptedUsername);
      await secureStorage.write(key: 'password', value: encryptedPassword);

      print('Encrypted username: $encryptedUsername');
      print('Encrypted password: $encryptedPassword');

      if (isFirstLogin) {
        setState(() {
          isFirstLogin = false;
        });
        showSavedDataMessage();
      }
    } else {
      print('Empty fields detected, data not saved.');
    }
  }

  Future<void> authenticateWithFingerprint() async {
    if (isFirstLogin) {
      showNoSavedDataDialog(); // إذا كان هذا هو التسجيل الأول، إظهار رسالة تنبيه
      return;
    }

    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with fingerprint to access your account',
      );

      if (authenticated) {
        String? encryptedUsername = await secureStorage.read(key: 'username');
        String? encryptedPassword = await secureStorage.read(key: 'password');

        if (encryptedUsername != null && encryptedPassword != null) {
          showLoadingIndicator(context);

          String username = await decryptData(encryptedUsername);
          String password = await decryptData(encryptedPassword);

          login(username, password);

          hideLoadingIndicator(context);
        } else {
          showNoSavedDataDialog();
        }
      } else {
        showFingerprintError();
      }
    } catch (e) {
      print('Error authenticating with fingerprint: $e');
      showFingerprintError();
    }
  }

  void checkSavedLogin() async {
    String? encryptedUsername = await secureStorage.read(key: 'username');
    String? encryptedPassword = await secureStorage.read(key: 'password');

    if (encryptedUsername != null && encryptedPassword != null) {
      String username = await decryptData(encryptedUsername);
      String password = await decryptData(encryptedPassword);

      print('Decrypted username: $username');
      print('Decrypted password: $password');

      setState(() {
        UserNameLogin.text = username;
        PasswordLogin.text = password;
        UserNameLogin.clear();
        PasswordLogin.clear();
      });
    } else {
      if (isFirstLogin && !_firstTimeMessageShown) {
        showFirstTimeLoginMessage();
        _firstTimeMessageShown = true;
      }
    }
  }

  void showSavedDataMessage() {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('تم الحفظ',
    //           style: TextStyle(
    //               fontFamily: 'ElMessiri', fontWeight: FontWeight.w900)),
    //       content: Text(
    //           'تم حفظ بيانات الدخول بنجاح. يمكنك الآن استخدام البصمة لتسجيل الدخول.',
    //           style: TextStyle(fontFamily: 'ElMessiri')),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('موافق',
    //               style:
    //                   TextStyle(color: Colors.black, fontFamily: 'ElMessiri')),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
    AwesomeDialog(
      context: context,
      customHeader: Container(
        height: 200,
        width: 200,
        child: Lottie.asset('images/anime/Animation - 1723656081377.json'),
      ),
      animType: AnimType.scale,
      title: "تم الحفظ",
      titleTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
      desc:
          'تم حفظ بيانات الدخول بنجاح. يمكنك الآن استخدام البصمة لتسجيل الدخول',
      descTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        fontSize: 15,
        color: Colors.grey,
      ),
      btnOkOnPress: () {},
      btnOkColor: Colors.white,
      btnOkText: 'تم',
      buttonsTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        color: Colors.black,
        fontSize: 17,
      ),
      dialogBackgroundColor: Colors.white,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
    ).show();
  }

  void showNoSavedDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تنبيه',
              style: TextStyle(
                  fontFamily: 'ElMessiri', fontWeight: FontWeight.w900)),
          content: Text(
              'لا توجد بيانات محفوظة لتسجيل الدخول باستخدام البصمة. يُرجى تسجيل الدخول يدويًا أولاً.',
              style: TextStyle(fontFamily: 'ElMessiri')),
          actions: <Widget>[
            TextButton(
              child: Text('موافق',
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'ElMessiri')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showParent(Account account) {}

  void _showPopupForIP(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter base URL'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
                labelText: 'URL or IP', hintText: 'Example: 192.168.1.111'),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final text = textEditingController.text;
                if (Settings.settings.containsKey('ip')) {
                  Settings.settings['ip'] = text;
                  Settings.saveSettings();
                }
                Navigator.of(context).pop(); // Close the pop-up
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 20, bottom: 25, right: 25),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.login),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'مرحباً بك',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Text('الرجاء إدخال بيانات الاعتماد الخاصة بك',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ElMessiri')),
                      Text('للوصول إلى الحساب',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ElMessiri')),
                    ],
                  ),
                ),
              ),
              Center(
                child: Card(
                  color: Colors.lightBlue[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 0, bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 25),
                    child: Column(children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Icon(Icons.login),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Text(
                            //       'مرحباً بك',
                            //       style: TextStyle(
                            //           fontFamily: 'ElMessiri',
                            //           fontSize: 30,
                            //           fontWeight: FontWeight.w900),
                            //     ),
                            //   ],
                            // ),
                            // Text('الرجاء إدخال بيانات الاعتماد الخاصة بك',
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         color: Colors.grey,
                            //         fontWeight: FontWeight.w900,
                            //         fontFamily: 'ElMessiri')),
                            // Text('للوصول إلى الحساب',
                            //     style: TextStyle(
                            //         fontSize: 14,
                            //         color: Colors.grey,
                            //         fontWeight: FontWeight.w900,
                            //         fontFamily: 'ElMessiri')),
                          ],
                        ),
                      ),
                      if (!isKeyboard)
                        Lottie.asset(
                            'images/anime/Animation - 1718559668237 (1).json',
                            width: 300,
                            height: 300),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                      const SizedBox(
                          height: 5), // لإضافة مسافة بين الكارد وشريط البحث
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: UserNameLogin,
                          decoration: const InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            suffixIcon: Icon(Icons.person_2),
                            hintText: 'أسم المستخدم',
                            hintStyle: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: PasswordLogin,
                          obscureText: _obs,
                          decoration: const InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            hintText: 'كلمة المرور',
                            hintStyle: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            suffixIcon: Icon(Icons.lock),
                            // suffixIcon:
                            // IconButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         _obs = !_obs;
                            //       });
                            //     },
                            //     icon: Icon(_obs ? Icons.visibility_off:Icons.visibility,color: Colors.grey,)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      _buildRememberForgot(),
                      const SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          String username = UserNameLogin.text;
                          String password = PasswordLogin.text;
                          login(username, password);
                        },
                        child: Text(
                          'دخول',
                          style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                      ),
                      FutureBuilder(
                        future: secureStorage.read(key: 'username'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null) {
                            return IconButton(
                              icon: Icon(Icons.fingerprint),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                authenticateWithFingerprint();
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),

                      // IconButton(
                      //     icon: const Icon(Icons.fingerprint),
                      //     onPressed: () {
                      //       if (!firstTimeLogin) {
                      //         // إذا لم يكن تسجيل الدخول لأول مرة، استخدم بصمة الإصبع للتحقق
                      //         authenticateWithFingerprint();
                      //       }
                      //     }),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> login(String username, String password) async {
    showLoadingIndicator(context);

    await Account.login(username, password,
        (account, messageDescription) async {
      hideLoadingIndicator(context);
      await onResultLogin(account, messageDescription);
    });
  }

  Future<void> onResultLogin(
      Account? account, String messageDescription) async {
    if (account == null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: "حدث خطأ بالاتصال",
        titleTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
        desc: messageDescription,
        descTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: Colors.grey,
        ),
        btnOkOnPress: () {},
        btnOkColor: Colors.white,
        btnOkText: 'حسنا',
        buttonsTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 17,
        ),
        dialogBackgroundColor: Colors.white,
        dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
      ).show();
    } else {
      showLoadingIndicator(context);
      await Future.delayed(Duration(seconds: 3));
      hideLoadingIndicator(context);
      Employee employee = Employee(
        ID: 0,
        IDCardNumber: "",
        employeeName: account.username,
        type: EmployeeType.manager,
      );

      showEmployee(employee);
      final int hour = DateTime.now().hour;
      final String greetingMessage = hour < 12 ? 'صباح الخير' : '!طاب مساءك';
      AwesomeDialog(
        context: context,
        customHeader: Container(
          height: 100,
          width: 100,
          child: getCustomHeader(greetingMessage),
        ),
        animType: AnimType.scale,
        title: "$greetingMessage",
        titleTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
        desc: ' ${account.username}',
        descTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: Colors.grey,
        ),
        btnOkOnPress: () {
          if (firstTimeLogin) {
            saveLoginData(UserNameLogin.text, PasswordLogin.text);
            setState(() {
              firstTimeLogin = false;
            });
          }
        },
        btnOkColor: Colors.white,
        btnOkText: 'شكرا',
        buttonsTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 17,
        ),
        dialogBackgroundColor: Colors.white,
        dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
      ).show();
    }
  }

  void showEmployee(Employee employee) {
    if (employee == Employee.emptyEmployee) {
      Fluttertoast.showToast(
        msg: "خطا غير معروف",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 0,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 12.0,
        toastLength: Toast.LENGTH_SHORT,
      );

      return;
    }
    Provider.of<Employee>(context, listen: false).updateEmployee(employee);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const Splash_Screen()));
  }

  void showFingerprintError() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: "خطأ في المصادقة بالبصمة",
      desc:
          "فشل في المصادقة باستخدام بصمتك. يرجى المحاولة مرة أخرى أو استخدام بيانات الاعتماد الخاصة بك",
      btnOkOnPress: () {},
      btnOkText: 'حسناً',
      buttonsTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 17,
          color: Colors.white),
      titleTextStyle: const TextStyle(
          fontFamily: 'ElMessiri', fontWeight: FontWeight.w900, fontSize: 20),
      descTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        fontSize: 15,
      ),
      dialogBackgroundColor: Colors.white,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
    ).show();
  }

  void showFirstTimeLoginMessage() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: "تسجيل الدخول لأول مرة",
      desc:
          'يجب عليك تسجيل الدخول لأول مرة باستخدام اسم المستخدم وكلمة المرور. بعد ذلك، يمكنك استخدام البصمة لتسجيل الدخول في المرات القادمة',
      btnOkOnPress: () {},
      btnOkText: 'حسناً',
      titleTextStyle: const TextStyle(
          fontFamily: 'ElMessiri', fontWeight: FontWeight.w900, fontSize: 20),
      descTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: Colors.grey),
      dialogBackgroundColor: Colors.white,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
    ).show();
  }

  void showSavedDataMessage1() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: "تم حفظ بيانات الدخول",
      desc:
          'تم حفظ اسم المستخدم وكلمة المرور بنجاح. يمكنك الآن استخدام هذه البيانات لتسجيل الدخول في المرات القادمة.',
      btnOkOnPress: () {},
      btnOkText: 'حسناً',
      titleTextStyle: const TextStyle(
          fontFamily: 'ElMessiri', fontWeight: FontWeight.w900, fontSize: 20),
      descTextStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: Colors.grey),
      dialogBackgroundColor: Colors.white,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
    ).show();
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [],
        ),
        TextButton(
            onPressed: () {}, child: _buildGreyText("لقد نسيت كلمة المرور"))
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w900,
            fontFamily: 'ElMessiri'));
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return Center(
            child: Lottie.asset('images/anime/Animation - 1721418274029.json',
                width: 200, height: 200, fit: BoxFit.fill));
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void showNoSavedDataDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تنبيه',
              style: TextStyle(
                  fontFamily: 'ElMessiri', fontWeight: FontWeight.w900)),
          content: Text('لا توجد بيانات محفوظة لتسجيل الدخول باستخدام البصمة.',
              style: TextStyle(fontFamily: 'ElMessiri')),
          actions: <Widget>[
            TextButton(
              child: Text('موافق',
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'ElMessiri')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getCustomHeader(String greetingMessage) {
    if (greetingMessage == "صباح الخير") {
      return Container(
        height: 100, // تعديل الارتفاع حسب الحاجة
        width: 100, // تعديل العرض حسب الحاجة
        child: Lottie.asset(
            'images/anime/Animation - 1723490127236.json'), // استبدل بهذا الويدجيت الخاص بالأنيميشن الصباحي
      );
    } else {
      return Container(
        height: 100, // تعديل الارتفاع حسب الحاجة
        width: 100, // تعديل العرض حسب الحاجة
        child: Lottie.asset(
            'images/anime/Animation - 1723490127236.json'), // استبدل بهذا الويدجيت الخاص بالأنيميشن المسائي
      );
    }
  }

  // void showGreetingDialog(BuildContext context) {
  //   String greetingMessage = getGreetingMessage();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(greetingMessage),
  //         content: Text('أتمنى لك يوماً رائعاً!'),
  //         actions: [
  //           TextButton(
  //             child: Text('شكراً'),
  //             onPressed: () {
  //               if (firstTimeLogin) {
  //                 saveLoginData(UserNameLogin.text, PasswordLogin.text);
  //                 setState(() {
  //                   firstTimeLogin = false;
  //                 });
  //               }
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // String getGreetingMessage() {
  //   var hour = DateTime.now().hour;

  //   if (hour < 12) {
  //     return 'صباح الخير';
  //   } else {
  //     return 'مساء الخير';
  //   }
  // }
}
