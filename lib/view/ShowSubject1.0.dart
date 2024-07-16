import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/Student.dart';
import 'package:muhaslti/model/StudentGrade.dart';
import 'package:muhaslti/view/CreateEmployee1.0.dart';
import 'package:muhaslti/view/ShowStudentTremGrade.dart';
import 'package:muhaslti/view/StudentGradeInfo.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:provider/provider.dart';

class SubjectCard extends StatefulWidget {
  final String subjectName;
  final String iconPath;

  SubjectCard({required this.subjectName, required this.iconPath});

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => StudentGradeInfo()));
      },
      child: Card(
        child: Container(
          height: 140,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    widget.iconPath,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Text(
                    widget.subjectName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontFamily: 'ElMessiri'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
