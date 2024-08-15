import 'package:muhaslti/api/mst_response.dart';

class EmployeeResponse extends MSTResponse {
  int? EmployeeNumber;
  EmployeeResponse(
      {required super.responseCode,
      required super.messageDescription,
      required this.EmployeeNumber});

  factory EmployeeResponse.fromMap(Map<String, dynamic> employeeResponse) {
    int? EmployeeNumber = null;
    if (employeeResponse.containsKey('EmployeeNumber')) {
      EmployeeNumber = employeeResponse['EmployeeNumber'];
    }
    return EmployeeResponse(
        responseCode: employeeResponse['ResponseCode'],
        messageDescription: employeeResponse['MessageDescription'],
        EmployeeNumber: EmployeeNumber);
  }
}
