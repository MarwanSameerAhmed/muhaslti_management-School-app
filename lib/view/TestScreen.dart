import 'dart:ui';
import 'package:fancy_avatar/fancy_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/model/Employee.dart';
import 'package:muhaslti/model/Student.dart';
import 'package:muhaslti/model/StudentGrade.dart';
import 'package:muhaslti/view/CreateEmployee1.0.dart';
import 'package:muhaslti/view/CreateNewTask.dart';
import 'package:muhaslti/view/CreateStudent1.0.dart';
import 'package:muhaslti/view/DrawerPage.dart';
import 'package:muhaslti/view/Generalization.dart';
import 'package:muhaslti/view/ListofEmployees.dart';
import 'package:muhaslti/view/ListofStudent.dart';
import 'package:muhaslti/view/ShowStudentTremGrade.dart';
import 'package:muhaslti/view/ShowSubject1.0.dart';
import 'package:muhaslti/view/activityFrom.dart';
import 'package:muhaslti/view/loadingPage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

// ignore: camel_case_types
class _Splash_ScreenState extends State<Splash_Screen> {
  final List<Map<String, String>> subjects = [
    {'name': 'القران الكريم', 'icon': 'images/koran.png'},
    {'name': 'التربية الاسلامية', 'icon': 'images/quran (1).png'},
    {'name': 'اللغة العربية', 'icon': 'images/ya.png'},
    {'name': 'اللغة الانجليزية', 'icon': 'images/english.png'},
    {'name': 'علوم', 'icon': 'images/book (1).png'},
    {'name': 'رياضيات', 'icon': 'images/maths.png'},
    {'name': 'اجتماعيات', 'icon': 'images/book (2).png'},
  ];
  final String imageUrl = 'images/2024_04_11_15_19_IMG_6269.JPG';
  bool builded = false;
  @override
  Widget build(BuildContext context) {
    Employee employee = Provider.of<Employee>(context);

    if (!builded) {
      Fluttertoast.showToast(
        msg: ' مرحباً ${employee.getTypeNames()}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightBlue[50],
        textColor: Colors.black,
        fontSize: 16.0,
      );

      builded = true;
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: CustomScrollView(slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 50.0,
                automaticallyImplyLeading: false, // لإخفاء زر الرجوع
                backgroundColor: Colors.transparent,
                floating: true,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 10, right: 10, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DrawerPageSetting(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: const Icon(Icons.settings),
                              ),
                            ),
                            const Text(
                              "محصلتي",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 255, 254, 254),
                              ),
                              child: const Icon(Icons.send_and_archive_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 0),
                    Center(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        margin: const EdgeInsets.all(15),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16.0, bottom: 25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 100),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'البريد',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                        Text(
                                          ' الوارد',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenImage(
                                                imageUrl: imageUrl,
                                                imagePath: imageUrl,
                                              ),
                                            ),
                                          );
                                        },
                                        child: FancyAvatar(
                                          userImage: Image.asset(imageUrl),
                                          ringColor: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          spaceWidth: 4.5,
                                          elevation: 10.0,
                                          radius: 50,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        '${employee.employeeName}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'ElMessiri',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${employee.getTypeName()} في مدرسة محصلتي',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'ElMessiri',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 100, left: 7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'مدير',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                        Text(
                                          'عام',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
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
                                      fontWeight: FontWeight.w900,
                                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 255, 254, 254)),
                                  child: const Icon(Icons.add)),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('إضافة جديدة',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text('هذة الحقول تستخدم لاضافة طلاب',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text('او موظفين جدد او فاعلية مدرسية جديدة',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ListofEmployees(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0,
                                              right: 16,
                                              top: 16,
                                              bottom: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'قائمة الموظفين',
                                                style: TextStyle(
                                                  fontFamily: 'ElMessiri',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 165,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: FancyAvatar(
                                                  userImage: Image.asset(
                                                      'images/2024_04_11_15_19_IMG_6269.JPG'),
                                                  ringColor:
                                                      const Color.fromARGB(
                                                          255, 0, 0, 0),
                                                  elevation: 3.0,
                                                  radius: 20,
                                                ),
                                                title: const Text(
                                                  'الموظف',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontFamily: 'ElMessiri'),
                                                ),
                                                subtitle: const Text(
                                                  'تفاصيل الموظف ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'ElMessiri',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.grey),
                                                ),
                                                // trailing:
                                                //     const Icon(Icons.more_vert),
                                                // onTap: () {},
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ListofStudent(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'قائمة الطلاب',
                                                style: TextStyle(
                                                  fontFamily: 'ElMessiri',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 165,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: FancyAvatar(
                                                  userImage: Image.asset(
                                                      'images/2024_04_11_15_19_IMG_6269.JPG'),
                                                  ringColor:
                                                      const Color.fromARGB(
                                                          255, 0, 0, 0),
                                                  spaceWidth: 4.5,
                                                  elevation: 3.0,
                                                  radius: 20,
                                                ),
                                                title: const Text(
                                                  'الطالب',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontFamily: 'ElMessiri'),
                                                ),
                                                subtitle: const Text(
                                                  'تفاصيل الطالب ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'ElMessiri',
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                // trailing:
                                                //     const Icon(Icons.more_vert),
                                                // onTap: () {},
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const MyWidget(),
                                    ),
                                  );
                                },
                                child: MainCard(
                                    'images/icons8-add-user-male-skin-type-7-48.png',
                                    'إضافة موظف',
                                    Colors.white),
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateStudentNew(),
                                  ));
                                },
                                child: MainCard('images/students.png',
                                    'إضافة طالب', Colors.white),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Generalization_Page(),
                                  ));
                                },
                                child: MainCard('images/employee.png',
                                    'إضافة تعميم', Colors.white),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {},
                                child: MainCard('images/people.png',
                                    'إضافة فعالية', Colors.white),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ActivityFormPage(),
                                  ));
                                },
                                child: MainCard('images/activity.png',
                                    'إضافة نشاط', Colors.white),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateNewTask(),
                                    ),
                                  );
                                },
                                child: MainCard('images/delegation.png',
                                    'إضافة مهام', Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 255, 254, 254)),
                                  child: const Icon(Icons.book_online_rounded)),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('المواد الدراسية للطالب',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text('هذة الحقول تستخدم لاستعراض ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text('المواد الخاصة بالطالب ودرجاته',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: subjects.map((subject) {
                            return SubjectCard(
                              subjectName: subject['name']!,
                              iconPath: subject['icon']!,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 255, 254, 254)),
                                  child:
                                      const Icon(Icons.supervised_user_circle)),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('مهام المشرفين',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text(' هذة الحقول تستخدم لانشاء',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text(' الشعب وربط المعلمين بها وغيرها',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 30.0, bottom: 19.0, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                    'images/anime/Animation - 1720634681559.json',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'مشرفين المراحل',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri'),
                                      ),
                                      const Text(
                                        'يضمنون دقة عمل المعلمين',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri'),
                                      ),
                                      const Text(
                                        ' لتحسين جودة التعليم',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey,
                                            fontFamily: 'ElMessiri'),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(80))),
                                        child: const Text('بدء العمل',
                                            style: TextStyle(
                                                fontFamily: 'ElMessiri',
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 255, 254, 254)),
                                  child: const Icon(Icons.work_rounded)),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('اعمال المعلمين',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'يدخلون الدرجات بدقة ويعدّون تقارير الأداء',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                Text('لتعزيز تقدم الطلاب الأكاديمي',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'ElMessiri')),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 40.0, bottom: 19.0, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                    'images/anime/Animation - 1721417615259 (1).json',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'معلمين المراحل',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri'),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'يضمنون دقة عمل المعلمين',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'ElMessiri'),
                                      ),
                                      const Text(
                                        ' لتحسين جودة التعليم',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey,
                                            fontFamily: 'ElMessiri'),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(80))),
                                        child: const Text('بدء العمل',
                                            style: TextStyle(
                                                fontFamily: 'ElMessiri',
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }

  Widget MainCard(String Vector, String Title, Color color) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 19.0, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Title,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'ElMessiri'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(Vector, width: 30, height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildFutureGrideView(Employee employee) {
  //   return FutureBuilder<List<StudentGrade>>(
  //       future: employee.getStudentGrades(student.ID),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           studentGrade = snapshot.data ?? [];
  //         } else {
  //           LoadingScreen();
  //         }
  //         return buildRowView();
  //       });
  // }

  // Widget buildRowView() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: List.generate(studentGrade.length, (index) {
  //         return InkWell(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ShowStudentTermGrade(
  //                   studentGrade[index].ID,
  //                   studentGrade[index].subjectName,
  //                 ),
  //               ),
  //             );
  //           },
  //           child: Container(
  //             width: 150, // يمكنك تعديل العرض حسب الحاجة
  //             margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //               boxShadow: const [
  //                 BoxShadow(
  //                   color: Color.fromARGB(131, 0, 0, 0),
  //                   spreadRadius: 1,
  //                   blurRadius: 6,
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Image.asset(
  //                   getImage(studentGrade[index].subjectName),
  //                   height: 60.0,
  //                 ),
  //                 const SizedBox(height: 10.0),
  //                 Text(
  //                   studentGrade[index].subjectName,
  //                   style: const TextStyle(
  //                     fontSize: 16.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }

  // String getImage(String subjectName) {
  //   return ((images.containsKey(subjectName))
  //           ? images[subjectName]
  //           : 'images/image-1.jpg') ??
  //       'images/image-1.jpg';
  // }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  FullScreenImage({required this.imagePath, required String imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: AssetImage(imagePath),
        ),
      ),
    );
  }
}
