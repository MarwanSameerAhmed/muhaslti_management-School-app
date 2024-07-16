import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Account.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/view/TestScreen.dart';
import 'package:muhaslti/view/main.dart';
import 'package:provider/provider.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  State<NewLoginPage> createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  TextEditingController UserNameLogin = TextEditingController();
  TextEditingController PasswordLogin = TextEditingController();
  bool rememberUser = false;
  bool _obs = true;
 
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
                    left: 30.0, top: 30, bottom: 25, right: 25),
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
                      left: 15, right: 15, top: 10, bottom: 15),
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
                          controller: UserNameLogin,
                          decoration: const InputDecoration(
                            hintText: 'أسم المستخدم',
                            hintStyle: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            prefixIcon: Icon(Icons.person_2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // لإضافة مسافة بين الكارد وشريط البحث
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
                          controller: PasswordLogin,
                          obscureText: _obs,
                          decoration: const InputDecoration(
                            hintText: 'كلمة المرور',
                            hintStyle: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            prefixIcon: Icon(Icons.lock),
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
                      const SizedBox(height: 15),

                      _buildRememberForgot(),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          login(UserNameLogin.text, PasswordLogin.text);
                        },
                        onLongPress: () {
                          _showPopupForIP(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80))),
                        child: const Text('دخول',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900,
                                color: Colors.black)),
                      ),
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
    await Account.login(username, password,
        (account, accountResult) => onResultLogin(account, accountResult));
  }
 final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> onResultLogin(
      Account account, AccountResult accountResult) async {
    if (accountResult == AccountResult.failedProcess) {
      // await audioPlayer.play(AssetSource('images/sound/minimal-pop-click-ui-1-198301.mp3'));
      // ignore: use_build_context_synchronously
      AwesomeDialog(
              context: context,
              dialogType: DialogType.infoReverse,
              animType: AnimType.scale,
              title: "خطا بالاتصال",
              titleTextStyle: const TextStyle(
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
              desc: 'يُرجى التحقق من اتصالك بالشبكة والمحاولة\n مرة أخرى',
              descTextStyle: const TextStyle(
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: Colors.grey),
              btnOkOnPress: () {},
              btnOkColor: Colors.white,
              btnOkText: 'حسنا',
              buttonsTextStyle: const TextStyle(
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 17),
              dialogBorderRadius: const BorderRadius.all(Radius.circular(40)))
          .show();
    } else if (accountResult == AccountResult.wrongUsernameOrPassword) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: "خطا في التسجيل",
        titleTextStyle: const TextStyle(
            fontFamily: 'ElMessiri', fontWeight: FontWeight.w900, fontSize: 20),
        desc: 'اسم المستخدم أو كلمة المرور غير صحيحة\n يُرجى المحاولة مرة أخرى',
        descTextStyle: const TextStyle(
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Colors.grey),
        btnOkOnPress: () {},
        btnOkColor: Colors.white,
        btnOkText: 'حسنا',
        buttonsTextStyle: const TextStyle(
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 17),
        dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
      ).show();
    } else if (accountResult == AccountResult.successfully) {
      if (account.isEmployee) {
        Employee employee = await Employee.byID(account.userID);
        showEmployee(employee);
      }
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

    textEditingController.text =
        Settings.settings.containsKey('ip') ? Settings.settings['ip'] : "";
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("تذكرني "),
          ],
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
}
