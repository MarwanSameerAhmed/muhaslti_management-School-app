import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muhaslti/model/Employee.dart';
import '../view/main.dart';

class ClientController {
  static Future<String> request(String method, String data) async {
    String ip = Settings.settings.containsKey('ip')
        ? Settings.settings['ip']
        : "localhost";
    // var url = Uri.parse(
    //     'http://192.168.43.121/server/server_controller.php?method=$method&data=$data');
    var parameters = {'method': method, 'data': data};
    var url = Uri.http(ip, "server/server_controller.php", parameters);
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "1";
      }
    } catch (e) {
      return "1";
    }
  }

  static Future<String> login(String username, String password) async {
    Map<String, dynamic> data = {"username": username, "password": password};
    String response = await request("login", jsonEncode(data));
    if (int.tryParse(response) != null) {
      response = _createErrorJson(int.parse(response));
    }
    return response;
  }

  static String _createErrorJson(int errorCode) =>
      '{"error_code":$errorCode, "data":"null"}';

  static Future<String> getEmployee(int ID) async {
    return await request("get_employee", jsonEncode(ID));
  }

  static getEmployees() async {
    return await request("get_employees", "null");
  }

  static getLevels(Employee employee) async {
    return await request("get_levels",
        '{"ID":${employee.ID},  "IDCardNumber":"${employee.IDCardNumber}",  "employeeName":"${employee.employeeName}", "type":${employee.getType()}}');
  }

  static getClasses(Employee employee) async {
    return await request("get_classes",
        '{"ID":${employee.ID},  "IDCardNumber":"${employee.IDCardNumber}",  "employeeName":"${employee.employeeName}", "type":${employee.getType()}}');
  }

  static getStudents(int userID, int classID, bool isEmployee) async {
    return await request("get_students",
        '{"userID":$userID,  "classID":"$classID",  "isEmployee":${(isEmployee) ? 1 : 0}}');
  }

  static Future<String> createEmployee(Employee newEmployee) async {
    return await request('create_employee',
        '{"ID":-1,  "IDCardNumber":"${newEmployee.IDCardNumber}",  "employeeName":"${newEmployee.employeeName}", "type":${newEmployee.getType()}}');
  }

  static Future<String> createStudent(int levelID, String parentName,
      String phoneNumber, String studentName, String birthDate) async {
    return await request("create_student",
        '{"levelID":$levelID, "parentName":"$parentName", "parentPhone":"$phoneNumber", "studentName":"$studentName", "birthdate":"$birthDate"}');
  }

  static Future<String> getStudentGrades(int studentID, int employeeID) async {
    return await request("get_student_grades",
        '{"studentID":$studentID, "employeeID":$employeeID}');
  }

  static Future<String> getTermGrades(int studentGradeID) async {
    return await request("get_term_grades", '$studentGradeID');
  }

  static Future<String> getMonthGrades(int termGradeID) async {
    return await request("get_month_grades", '$termGradeID');
  }

  static updateMonthGrades(int monthGradeID, double homework, double attendance,
      double oralTest, double writtenTest) async {
    await request("update_month_grade",
        '{"monthGradeID":$monthGradeID, "homework":$homework, "attendance":$attendance, "oralTest":$oralTest, "writtenTest":$writtenTest}');
  }
}
