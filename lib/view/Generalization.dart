import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Level.dart';

class Generalization_Page extends StatefulWidget {
  const Generalization_Page({super.key});

  @override
  State<Generalization_Page> createState() => _Generalization_PageState();
}

class _Generalization_PageState extends State<Generalization_Page> {
  List<Level> levels = [];
  Level? selectedLevel;
  File? _SelectedImage;
  TextEditingController AddGeneralization = TextEditingController();
  TextEditingController YearLevel = TextEditingController();
  TextEditingController SelectSubject = TextEditingController();
  TextEditingController DateTime = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
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
                              'إضافة تعميم',
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
                    color: Colors.yellow[50],
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
                                'images/anime/Animation - 1719665511276.json',
                                width: 400,
                                height: 200),
                          const SizedBox(height: 10),
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
                              controller: AddGeneralization,
                              decoration: const InputDecoration(
                                hintText: 'إضافة تعميم',
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
                                    controller: PhoneNumber,
                                    decoration: const InputDecoration(
                                      hintText: 'رقم التعميم',
                                      hintStyle: TextStyle(
                                          fontFamily: 'ElMessiri',
                                          fontWeight: FontWeight.w900),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      prefixIcon: Icon(Icons.numbers),
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
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: buildDropDownLevels(),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
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

  Widget buildTextFields() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'يرجى ملء النموذج أدناه لإضافة تعميم جديد',
          style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w900,
              fontFamily: 'ElMessiri'),
        ),
        Text(
          'إلى الموظفين تأكد من الادخال الصحيح للمعلومات',
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w900,
              fontFamily: 'ElMessiri'),
        ),
      ],
    );
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
        _SelectedImage = File(pickedFile.path);
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
          child: _SelectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    _SelectedImage!,
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
}
