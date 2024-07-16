class TermGrade {
  int ID;
  String termNumber;
  String finalTest;
  String totalMonthGrade;
  bool active;

  TermGrade(this.ID, this.termNumber, this.finalTest, this.totalMonthGrade,
      this.active);

  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "termNumber": termNumber,
      "finalTest": finalTest,
      "totalMonthGrade": totalMonthGrade,
      "active": active
    };
  }

  factory TermGrade.fromMap(Map<String, dynamic> termGrade) {
    return TermGrade(
        int.parse(termGrade['ID']),
        termGrade['termNumber'],
        termGrade['finalTest'],
        termGrade['totalMonthsGrade'],
        termGrade['active'] == 1
    );
  }
}
