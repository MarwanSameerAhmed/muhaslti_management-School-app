import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/api/MSTRequst.dart';
import 'package:muhaslti/api/employee/EmployeeRequest.dart';
import 'package:muhaslti/api/employee/EmployeeResponse.dart';
import 'package:muhaslti/api/mst_response.dart';
import 'package:muhaslti/controller/client_controller.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/view/CreateStudent1.0.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController IDCardNumber = TextEditingController();
  TextEditingController EmployeeName = TextEditingController();
  TextEditingController EmployeePhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final yourController = Get.put(ClientController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[200],
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
                          Icon(Icons.add_box),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'إضافة موظف',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Text('يرجى ملء النموذج أدناه لإضافة موظف جديد',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ElMessiri')),
                      Text(
                          'إلى قاعدة البيانات تأكد من الادخال الصحيح للمعلومات',
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
                    child: Column(
                      children: [
                        if (!isKeyboard)
                          Lottie.asset(
                              'images/anime/Animation - 1717780699649.json',
                              width: 400,
                              height: 200),
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
                            controller: EmployeeName,
                            decoration: const InputDecoration(
                              hintText: 'أسم الموظف',
                              hintStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontWeight: FontWeight.w900),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              suffixIcon: Icon(Icons.person_2_outlined),
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
                            controller: IDCardNumber,
                            decoration: const InputDecoration(
                              hintText: 'رقم البطاقة',
                              hintStyle: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontWeight: FontWeight.w900),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              suffixIcon: Icon(Icons.numbers),
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
                            controller: EmployeePhoneNumber,
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
                        ), // لإضافة مسافة بين الكارد وشريط البحث

                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final player = AudioPlayer();
                            try {
                              var uuid = Uuid();
                              String requestID = uuid.v4();

                              var Employeerequest = EmployeeRequest(
                                  RequestID: requestID,
                                  Username: "",
                                  EmployeeName: EmployeeName.text,
                                  IDCardNumber: IDCardNumber.text,
                                  EmployeePhoneNumber:
                                      EmployeePhoneNumber.text);
                              var response = await yourController.MainRequest(
                                  Employeerequest);

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
                                      EmployeeName.clear();
                                      EmployeePhoneNumber.clear();
                                      IDCardNumber.clear();
                                    },
                                    btnOkText: 'حسنا',
                                    buttonsTextStyle: const TextStyle(
                                        fontFamily: 'ElMessiri',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: Colors.white),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void showCustomSnackBar(
      BuildContext context, String message, String subMessage) {
    bool _isExpanded = false;
    bool _showMoreButton = false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Measure the text to determine if it's overflowing
            if (!_showMoreButton) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final messagePainter = TextPainter(
                  text: TextSpan(
                    text: message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                )..layout(maxWidth: MediaQuery.of(context).size.width - 64);
                final subMessagePainter = TextPainter(
                  text: TextSpan(
                    text: subMessage,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                )..layout(maxWidth: MediaQuery.of(context).size.width - 64);

                if (messagePainter.size.height > 24 ||
                    subMessagePainter.size.height > 16) {
                  setState(() {
                    _showMoreButton = true;
                  });
                }
              });
            }

            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: _isExpanded ? null : 1,
                              overflow: _isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                            Text(
                              subMessage,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: _isExpanded ? null : 1,
                              overflow: _isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                            if (_showMoreButton)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(
                                  _isExpanded ? "عرض أقل" : "عرض المزيد",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

  // void createEmployee(currentEmployee, BuildContext context) {
  //   EmployeeType type = EmployeeType.none;

  //   if (this.type == 'أستاذ') {
  //     type = EmployeeType.teacher;
  //   } else if (this.type == 'مشرف') {
  //     type = EmployeeType.supervisor;
  //   } else if (this.type == 'مسجل') {
  //     type = EmployeeType.registrar;
  //   } else if (this.type == 'وكيل') {
  //     type = EmployeeType.manager;
  //   }

  //   Employee newEmployee = Employee(
  //     ID: -1,
  //     employeeName: employeeName.text,
  //     IDCardNumber: IDCardNumber.text,
  //     type: type,
  //   );

  //   createEmployeeDB(currentEmployee, newEmployee, context);
  // }

  // void createEmployeeDB(
  //     Employee currentEmployee, Employee newEmployee, BuildContext context) {
  //   if (currentEmployee.type != EmployeeType.manager) {
  //     Fluttertoast.showToast(
  //         msg: "حدث خطا في الاضافة",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 0,
  //         backgroundColor: Colors.lightBlue[50],
  //         textColor: Colors.black,
  //         fontSize: 12.0);
  //   }

  //   Manager manager = Manager.byEmployee(currentEmployee);
  //   manager.createEmployee(
  //       Employee(
  //           ID: -1,
  //           employeeName: newEmployee.employeeName,
  //           IDCardNumber: newEmployee.IDCardNumber,
  //           type: newEmployee.type), onResult: (result) {
  //     if (result == NewEmployeeResult.successfully) {
  //       Fluttertoast.showToast(
  //           msg: "تمت الاضافة بنجاح",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.lightBlue[50],
  //           textColor: Colors.black,
  //           fontSize: 12.0);

  //       Navigator.pop(context);
  //     } else if (result == NewEmployeeResult.nameExists) {
  //       Fluttertoast.showToast(
  //         msg: "الاسم موجود مسبقاً",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.lightBlue[50],
  //         textColor: Colors.black,
  //         fontSize: 12.0,
  //       );
  //     }
  //   });
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

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }

