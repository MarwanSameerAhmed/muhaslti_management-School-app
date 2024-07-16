import 'package:flutter/material.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/MonthGrade.dart';
import 'package:muhaslti/model/MonthGrade.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:provider/provider.dart';

class ShowStudentMonthGrade extends StatelessWidget {
  late Color myColor;

  List<MonthGrade> monthGrades = [];
  String subject;
  var id;

  ShowStudentMonthGrade(this.id, this.subject, {super.key});

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
                subject,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
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
    return FutureBuilder<List<MonthGrade>>(
        future: employee.getMonthGrade(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingScreen();
          }
          monthGrades = snapshot.data ?? [];
          return builListView(employee);
        }

    );
  }

  Widget builListView(Employee employee) {
    return  ListView.builder(
        shrinkWrap: true,
        itemCount: monthGrades.length,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final grade = monthGrades[index];
          TextEditingController homeworkController = TextEditingController(text: grade.homework.toString());
          TextEditingController attendanceController = TextEditingController(text: grade.attendance.toString());
          TextEditingController oralTestController = TextEditingController(text: grade.oralTest.toString());
          TextEditingController writtenTestController = TextEditingController(text: grade.writtenTest.toString());
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(
                color: Color.fromARGB(48, 0, 0, 0),
                width: 1,
              ),
            ),
            elevation: 3,
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    "الشهر: ${grade.monthNumber}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ),
                ListTile(
                  title:  TextFormField(
                    controller: homeworkController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 9),

                      labelText: 'الواجبات ',labelStyle: TextStyle(fontFamily: 'ElMessiri'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                    },
                  ),

                  leading: Image(
                    image: AssetImage('images/homework.png'),
                    width: 40,
                  ),
                ),
                Divider(
                  height: 20,
                  color: Color.fromARGB(108, 0, 0, 0),
                  indent: 60,
                  endIndent: 0,
                  thickness: 0.2,
                ),
                ListTile(
                  title: TextFormField(

                    controller: attendanceController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 9),

                      labelText: 'الحضور',labelStyle: TextStyle(fontFamily: 'ElMessiri'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                    },
                  ),
                  leading: Image(
                    image: AssetImage('images/roll-call.png'),
                    width: 40,
                  ),
                ),
                Divider(
                  height: 20,
                  color: Color.fromARGB(108, 0, 0, 0),
                  indent: 60,
                  endIndent: 0,
                  thickness: 0.2,
                ),
                ListTile(
                  title: TextFormField(
                    controller: oralTestController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 9),

                      labelText: 'الشفوي',labelStyle: TextStyle(fontFamily: 'ElMessiri'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                    },
                  ),
                  leading: Image(
                    image: AssetImage('images/book.png'),
                    width: 40,
                  ),
                ),
                Divider(
                  height: 20,
                  color: Color.fromARGB(108, 0, 0, 0),
                  indent: 60,
                  endIndent: 0,
                  thickness: 0.2,
                ),
                ListTile(
                  title: TextFormField(
                    controller: writtenTestController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 9),

                      labelText: 'التحريري ',labelStyle: TextStyle(fontFamily: 'ElMessiri'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                    },
                  ),
                  leading: Image(
                    image: AssetImage('images/test.png'),
                    width: 40,
                  ),
                ),
                Divider(
                  height: 20,
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
                Divider(
                  height: 10,
                  color: Color.fromARGB(108, 0, 0, 0),
                  indent: 60,
                  endIndent: 0,
                  thickness: 0.2,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateGrades(employee, grade.ID, homeworkController.text, attendanceController.text, oralTestController.text, writtenTestController.text, grade.active);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 10,
                    shadowColor: myColor,
                    minimumSize: const Size(150, 40),
                  ),
                  child: Text(
                    'حفظ',
                    style: TextStyle(fontFamily: 'ElMessiri'),
                  ),

                ),
                SizedBox(height: 20,)
              ],

            ),

          );
        });
  }

  void updateGrades(Employee employee, int monthGradeID, String homework, String attendance, String oralTest, String writtenTest, bool active) {
    if (!active) return;
    double? _homework = double.tryParse(homework.trim());
    double? _attendance = double.tryParse(attendance.trim());
    double? _oralTest = double.tryParse(oralTest.trim());
    double? _writtenTest = double.tryParse(writtenTest.trim());
    if (_homework == null || _attendance == null || _oralTest == null || _writtenTest == null) return;

    employee.updateMonthGrades(monthGradeID, _homework, _attendance, _oralTest, _writtenTest);

  }

}
