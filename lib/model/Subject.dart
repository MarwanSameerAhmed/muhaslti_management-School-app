class Subject {
  int ID;
  String levelName;
  String SubjectName;

  Subject(this.ID, this.levelName, this.SubjectName);

  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "levelName": levelName,
      "SubjectName": SubjectName,
    };
  }
}
