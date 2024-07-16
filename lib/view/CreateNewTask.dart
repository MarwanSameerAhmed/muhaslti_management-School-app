import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  TextEditingController Subject = TextEditingController();
  TextEditingController Disc = TextEditingController();
  File? _SelectedImage;
  String Type = 'أستاذ';

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      Padding(
        padding:
            const EdgeInsets.only(left: 30.0, top: 30, bottom: 25, right: 25),
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
                    'إضافة مهام',
                    style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Text('يرجى ملء النموذج أدناه لإضافة مهمة جديدة',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'ElMessiri')),
              Text('واشعارها للجهة المستهدفة',
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 25),
              child: Column(
                children: [
                  if (!isKeyboard)
                    Lottie.asset('images/anime/Animation - 1720799406486.json',
                        width: 400, height: 200),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  const SizedBox(
                      height: 10), // لإضافة مسافة بين الكارد وشريط البحث
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: Subject,
                      decoration: const InputDecoration(
                        hintText: 'عنوان المهمة',
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
                      height: 15), // لإضافة مسافة بين الكارد وشريط البحث
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: Disc,
                      decoration: const InputDecoration(
                        hintText: 'وصف المهمة',
                        hintStyle: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.w900),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                        prefixIcon: Icon(Icons.person_2_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 15), // لإضافة مسافة بين الكارد وشريط البحث
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
                              value: Type,
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
                                  Type = newValue!;
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
                      Expanded(child: _buildImagePicker()),
                    ],
                  ),
                ],
              )),
        ),
      )
    ]))));
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
                          'إضافة مرفق',
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
        _SelectedImage = File(pickedFile.path);
      });
    }
  }
}
