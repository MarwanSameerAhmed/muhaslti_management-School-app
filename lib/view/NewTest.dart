import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Grade {
  String name;
  String oral;
  String homework;
  String written;
  String behavior;

  Grade(this.name, this.oral, this.homework, this.written, this.behavior);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Grade> grades = [
    Grade('Student 1', 'A', 'B', 'C', 'A'),
    Grade('Student 2', 'B', 'A', 'B', 'B'),
  ];

  void _editGrade(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final oralController = TextEditingController(text: grades[index].oral);
        final homeworkController = TextEditingController(text: grades[index].homework);
        final writtenController = TextEditingController(text: grades[index].written);
        final behaviorController = TextEditingController(text: grades[index].behavior);

        return AlertDialog(
          title: Text('Edit Grade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: oralController, decoration: InputDecoration(labelText: 'Oral')),
              TextField(controller: homeworkController, decoration: InputDecoration(labelText: 'Homework')),
              TextField(controller: writtenController, decoration: InputDecoration(labelText: 'Written')),
              TextField(controller: behaviorController, decoration: InputDecoration(labelText: 'Behavior')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  grades[index].oral = oralController.text;
                  grades[index].homework = homeworkController.text;
                  grades[index].written = writtenController.text;
                  grades[index].behavior = behaviorController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteGrade(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this grade?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  grades.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student Grades'),
        ),
        body: ListView(
          children: grades.asMap().entries.map((entry) {
            int index = entry.key;
            Grade grade = entry.value;
            return ExpansionTile(
              backgroundColor: Colors.grey[200],
              collapsedBackgroundColor: Colors.blue[50],
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.expand_more, color: Colors.white),
              ),
              title: Text(grade.name,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              children: [
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text('Oral: ${grade.oral}',
                        style: TextStyle(color: Colors.black)),
                    subtitle: Text(
                        'Homework: ${grade.homework}\nWritten: ${grade.written}\nBehavior: ${grade.behavior}',
                        style: TextStyle(color: Colors.black)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () => _editGrade(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteGrade(index),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}