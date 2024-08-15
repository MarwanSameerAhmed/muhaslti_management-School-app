import 'package:muhaslti/api/MSTRequst.dart';

class EmployeeRequest extends MSTRequst {
  String? RequestID;
  String? EmployeeName;
  String? Username;
  String? IDCardNumber;
  String? EmployeePhoneNumber;

  EmployeeRequest({
    required this.RequestID,
    required this.EmployeeName,
    required this.Username,
    required this.IDCardNumber,
    required this.EmployeePhoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      "RequestID": RequestID ?? "",
      "EmployeeName": EmployeeName ?? "",
      "Username": Username ?? "",
      "IDCardNumber": IDCardNumber ?? "",
      "EmployeePhoneNumber": EmployeePhoneNumber ?? "",
    };
  }
}
