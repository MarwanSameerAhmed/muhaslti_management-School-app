import 'package:muhaslti/api/MSTRequst.dart';

class Studentreqest extends MSTRequst {
  String? RequestID;
  String? StudentFullName;
  String? ParentName;
  String? ParentPhoneNumber;
  String? LevelNumber;
  String? StudentBirthDate;

  Studentreqest(
      {required this.RequestID,
      required this.StudentFullName,
      required this.ParentName,
      required this.ParentPhoneNumber,
      required this.LevelNumber,
      required this.StudentBirthDate});

  Map<String, dynamic> toMap() {
    return {
      "RequestID": RequestID ?? "",
      "StudentFullName": StudentFullName ?? "",
      "ParentName": ParentName ?? "",
      "ParentPhoneNumber": ParentPhoneNumber ?? "",
      "LevelNumber": LevelNumber ?? "",
      "StudentBirthDate": StudentBirthDate ?? "",
    };
  }
  
  
}
