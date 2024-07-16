import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ActivityFormPage extends StatefulWidget {
  const ActivityFormPage({super.key});

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  TextEditingController NameOfEmployee = TextEditingController();
  TextEditingController SubjectOfActivity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ignore: prefer_const_constructors
              Align(
                alignment: Alignment.centerRight,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.local_activity),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'اضافة نشاط',
                      style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ],
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
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0, bottom: 25),
                        child: Column(children: [
                          Lottie.asset(
                              'images/anime/Animation - 1720783449907.json'),
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
                              controller: NameOfEmployee,
                              decoration: const InputDecoration(
                                hintText: 'اسم الكاتب ',
                                hintStyle: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(Icons.supervised_user_circle),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                              controller: SubjectOfActivity,
                              decoration: const InputDecoration(
                                hintText: 'موضوع الغعالية',
                                hintStyle: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w900),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(Icons.supervised_user_circle),
                              ),
                            ),
                          ),
                        ]),
                      )))
            ],
          ),
        )),
      )),
    );
  }
}
