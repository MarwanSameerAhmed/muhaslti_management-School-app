import 'package:flutter/material.dart';

class CreateEvetSchool extends StatefulWidget {
  const CreateEvetSchool({super.key});

  @override
  State<CreateEvetSchool> createState() => _CreateEvetSchoolState();
}

class _CreateEvetSchoolState extends State<CreateEvetSchool> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Card(
              child: Column(
                children: [
                  Image.asset('images/ain.png'),
                  Text(
                    'ali',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.amberAccent,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
