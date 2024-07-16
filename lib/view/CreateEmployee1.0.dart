import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/Manager.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // ignore: non_constant_identifier_names
  TextEditingController IDCardNumber = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController employeeUserNAme = TextEditingController();

  TextEditingController employeePassword = TextEditingController();

  String type = 'أستاذ';
  File? _selectedImage;
  var newEmployees;
  @override
  Widget build(BuildContext context) {
    Employee currentEmployee = Provider.of<Employee>(context);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return MaterialApp(
      home: SafeArea(
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
                              controller: employeeName,
                              decoration: const InputDecoration(
                                hintText: 'أسم الموظف',
                                hintStyle: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(Icons.card_membership_sharp),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height:
                                  15), // لإضافة مسافة بين الكارد وشريط البحث
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
                              controller: employeeUserNAme,
                              decoration: const InputDecoration(
                                hintText: 'اسم المستخدم',
                                hintStyle: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(Icons.person_2_rounded),
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: employeePassword,
                                    decoration: const InputDecoration(
                                      hintText: 'كلمة المرور',
                                      hintStyle: TextStyle(
                                          fontFamily: 'ElMessiri',
                                          fontWeight: FontWeight.w900),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      prefixIcon: Icon(Icons.password_sharp),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: _buildImagePicker()),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  15), // لإضافة مسافة بين الكارد وشريط البحث
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: type,
                                      hint: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20),
                                        child: Text(
                                          'النوع',
                                          style: TextStyle(
                                            fontFamily: 'ElMessiri',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      items: ['أستاذ', 'مشرف', 'مسجل', 'وكيل']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20),
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                  fontFamily: 'ElMessiri',
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          type = newValue!;
                                        });
                                      },
                                      icon: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
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
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      controller: IDCardNumber,
                                      decoration: const InputDecoration(
                                        hintText: 'رقم البطاقة',
                                        hintStyle: TextStyle(
                                            fontFamily: 'ElMessiri',
                                            fontWeight: FontWeight.w900),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(16),
                                        prefixIcon:
                                            Icon(Icons.card_membership_sharp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              createEmployee(currentEmployee, context);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80))),
                            child: const Text('إضافة',
                                style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createEmployee(currentEmployee, BuildContext context) {
    EmployeeType type = EmployeeType.none;

    if (this.type == 'أستاذ') {
      type = EmployeeType.teacher;
    } else if (this.type == 'مشرف') {
      type = EmployeeType.supervisor;
    } else if (this.type == 'مسجل') {
      type = EmployeeType.registrar;
    } else if (this.type == 'وكيل') {
      type = EmployeeType.manager;
    }

    Employee newEmployee = Employee(
      ID: -1,
      employeeName: employeeName.text,
      IDCardNumber: IDCardNumber.text,
      type: type,
    );

    createEmployeeDB(currentEmployee, newEmployee, context);
  }

  void createEmployeeDB(
      Employee currentEmployee, Employee newEmployee, BuildContext context) {
    if (currentEmployee.type != EmployeeType.manager) {
      Fluttertoast.showToast(
          msg: "حدث خطا في الاضافة",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 0,
          backgroundColor: Colors.lightBlue[50],
          textColor: Colors.black,
          fontSize: 12.0);
    }

    Manager manager = Manager.byEmployee(currentEmployee);
    manager.createEmployee(
        Employee(
            ID: -1,
            employeeName: newEmployee.employeeName,
            IDCardNumber: newEmployee.IDCardNumber,
            type: newEmployee.type), onResult: (result) {
      if (result == NewEmployeeResult.successfully) {
        Fluttertoast.showToast(
            msg: "تمت الاضافة بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.lightBlue[50],
            textColor: Colors.black,
            fontSize: 12.0);

        Navigator.pop(context);
      } else if (result == NewEmployeeResult.nameExists) {
        Fluttertoast.showToast(
          msg: "الاسم موجود مسبقاً",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue[50],
          textColor: Colors.black,
          fontSize: 12.0,
        );
      }
    });
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          height: 55,
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
          child: _selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 5),
                    child: Row(
                      children: [
                        Icon(Icons.add_a_photo, size: 30),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'إضافة صورة',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}
