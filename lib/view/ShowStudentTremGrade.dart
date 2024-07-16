import 'package:flutter/material.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/TermGrade.dart';
import 'package:muhaslti/view/ShowStudentMonthGrade.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:provider/provider.dart';

class ShowStudentTermGrade extends StatefulWidget {
  int studentTermGradeID;
  String subject;

  ShowStudentTermGrade(this.studentTermGradeID , this.subject,{super.key});
  @override
  State<ShowStudentTermGrade> createState() => _ShowStudentTermGradeState(studentTermGradeID, subject);
}

class _ShowStudentTermGradeState extends State<ShowStudentTermGrade> {
  late Color myColor;
  String subject;
  List<TermGrade> termGrade = [];

  int studentTermGradeID;

  _ShowStudentTermGradeState(this.studentTermGradeID, this.subject);

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    Employee employee = Provider.of<Employee>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 255, 255, 255),
                    width: 5,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: myColor),
              padding: EdgeInsets.all(8),
              child: Text(
                "درجات الفصول الدراسية",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
            buildFutureListView(employee)
          ]),
        ),
      ),
    );
  }

  Widget buildFutureListView(Employee employee) {
    return  FutureBuilder<List<TermGrade>>(
        future: employee.getTermGrade(studentTermGradeID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            termGrade = snapshot.data ?? [];
          }
          else {
            return LoadingScreen();
          }
          return buildListView();
        }
    );
  }

  Widget buildListView() {
    return  ListView.builder(
        shrinkWrap: true,
        itemCount: termGrade.length,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final grade = termGrade[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowStudentMonthGrade(grade.ID, subject),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                  color: Color.fromARGB(46, 0, 0, 0),
                  width: 1,
                ),
              ),
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "الترم : ${grade.termNumber}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "الاختبار النهائي للفصل الاول :",
                      style: TextStyle(fontFamily: "ElMessiri"),
                    ),
                    subtitle: Text('${grade.finalTest}'),
                    leading: Image(
                      image: AssetImage('images/homework.png'),
                      width: 40,
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Color.fromARGB(108, 0, 0, 0),
                    indent: 60,
                    endIndent: 0,
                    thickness: 0.2,
                  ),
                  ListTile(
                    title: Text(
                      " محصلة الشهر الاول  :",
                      style: TextStyle(fontFamily: 'ElMessiri'),
                    ),
                    subtitle: Text('${grade.totalMonthGrade}'),
                    leading: Image(
                      image: AssetImage('images/roll-call.png'),
                      width: 40,
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Color.fromARGB(108, 0, 0, 0),
                    indent: 60,
                    endIndent: 0,
                    thickness: 0.2,
                  ),
                  Divider(
                    height: 0,
                    color: Color.fromARGB(108, 0, 0, 0),
                    indent: 60,
                    endIndent: 0,
                    thickness: 0.2,
                  ),
                  ListTile(
                    title: Text(
                      "التفعيل: ",
                      style: TextStyle(fontFamily: 'ElMessiri'),
                    ),
                    subtitle: Text('${grade.active.toString()}'),
                    leading: Image(
                      image: AssetImage('images/student.png'),
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
