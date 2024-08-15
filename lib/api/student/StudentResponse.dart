import 'dart:ffi';

import 'package:muhaslti/api/mst_response.dart';

class StudentResponse extends MSTResponse {
  int? StudentNumber;
  StudentResponse(
      {required super.responseCode,
      required super.messageDescription,
      required this.StudentNumber});

  factory StudentResponse.fromMap(Map<String, dynamic> studentResponse) {
    int? StudentNumber = null;
    if (studentResponse.containsKey('StudentNumber')) {
      StudentNumber = studentResponse['StudentNumber'];
    }
    return StudentResponse(
        responseCode: studentResponse['ResponseCode'],
        messageDescription: studentResponse['MessageDescription'],
        StudentNumber: StudentNumber);
  }
}
