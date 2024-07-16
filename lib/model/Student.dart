class Student {
  int ID;
  String yearName;
  String levelName;
  String className;
  String parentName;
  String studentName;
  DateTime birthDate;
  bool active;

  Student(
     this.ID,
     this.yearName,
     this.levelName,
     this.className,
     this.parentName,
     this.studentName,
     this.birthDate,
     this.active,
  );

  factory Student.fromMap(Map<String, dynamic> student) {
    return Student(
        int.parse(student['ID']),
        student['yearName'],
        student['levelName'],
        student['className']??"",
        student['parentName'],
        student['studentName'],
        DateTime.parse(student['birthDate']),
        student['active']=="1");
  }

}



