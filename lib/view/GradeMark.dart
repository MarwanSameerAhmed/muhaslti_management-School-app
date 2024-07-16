import 'package:fancy_avatar/fancy_avatar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/view/GradeTable.dart';
import 'package:muhaslti/view/TestScreen.dart';

class GradeStudentMark extends StatefulWidget {
  const GradeStudentMark({super.key});

  @override
  State<GradeStudentMark> createState() => _GradeStudentMarkState();
}

class _GradeStudentMarkState extends State<GradeStudentMark> {
  final String imageUrl = 'images/2024_04_11_15_19_IMG_6269.JPG';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.chat,
                    size: 25,
                  ),
                  Text(
                    'المادة',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 50),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                  imageUrl: imageUrl,
                                  imagePath: imageUrl,
                                ),
                              ),
                            );
                          },
                          child: FancyAvatar(
                            userImage: Image.asset(imageUrl),
                            ringColor: Color.fromARGB(255, 12, 83, 206),
                            spaceWidth: 4.5,
                            elevation: 10.0,
                            radius: 50,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 0, top: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الاسم الكامل',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'الصف',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'الشعبة',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Lottie.asset(
                          'images/anime/Animation - 1719841093260.json',
                          width: double.infinity,
                          height: 400),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'الشهور الدراسية',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'تحتوي الشهور الدراسية على تسجيل درجات ',
                      style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey),
                    ),
                    Text(
                      'الشفوي والواجبات والاختبارات التحريرية وتقييم السلوك',
                      style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    item('images/6702332.jpg', 'الشهر الاول'),
                    item('images/lckl_9en8_220318.jpg', 'الشهر الثاني'),
                    item('images/25w6_8x2r_220318.jpg', 'الشهر الثالث')
                  ],
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }

  Widget item(String images, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GradeTable(),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.7 / 2,
        child: Container(
          margin:
              const EdgeInsets.only(left: 10, right: 0, top: 20, bottom: 20),
          padding:
              const EdgeInsets.only(left: 20, right: 22, top: 15, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(images),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontFamily: 'ElMessiri', fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Lottie.asset(
                    'images/anime/Animation - 1719912016622.json',
                    width: 70,
                    height: 70,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الواجبات-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'الشفوي-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'التحريري-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'السلوك-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
