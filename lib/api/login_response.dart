import 'package:muhaslti/api/mst_response.dart';

class LoginResponse extends MSTResponse {
  String? token;
  String? displayName;
  bool? isEmployee;

  LoginResponse(
      {required super.responseCode,
      required super.messageDescription,
      required this.displayName,
      required this.isEmployee,
      required this.token});

  factory LoginResponse.fromMap(Map<String, dynamic> loginResponse) {
    String? token = null;
    String? displayName = null;
    bool? isEmployee = null;
    if (loginResponse.containsKey('Token')) {
      token = loginResponse['Token'];
      displayName = loginResponse['DisplayName'];
      isEmployee = loginResponse['IsEmployee'];
    }
    return LoginResponse(
        responseCode: loginResponse['ResponseCode'],
        messageDescription: loginResponse['MessageDescription'],
        displayName: displayName,
        isEmployee: isEmployee,
        token: token);
  }
}
