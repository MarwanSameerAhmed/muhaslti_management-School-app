import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:muhaslti/controller/client_controller.dart';
import 'package:muhaslti/model/StudentGrade.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Class.dart';
import 'Level.dart';
import 'MonthGrade.dart';
import 'Student.dart';
import 'TermGrade.dart';

enum EmployeeType { manager, registrar, supervisor, teacher, none }

extension EmployeeTypeExtension on EmployeeType {
  String get name {
    switch (this) {
      case EmployeeType.manager:
        return 'مدير تنفيذي';
      case EmployeeType.registrar:
        return 'مسجل معتمد';
      case EmployeeType.supervisor:
        return 'مشرف مدرسي';
      case EmployeeType.teacher:
        return 'مدرس عام';
      case EmployeeType.none:
        return 'غير محدد';
    }
  }
}

extension EmployeeTypeExtensions on EmployeeType {
  String get names {
    switch (this) {
      case EmployeeType.manager:
        return 'يا مدير ';
      case EmployeeType.registrar:
        return 'يا مسجل';
      case EmployeeType.supervisor:
        return 'يا مشرف';
      case EmployeeType.teacher:
        return 'يا معلم';
      case EmployeeType.none:
        return 'غير محدد';
    }
  }
}

class Employee extends ChangeNotifier {
  int ID;
  String IDCardNumber;
  String employeeName;
  EmployeeType type;

  Employee(
      {required this.ID,
      required this.employeeName,
      required this.IDCardNumber,
      required this.type});

  String getTypeName() {
    return type.name;
  }

  String getTypeNames() {
    return type.names;
  }

  factory Employee.fromMap(Map<String, dynamic> employee) {
    EmployeeType employeeType = EmployeeType.none;
    int? type = int.tryParse(employee['type']);
    type ??= 0;
    switch (type) {
      case 1:
        employeeType = EmployeeType.manager;
        break;
      case 2:
        employeeType = EmployeeType.registrar;
        break;
      case 3:
        employeeType = EmployeeType.supervisor;
        break;
      case 4:
        employeeType = EmployeeType.teacher;
        break;
    }
    return Employee(
        ID: int.parse(employee['ID']),
        employeeName: employee['employeeName'],
        IDCardNumber: employee['IDCardNumber'],
        type: employeeType);
  }

  int getType() {
    int type;
    switch (this.type) {
      case EmployeeType.manager:
        type = 1;
        break;
      case EmployeeType.registrar:
        type = 2;
        break;
      case EmployeeType.supervisor:
        type = 3;
        break;
      case EmployeeType.teacher:
        type = 4;
        break;
      case EmployeeType.none:
        type = 0;
        break;
    }
    return type;
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "IDCardNumber": IDCardNumber,
      "employeeName": employeeName,
      "type": type,
    };
  }

  static Color color = Colors.blue;
  void setColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int c = prefs.getInt('c') ?? 1;

    switch (c) {
      case 1:
        color = Colors.blue;
      case 2:
        color = Colors.deepPurple;
      case 3:
        color = Colors.deepOrangeAccent;
      case 4:
        color = Colors.amber;
    }
  }

  void updateColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int c = prefs.getInt('c') ?? 1;
    if (c < 4) {
      c++;
    } else {
      c = 1;
    }
    prefs.setInt('c', c);
    setColor();
    notifyListeners();
  }

  void updateEmployee(Employee employee) {
    ID = employee.ID;
    IDCardNumber = employee.IDCardNumber;
    employeeName = employee.employeeName;
    type = employee.type;
    notifyListeners();
  }

  static Future<Employee> byID(int ID) async {
    String result = await ClientController.getEmployee(ID);
    if (result == "" || int.tryParse(result) != null) {
      return emptyEmployee;
    } else {
      Map<String, dynamic> employee = jsonDecode(result);
      return Employee.fromMap(employee);
    }
  }

  Future<List<Level>> getLevels() async {
    List<Level> levels = [];
    String result = await ClientController.getLevels(this);
    if (result.isEmpty || int.tryParse(result) != null) return levels;

    List<dynamic> lsLevels = jsonDecode(result);
    if (lsLevels.isEmpty) return levels;

    levels = List.generate(
        lsLevels.length, (index) => Level.fromMap(lsLevels[index]));
    return levels;
  }

  Future<List<Class>> getClasses() async {
    List<Class> classes = [];
    String result = await ClientController.getClasses(this);
    if (result.isEmpty || int.tryParse(result) != null) return classes;

    List<dynamic> lsClasses = jsonDecode(result);
    if (lsClasses.isEmpty) return classes;

    classes = List.generate(
        lsClasses.length, (index) => Class.fromMap(lsClasses[index]));
    return classes;
  }

  Future<List<Student>> getStudents(int classID) async {
    List<Student> students = [];
    String result = await ClientController.getStudents(this.ID, classID, true);
    if (result.isEmpty || int.tryParse(result) != null) return students;

    List<dynamic> lsStudents = jsonDecode(result);
    if (lsStudents.isEmpty) return students;

    students = List.generate(
        lsStudents.length, (index) => Student.fromMap(lsStudents[index]));
    return students;
  }

  static final Employee emptyEmployee = Employee(
      ID: -1, employeeName: "", IDCardNumber: "", type: EmployeeType.none);

  Future<void> createStudent(int levelID, String parentName, String phoneNumber,
      String studentName, String birthDate,
      {required Function(int result) onResult}) async {
    String result = await ClientController.createStudent(
        levelID, parentName, phoneNumber, studentName, birthDate);
    if (result.isEmpty) result = '1';
    onResult(int.parse(result));
  }

  Future<List<StudentGrade>> getStudentGrades(int id) async {
    List<StudentGrade> studentGrades = [];
    String result = await ClientController.getStudentGrades(id, ID);
    if (result.isEmpty || int.tryParse(result) != null) return studentGrades;

    List<dynamic> lsStudentGrades = jsonDecode(result);
    if (lsStudentGrades.isEmpty) return studentGrades;

    studentGrades = List.generate(lsStudentGrades.length,
        (index) => StudentGrade.fromMap(lsStudentGrades[index]));
    return studentGrades;
  }

  Future<List<TermGrade>> getTermGrade(int studentTermGradeID) async {
    List<TermGrade> termGrades = [];
    String result = await ClientController.getTermGrades(studentTermGradeID);
    if (result.isEmpty || int.tryParse(result) != null) return termGrades;

    List<dynamic> lsTermGrades = jsonDecode(result);
    if (lsTermGrades.isEmpty) return termGrades;

    termGrades = List.generate(
        lsTermGrades.length, (index) => TermGrade.fromMap(lsTermGrades[index]));
    return termGrades;
  }

  Future<List<MonthGrade>> getMonthGrade(int termGradeID) async {
    List<MonthGrade> monthGrades = [];
    String result = await ClientController.getMonthGrades(termGradeID);
    if (result.isEmpty || int.tryParse(result) != null) return monthGrades;

    List<dynamic> lsMonthGrades = jsonDecode(result);
    if (lsMonthGrades.isEmpty) return monthGrades;

    monthGrades = List.generate(lsMonthGrades.length,
        (index) => MonthGrade.fromMap(lsMonthGrades[index]));
    return monthGrades;
  }

  void updateMonthGrades(int monthGradeID, double homework, double attendance,
      double oralTest, double writtenTest) async {
    await ClientController.updateMonthGrades(
        monthGradeID, homework, attendance, oralTest, writtenTest);
  }

  // Future<List<TermGrade>> getStudentGrades(int id) async {
  //   List<StudentGrade> studentGrades = [];
  //   String result = await ClientController.getStudentGrades(id, ID);
  //   if (result.isEmpty || int.tryParse(result) != null) return studentGrades;
  //
  //   List<dynamic> lsStudentGrades = jsonDecode(result);
  //   if (lsStudentGrades.isEmpty) return studentGrades;
  //
  //   studentGrades = List.generate(lsStudentGrades.length, (index) => StudentGrade.fromMap(lsStudentGrades[index]));
  //   return studentGrades;
  // }
}
