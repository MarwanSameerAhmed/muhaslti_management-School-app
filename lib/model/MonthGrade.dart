class MonthGrade {
  int ID;
  int termNumber;
  int monthNumber;
  double homework;
  double attendance;
  double oralTest;
  double writtenTest;
  bool active;

  MonthGrade(this.ID, this.termNumber, this.monthNumber, this.homework, this.attendance,
      this.oralTest, this.writtenTest, this.active);


  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "termNumber": termNumber,
      "homework": homework,
      "attendance": attendance,
      "oralTest": oralTest,
      "writtennTest": writtenTest,
      "active": active,
    };
  }

  factory MonthGrade.fromMap(Map<String, dynamic> monthGrade) {
    return MonthGrade(
      int.parse(monthGrade['ID']),
      int.parse(monthGrade['termNumber']),
      int.parse(monthGrade['monthNumber']),
      double.parse(monthGrade['homework']),
      double.parse(monthGrade['attendance']),
      double.parse(monthGrade['oralTest']),
      double.parse(monthGrade['writtenTest']),
      monthGrade['active'].toString() == "1"
    );
  }
}
