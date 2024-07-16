import 'package:flutter/material.dart';

class ListofEmployees extends StatefulWidget {
  const ListofEmployees({super.key});

  @override
  State<ListofEmployees> createState() => _ListofEmployeesState();
}

class _ListofEmployeesState extends State<ListofEmployees> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Card(
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 25),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.wordpress),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'قائمة الموظفين',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      const Text('أدخل الاسم أو رقم البطاقة أو رقم الهاتف أو',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ElMessiri')),
                      const Text(
                          'اختر الوظيفة من القائمة ثم اضغط على زر البحث ',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ElMessiri')),
                      const SizedBox(
                          height: 20), // لإضافة مسافة بين الكارد وشريط البحث
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'بحث...',
                            hintStyle: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
