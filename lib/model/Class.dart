
class Class {

  int ID;
  String levelName;
  String className;

  Class(this.ID,
      this.levelName,
      this.className,);


  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "levelName": levelName,
      "className": className,
    };
  }


  factory Class.fromMap(Map<String, dynamic> _class) {
    return Class(
        int.parse(_class['ID']), _class['levelName'], _class['className']);
  }
}

