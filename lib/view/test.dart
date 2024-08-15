import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      onPressed: () {
        showSavedDataMessage();
      },
      child: Text('press'),
    )));
  }

  void showSavedDataMessage() {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('تم الحفظ',
    //           style: TextStyle(
    //               fontFamily: 'ElMessiri', fontWeight: FontWeight.w900)),
    //       content: Text(
    //           'تم حفظ بيانات الدخول بنجاح. يمكنك الآن استخدام البصمة لتسجيل الدخول.',
    //           style: TextStyle(fontFamily: 'ElMessiri')),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('موافق',
    //               style:
    //                   TextStyle(color: Colors.black, fontFamily: 'ElMessiri')),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
    AwesomeDialog(
      context: context,
      customHeader: Container(
        height: 200,
        width: 200,
        child: Lottie.asset('images/anime/Animation - 1723656081377.json'),
      ),
      animType: AnimType.scale,
      title: "تم الحفظ",
      titleTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
      desc:
          'تم حفظ بيانات الدخول بنجاح. يمكنك الآن استخدام البصمة لتسجيل الدخول',
      descTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        fontSize: 15,
        color: Colors.grey,
      ),
      btnOkOnPress: () {},
      btnOkColor: Colors.white,
      btnOkText: 'تم',
      buttonsTextStyle: const TextStyle(
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w900,
        color: Colors.black,
        fontSize: 17,
      ),
      dialogBackgroundColor: Colors.white,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(40)),
    ).show();
  }
}
