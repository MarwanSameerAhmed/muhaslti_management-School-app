import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/Level.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:provider/provider.dart';

class CreateStudentNew extends StatefulWidget {
  const CreateStudentNew({super.key});

  @override
  State<CreateStudentNew> createState() => _CreateStudentNewState();
}

class _CreateStudentNewState extends State<CreateStudentNew> {
  List<Level> levels = [];
  Level? selectedLevel;
  File? _selectedImage;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordStudentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Employee employee = Provider.of<Employee>(context);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Column(
              children: [
                //   if (!isKeyboard) buildTextContent(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 15, bottom: 25, right: 25),
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
                              controller: studentNameController,
                              decoration: const InputDecoration(
                                hintText: 'أسم الطالب',
                                hintStyle: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(Icons.boy_rounded),
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
                              controller: parentNameController,
                              decoration: const InputDecoration(
                                hintText: 'اسم ولي الامر',
                                hintStyle: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(Icons.supervised_user_circle),
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
                                    controller: UserNameController,
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
                                      controller: PasswordStudentController,
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
                                    controller: phoneNumberController,
                                    decoration: const InputDecoration(
                                      hintText: 'رقم الهاتف',
                                      hintStyle: TextStyle(
                                          fontFamily: 'ElMessiri',
                                          fontWeight: FontWeight.w900),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: _buildImagePicker()),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: buildDropDownLevels(),
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
                                      controller: birthDateController,
                                      decoration: const InputDecoration(
                                        hintText: 'تاريخ الميلاد',
                                        hintStyle: TextStyle(
                                            fontFamily: 'ElMessiri',
                                            fontWeight: FontWeight.w900),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(16),
                                        prefixIcon: Icon(Icons.date_range),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              createStudent(employee);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFutureDropDownLevels(Employee employee) {
    return FutureBuilder<List<Level>>(
        future: employee.getLevels(),
        builder: (context, snapshot) {
          if (levels.isNotEmpty) return buildDropDownLevels();
          if (snapshot.connectionState == ConnectionState.done) {
            levels = snapshot.data ?? [];
            if (levels.isNotEmpty) selectedLevel = levels[0];
          } else {
            return LoadingScreen();
          }
          return buildDropDownLevels();
        });
  }

  Widget buildDropDownLevels() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Level>(
            isExpanded: true,
            hint: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                'المرحلة',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            items: levels.map((Level level) {
              return DropdownMenuItem<Level>(
                value: level,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Text(
                    level.levelName,
                    style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
              );
            }).toList(),
            onChanged: (selectedLevel) {
              setState(() {
                this.selectedLevel = selectedLevel;
              });
            },
            icon: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }

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

  void createStudent(Employee employee) {
    if (employee.type != EmployeeType.registrar) return;
    if (studentNameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        parentNameController.text.isEmpty ||
        birthDateController.text.isEmpty ||
        selectedLevel == null) return;
    employee.createStudent(
        selectedLevel!.ID,
        parentNameController.text,
        phoneNumberController.text,
        studentNameController.text,
        birthDateController.text, onResult: (result) {
      if (result == 0) Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "تمت الاضافة بنجاح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue[50],
          textColor: Colors.black,
          fontSize: 12.0);
    });
  }

  Widget Logoname() {
    return Lottie.asset('images/anime/Animation - 1717790914008.json',
        width: 400, height: 200, repeat: true);
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
}
