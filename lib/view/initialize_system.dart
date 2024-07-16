import 'package:flutter/material.dart';
import 'package:muhaslti/model/Level.dart';

// ignore: must_be_immutable
class InitializeSystem extends StatefulWidget {
  const InitializeSystem({Key? key}) : super(key: key);

  @override
  _InitializeSystemState createState() => _InitializeSystemState();
}

class _InitializeSystemState extends State<InitializeSystem> {
  TextEditingController addNewClass = TextEditingController();
  late Color myColor;
  late Color mysColor;
  var height, width;

  List images = [];

  List titles = [
    "إنشاء شعبة",
    "ربط المعلم",
    "ربط المرحلة",
    "ربط الطلاب",
  ];

  List<String> levels = ['first', 'second', 'third'];
  List<String> classes = ['A', 'B', 'C'];
  String? selectedClass = 'A';
  String? selected = 'first';
  int x = 0, y = 0;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mysColor = Theme.of(context).primaryColorDark;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: myColor,
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              width: width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.animation,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تهيئة النظام',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ElMessiri'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              height: height * 0.75,
              width: width,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  //----------------------------- CONTAINER 1 ( Create Class Button ) -----------------------------------
                  //----------------------------- POPUP -----------------------------
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                      color: Colors.white70, width: 2.0),
                                ),
                                title: Text(
                                  'إنشاء شعبة',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                                actions: [
                                  Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //----------------------------- Drop Down List 1 (Level) -----------------------------
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: SizedBox(
                                            width: 110,
                                            child: Expanded(
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  labelText: ('اختيار مرحلة'),
                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'ElMessiri'),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: myColor),
                                                  ),
                                                ),
                                                value: selected,
                                                items: levels
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                          value: item,
                                                          child: Text(item),
                                                        ))
                                                    .toList(),
                                                onChanged: (item) =>
                                                    setState(() {
                                                  () => selected = item;
                                                }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0,
                                        ),
                                        //----------------------------- Drop Down List 2 (Class) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Expanded(
                                            child: SizedBox(
                                                width: 90,
                                                child: TextFormField(
                                                  controller: addNewClass,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    labelText: ('اضافة شعبة'),
                                                                                                      labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: myColor,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        createCalss(levels.indexOf(selected!),
                                            selectedClass!);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 10,
                                        shadowColor: myColor,
                                        minimumSize: const Size(90, 40),
                                      ),
                                      child: const Text(
                                        "انشاء",
                                        style:
                                            TextStyle(fontFamily: 'ElMessiri'),
                                      ),
                                    ),
                                  ])
                                ],
                              ));
                    },
                    //----------------------------- Container 1 Properties (Create Class) -----------------------------
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(131, 0, 0, 0),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/teacher.png',
                            width: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              titles[0],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 79, 75, 75),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //----------------------------- CONTAINER 2 (Link Teacher)-----------------------------------
                  //----------------------------- POPUP -----------------------------
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                      color: Colors.white70, width: 2.0),
                                ),
                                title: Text(
                                  'ربط المعلم',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                                actions: [
                                  Column(children: [
                                    Column(
                                      children: [
                                        //----------------------------- Drop Down List 1 (Level) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار مرحلة'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myColor),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),

                                        //----------------------------- Drop Down List 2 (Class) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار شعبة'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: myColor,
                                                  ),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),

                                        //----------------------------- Drop Down List 3 (Subject) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار مادة'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: myColor,
                                                  ),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //----------------------------- CREATE Button 2 -----------------------------
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 10,
                                        shadowColor: myColor,
                                        minimumSize: const Size(90, 40),
                                      ),
                                      child: const Text(
                                        "ربط",
                                        style:
                                            TextStyle(fontFamily: 'ElMessiri'),
                                      ),
                                    ),
                                  ])
                                ],
                              ));
                    },
                    //----------------------------- Container 2 Properties (Link Teacher) -----------------------------
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(131, 0, 0, 0),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/employee.png',
                            width: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              titles[1],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 79, 75, 75),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //----------------------------- CONTAINER 3 (Link Level) -----------------------------
                  //----------------------------- POPUP -----------------------------
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                      color: Colors.white70, width: 2.0),
                                ),
                                title: Text(
                                  'ربط مرحلة',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                                actions: [
                                  Column(children: [
                                    Column(
                                      children: [
                                        //----------------------------- Drop Down List 1 (Teacher) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار استاذ'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myColor),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),

                                        //----------------------------- Drop Down List 2 (Level) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار مشرف'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: myColor,
                                                  ),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //----------------------------- CREATE Button 3 -----------------------------
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 10,
                                        shadowColor: myColor,
                                        minimumSize: const Size(90, 40),
                                      ),
                                      child: const Text(
                                        "ربط",
                                        style:
                                            TextStyle(fontFamily: 'ElMessiri'),
                                      ),
                                    ),
                                  ])
                                ],
                              ));
                    },
                    //----------------------------- Container 3 Properties (Link Level) -----------------------------
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(131, 0, 0, 0),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/link.png',
                            width: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              titles[2],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 79, 75, 75),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //----------------------------- CONTAINER 4 (Link Student) -----------------------------
                  //----------------------------- POPUP -----------------------------
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                      color: Colors.white70, width: 2.0),
                                ),
                                title: Text(
                                  'ربط طلاب',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                                actions: [
                                  Column(children: [
                                    Column(
                                      children: [
                                        //----------------------------- Drop Down List 1 (Student) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار طلاب'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myColor),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),

                                        //----------------------------- Drop Down List 2 (Level) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار مرحلة'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: myColor,
                                                  ),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),
                                        //----------------------------- Drop Down List 3 (Class) -----------------------------
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 250,
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                label: Text('اختيار شعبة'),
                                                                                                  labelStyle: TextStyle(fontFamily: 'ElMessiri'),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: myColor,
                                                  ),
                                                ),
                                              ),
                                              value: selected,
                                              items: levels
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(() {
                                                () => selected = item;
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //----------------------------- CREATE Button 4 -----------------------------
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 10,
                                        shadowColor: myColor,
                                        minimumSize: const Size(90, 40),
                                      ),
                                      child: const Text(
                                        "ربط",
                                        style:
                                            TextStyle(fontFamily: 'ElMessiri'),
                                      ),
                                    ),
                                  ])
                                ],
                              ));
                    },
                    //----------------------------- Container 4 Properties -----------------------------
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(131, 0, 0, 0),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/student.png',
                            width: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              titles[3],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 79, 75, 75),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createCalss(int levelID, String className) {
    print(levelID.toString() + className);
  }
}
