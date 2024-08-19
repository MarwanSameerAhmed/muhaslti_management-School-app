import 'dart:convert';
import 'dart:ffi';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:muhaslti/api/MSTRequst.dart';
import 'package:muhaslti/api/employee/EmployeeRequest.dart';
import 'package:muhaslti/api/employee/EmployeeResponse.dart';
import 'package:muhaslti/api/login_response.dart';
import 'package:muhaslti/api/mst_response.dart';
import 'package:muhaslti/api/student/StudentResponse.dart';
import 'package:muhaslti/api/student/studentReqest.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/view/CreateStudent1.0.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/main.dart';

class ClientController extends GetxController{
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

  // Future<String?> getAuthToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('auth_token');
  // }

  // Future<void> someApiRequest() async {
  //   String? token = await getAuthToken();
  //   if (token == null) {
  //     throw Exception("No auth token found");
  //   }
  // }

  // Future<MSTResponse?> request2(MSTRequst request) async {
  //   String sUrl = 'http://192.168.0.111:5000/api';
  //   if (request is Studentreqest) {
  //     sUrl += '/Student/Create';
  //   }
  //   var url = Uri.parse(sUrl);

  //   try {
  //     String? token = await getAuthToken();

  //     var headers = {
  //       'Content-Type': 'application/json',
  //       if (token != null) 'Authorization': 'Bearer $token',
  //     };

  //     // إرسال الطلب
  //     var response = await http.post(
  //       url,
  //       body: jsonEncode(request.toMap()),
  //       headers: headers,
  //     );
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       if (response.body.contains("MessageDescription")) {
  //         Map<String, dynamic> result = jsonDecode(response.body);
  //         MSTResponse? response2 = null;
  //         if (request is Studentreqest)
  //           response2 = StudentResponse.fromMap(result);
  //         if (response2 == null) {
  //           throw Exception("Unknown exception");
  //         }
  //         if (response2.responseCode == "1") {
  //           return response2;
  //         } else {
  //           throw Exception(response2.messageDescription);
  //         }
  //       } else {
  //         throw Exception("Unexpected response format: ${response.body}");
  //       }
  //     } else {
  //       throw Exception(
  //           "HTTP request failed with status: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print('Request failed: $e');
  //     rethrow;
  //   }
  // }

  static Future<LoginResponse?> login(String username, String password) async {
    var url = Uri.parse('http://192.168.0.111:5000/api/Authentication');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
    });
    if (response == null) {
      throw Exception("Unknow exception");
    } else if (response.body.contains("MessageDescription")) {
      // في حالة تم الإتصال بالـ API
      Map<String, dynamic> result = jsonDecode(response.body);
      LoginResponse loginResponse = LoginResponse.fromMap(result);
      if (loginResponse.responseCode == "1") {
        String token = loginResponse.token!;
        await TokenManager.saveToken(token);
        return loginResponse;
      } else {
        // في حالة حدوث اي خطأ
        throw Exception(loginResponse.messageDescription);
      }
    } else {
      throw Exception(response.body);
    }
  }

  Future<MSTResponse?> MainRequest(MSTRequst request) async {
  String sUrl = 'http://192.168.0.111:5000/api';
  if (request is Studentreqest) {
    sUrl += '/Student/Create';
  } else if (request is EmployeeRequest) {
    sUrl += '/Employee/Create';
  } else {
    throw Exception("Unsupported request type");
  }
  
  var url = Uri.parse(sUrl);

  try {
    String? token = await TokenManager.getToken();

    var headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    var response = await http.post(
      url,
      body: jsonEncode(request.toMap()),
      headers: headers,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body.contains("MessageDescription")) {
      Map<String, dynamic> result = jsonDecode(response.body);
      MSTResponse? responseObj = null;

      if (request is Studentreqest) {
        responseObj = StudentResponse.fromMap(result);
      } else if (request is EmployeeRequest) {
        responseObj = EmployeeResponse.fromMap(result);
      }

      if (responseObj == null) {
        throw Exception("Unknown exception");
      }
      if (responseObj.responseCode == "1") {
        return responseObj;
      } else {
        throw Exception(responseObj.messageDescription);
      }
    } else {
      throw Exception("Unexpected response format: ${response.body}");
    }
  } catch (e) {
    print('Request failed: $e');
    rethrow;
  }
}

  // static Future<String> login(String username, String password) async {
  //   Map<String, dynamic> data = {"username": username, "password": password};
  //   String response = await request("login", jsonEncode(data));
  //   if (int.tryParse(response) != null) {
  //     response = _createErrorJson(int.parse(response));
  //   }
  //   return response;
  // }

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
