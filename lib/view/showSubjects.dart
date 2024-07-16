import 'package:flutter/material.dart';
import 'package:muhaslti/controller/constants.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/Student.dart';
import 'package:muhaslti/model/StudentGrade.dart';
import 'package:muhaslti/view/ShowStudentTremGrade.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:provider/provider.dart';

class ShowSubjects extends StatefulWidget {
  ShowSubjects({required this.student});
  final Student student;

  @override
  State<ShowSubjects> createState() => _ShowSubjectsState(student: student);
}

class _ShowSubjectsState extends State<ShowSubjects> {
  late Color myColor;
  _ShowSubjectsState({required this.student});
  final Student student;
  List<StudentGrade> studentGrade = [];

  final Map<String, String> images = {
    'قران كريم':'images/quran.png',
    'تربية اسلامية':'images/islamic.png',
    'لغة عربية':'images/ain.png',
    'لغة انجليزية':'images/language.png',
    'رياضيات':'images/book.png',
    'علوم':'images/image-4.jpg',
    'اجتماعيات':'images/world-book-day.png'
};

  @override
  Widget build(BuildContext context) {
    myColor = Theme
        .of(context)
        .primaryColor;
    Employee employee = Provider.of<Employee>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: myColor,
          elevation: 0,
          centerTitle: false,
        ),
        backgroundColor: myColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image(
                      image: AssetImage('images/student.png'),
                      width: 100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${widget.student.studentName} ',
                        style: const TextStyle(
                          fontSize: 23.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      Text(
                        ' المرحلة :  ${widget.student.levelName}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      Text(
                        ' السنة :   ${widget.student.yearName}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      Text(
                        ' الشعبة :  ${widget.student.className}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: const Text(
                  'المواد الدراسية',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(250, 109, 109, 104),
                                offset: Offset(0, -2),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: buildFutureGrideView(employee)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFutureGrideView(Employee employee) {
    return FutureBuilder<List<StudentGrade>>(
        future: employee.getStudentGrades(student.ID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            studentGrade = snapshot.data ?? [];
          }
          else {
            LoadingScreen();
          }
          return buildGrideView();
        }
    );
  }

  Widget buildGrideView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: studentGrade.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ShowStudentTermGrade(studentGrade[index].ID, studentGrade[index].subjectName),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(131, 0, 0, 0),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  getImage(studentGrade[index].subjectName),
                  height: 80.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  studentGrade[index].subjectName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getImage(String subjectName) {
    return ((images.containsKey(subjectName))
        ? images[subjectName]
        : 'images/image-1.jpg') ?? 'images/image-1.jpg';
  }
}
