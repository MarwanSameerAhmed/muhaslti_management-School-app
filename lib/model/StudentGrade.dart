
class StudentGrade { 
  int ID;
  String studentName;
  String subjectName;
  String yearName;
  String levelName;

  StudentGrade({
    required this.ID,
    required this.studentName,
    required this.subjectName,
    required this.yearName,
    required this.levelName
  });

  factory StudentGrade.fromMap(Map<String, dynamic> studentGrade) {
    return StudentGrade(
        ID: int.parse(studentGrade['ID']),
        studentName: studentGrade['studentName'],
        subjectName: studentGrade['subjectName'],
        yearName: studentGrade['yearName'],
        levelName: studentGrade['levelName']);
  }
}

