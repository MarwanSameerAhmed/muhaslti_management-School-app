class Level {
  int ID;
  int levelNumber;
  String levelName;
  String employeeName;

  Level(this.ID, this.levelNumber, this.levelName, this.employeeName);

  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "levelNumber": levelNumber,
      "levelName": levelName,
      "employeeName": employeeName,
    };
  }

  factory Level.fromMap(Map<String, dynamic> level) {
    return Level(int.parse(level['ID']), int.parse(level['levelNumber']), level['levelName'], level['employeeName']??"");
  }
}
