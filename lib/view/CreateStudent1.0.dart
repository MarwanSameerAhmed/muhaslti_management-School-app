import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/api/MSTRequst.dart';
import 'package:muhaslti/api/mst_response.dart';
import 'package:muhaslti/api/student/StudentReqest.dart';
import 'package:muhaslti/api/student/StudentResponse.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/Level.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:muhaslti/controller/client_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateStudentNew extends StatefulWidget {
  const CreateStudentNew({super.key});

  @override
  State<CreateStudentNew> createState() => _CreateStudentNewState();
}

class _CreateStudentNewState extends State<CreateStudentNew> {
  List<Level> levels = [];
  Level? selectedLevel;
  File? _selectedImage;
  final storage = FlutterSecureStorage();

  Future<MSTResponse?> request2(MSTRequst request) async {
    String sUrl = 'http://192.168.0.111:5000/api';
    if (request is Studentreqest) {
      sUrl += '/Student/Create';
    }
    var url = Uri.parse(sUrl);

    try {
      String? token = await TokenManager.getToken();

      var headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      var response = await http.post(
        url,
        body: jsonEncode(request.toMap()),
        headers: headers,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.body.contains("MessageDescription")) {
        Map<String, dynamic> result = jsonDecode(response.body);
        MSTResponse? response2 = null;
        if (request is Studentreqest)
          response2 = StudentResponse.fromMap(result);
        if (response2 == null) {
          throw Exception("Unknown exception");
        }
        if (response2.responseCode == "1") {
          return response2;
        } else {
          throw Exception(response2.messageDescription);
        }
      } else {
        throw Exception("Unexpected response format: ${response.body}");
      }
    } catch (e) {
      print('Request failed: $e');
      rethrow;
    }
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController LevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              //   if (!isKeyboard) buildTextContent(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 30, bottom: 25, right: 25),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.add_box),
                          SizedBox(width: 10),
                          Text(
                            'إضافة طالب',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      buildTextFields(),
                    ],
                  ),
                ),
              ),
              Center(
                child: Card(
                  color: Colors.pink[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                    child: Column(
                      children: [
                        if (!isKeyboard)
                          Lottie.asset(
                              'images/anime/Animation - 1717790914008.json',
                              width: 400,
                              height: 200),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            controller: studentNameController,
                            decoration: const InputDecoration(
                              hintText: 'أسم الطالب',
                              hintStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontWeight: FontWeight.w900),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              suffixIcon: Icon(Icons.boy_rounded),
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            controller: parentNameController,
                            decoration: const InputDecoration(
                              hintText: 'اسم ولي الامر',
                              hintStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontWeight: FontWeight.w900),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              suffixIcon: Icon(Icons.supervised_user_circle),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  controller: phoneNumberController,
                                  decoration: const InputDecoration(
                                    hintText: 'رقم الهاتف',
                                    hintStyle: TextStyle(
                                        fontFamily: 'ElMessiri',
                                        fontWeight: FontWeight.w900),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16),
                                    suffixIcon: Icon(Icons.phone),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  controller: LevelController,
                                  decoration: const InputDecoration(
                                    hintText: 'المرحلة',
                                    hintStyle: TextStyle(
                                        fontFamily: 'ElMessiri',
                                        fontWeight: FontWeight.w900),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16),
                                    suffixIcon: Icon(Icons.phone),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    controller: birthDateController,
                                    decoration: const InputDecoration(
                                      hintText: 'تاريخ الميلاد',
                                      hintStyle: TextStyle(
                                          fontFamily: 'ElMessiri',
                                          fontWeight: FontWeight.w900),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      suffixIcon: Icon(Icons.date_range),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final player = AudioPlayer();
                            try {
                              var uuid = Uuid();
                              String requestID = uuid.v4();

                              var studentRequest = Studentreqest(
                                RequestID: requestID,
                                StudentFullName: studentNameController.text,
                                ParentName: parentNameController.text,
                                ParentPhoneNumber: phoneNumberController.text,
                                LevelNumber: LevelController.text,
                                StudentBirthDate: birthDateController.text,
                              );
                              var response = await request2(studentRequest);

                              if (response != null) {
                                if (response.responseCode == "1") {
                                  player.play(AssetSource(
                                      'images/sounds/minimal-pop-click-ui-1-198301.mp3'));

                                  AwesomeDialog(
                                    context: context,
                                    customHeader: Container(
                                      height: 200,
                                      width: 200,
                                      child: Lottie.asset(
                                          'images/anime/Animation - 1723657476401.json',
                                          width: 200,
                                          height: 200),
                                    ),
                                    animType: AnimType.scale,
                                    title: 'تمت الاضافة بنجاح',
                                    titleTextStyle: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                    desc: ' اسم المستخدم لديك هو\n ' +
                                        (response.messageDescription ??
                                            'لا توجد تفاصيل'),
                                    descTextStyle: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                    btnOkOnPress: () {
                                      studentNameController.clear();
                                      parentNameController.clear();
                                      phoneNumberController.clear();
                                      LevelController.clear();
                                      birthDateController.clear();
                                    },
                                    btnOkText: 'حسنا',
                                    buttonsTextStyle: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                    dialogBackgroundColor: Colors.white,
                                    dialogBorderRadius: const BorderRadius.all(
                                        Radius.circular(40)),
                                  ).show();
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.scale,
                                    title: 'فشل',
                                    titleTextStyle: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                    desc: response.messageDescription ??
                                        'لا توجد تفاصيل',
                                    descTextStyle: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                    btnOkOnPress: () {},
                                    btnOkColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    btnOkText: 'حسنا',
                                    buttonsTextStyle: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                    dialogBackgroundColor: Colors.white,
                                    dialogBorderRadius: const BorderRadius.all(
                                        Radius.circular(40)),
                                  ).show();
                                }
                              }
                            } catch (e) {
                              showCustomSnackBar(
                                  context, "خطا في الأدخال", e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                          child: const Text(
                            'إضافة',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildFutureDropDownLevels(Employee employee) {
  //   return FutureBuilder<List<Level>>(
  //       future: employee.getLevels(),
  //       builder: (context, snapshot) {
  //         if (levels.isNotEmpty) return buildDropDownLevels();
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           levels = snapshot.data ?? [];
  //           if (levels.isNotEmpty) selectedLevel = levels[0];
  //         } else {
  //           return LoadingScreen();
  //         }
  //         return buildDropDownLevels();
  //       });
  // }

  // Widget buildDropDownLevels() {
  //   return Expanded(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.grey[100],
  //         borderRadius: BorderRadius.circular(20),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             spreadRadius: 2,
  //             blurRadius: 5,
  //             offset: const Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton<Level>(
  //           isExpanded: true,
  //           hint: const Padding(
  //             padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
  //             child: Text(
  //               'المرحلة',
  //               style: TextStyle(
  //                 fontFamily: 'ElMessiri',
  //                 fontWeight: FontWeight.w900,
  //               ),
  //             ),
  //           ),
  //           items: levels.map((Level level) {
  //             return DropdownMenuItem<Level>(
  //               value: level,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     vertical: 10.0, horizontal: 20),
  //                 child: Text(
  //                   level.levelName,
  //                   style: const TextStyle(
  //                       fontFamily: 'ElMessiri',
  //                       fontWeight: FontWeight.w900,
  //                       color: Colors.black),
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (selectedLevel) {
  //             setState(() {
  //               this.selectedLevel = selectedLevel;
  //             });
  //           },
  //           icon: const Padding(
  //             padding: EdgeInsets.all(16.0),
  //             child: Icon(Icons.arrow_drop_down),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildTextFields() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'يرجى ملء النموذج أدناه لإضافة طالب جديد',
          style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w900,
              fontFamily: 'ElMessiri'),
        ),
        Text(
          'إلى قاعدة البيانات تأكد من الادخال الصحيح للمعلومات',
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w900,
              fontFamily: 'ElMessiri'),
        ),
      ],
    );
  }

  Widget buildTextContent() {
    return const Padding(
      padding: EdgeInsets.only(left: 30.0, top: 30, bottom: 25, right: 25),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add_box),
                SizedBox(width: 10),
                Text(
                  'إضافة طالب',
                  style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Text(
              'يرجى ملء النموذج أدناه لإضافة طالب جديد',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'ElMessiri'),
            ),
            Text(
              'إلى قاعدة البيانات تأكد من الادخال الصحيح للمعلومات',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'ElMessiri'),
            ),
          ],
        ),
      ),
    );
  }

  // void createStudent(Employee employee) {
  //   if (employee.type != EmployeeType.registrar) return;
  //   if (studentNameController.text.isEmpty ||
  //       phoneNumberController.text.isEmpty ||
  //       parentNameController.text.isEmpty ||
  //       birthDateController.text.isEmpty ||
  //       selectedLevel == null) return;
  //   employee.createStudent(
  //       selectedLevel!.ID,
  //       parentNameController.text,
  //       phoneNumberController.text,
  //       studentNameController.text,
  //       birthDateController.text, onResult: (result) {
  //     if (result == 0) Navigator.pop(context);
  //     Fluttertoast.showToast(
  //         msg: "تمت الاضافة بنجاح",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.lightBlue[50],
  //         textColor: Colors.black,
  //         fontSize: 12.0);
  //   });
  // }

  // Widget Logoname() {
  //   return Lottie.asset('images/anime/Animation - 1717790914008.json',
  //       width: 400, height: 200, repeat: true);
  // }

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }

  // Widget _buildImagePicker() {
  //   return GestureDetector(
  //     onTap: _pickImage,
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10.0),
  //       child: Container(
  //         height: 55,
  //         decoration: BoxDecoration(
  //           color: Colors.grey[100],
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.2),
  //               spreadRadius: 2,
  //               blurRadius: 5,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: _selectedImage != null
  //             ? ClipRRect(
  //                 borderRadius: BorderRadius.circular(20),
  //                 child: Image.file(
  //                   _selectedImage!,
  //                   fit: BoxFit.cover,
  //                 ),
  //               )
  //             : const Center(
  //                 child: Padding(
  //                   padding: EdgeInsets.only(left: 10.0, top: 5),
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.add_a_photo, size: 30),
  //                       SizedBox(
  //                         width: 15,
  //                       ),
  //                       Text(
  //                         'إضافة صورة',
  //                         style: TextStyle(
  //                           fontFamily: 'ElMessiri',
  //                           fontWeight: FontWeight.w900,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //       ),
  //     ),
  //   );
  // }

  void showCustomSnackBar(
      BuildContext context, String message, String subMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Lottie.asset(
                    'images/anime/Animation - 1723325601946.json',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          subMessage,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class TokenManager {
  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
