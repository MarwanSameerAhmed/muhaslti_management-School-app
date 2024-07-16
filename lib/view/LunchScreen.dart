import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/view/NewLoginPage.dart';

class LaunchScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/anime/Animation - 1719705408660.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'مرحباً بكم في محصلتي',
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'نهدف إلى تحويل تجربة التعليم إلى تجربة تفاعلية وفعّالة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'لتساعدك على تحقيق أقصى استفادة من وقتك وجهودك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LaunchScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/anime/Animation - 1719775774816.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'تواصل فعّال مع معلميك',
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'ابقَ على اتصال دائم مع معلميك واستفد من الموارد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'لتعليمية المصممة خصيصاً لتلبية احتياجاتك الأكاديمية',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LaunchScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/anime/Animation - 1719775289196.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'تابع تقدمك الأكاديمي',
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'راقب إنجازاتك الأكاديمية وسعَ نحو التفوق من خلال',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'متابعة مهامك ودرجاتك بكل سهولة ويسر',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ElMessiri',
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
