// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class MyHomePage extends StatelessWidget {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dialog Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 _showDialog(context, 'خطأ', 'حدث خطأ ما!', 'error_sound.mp3');
//               },
//               child: Text('إظهار رسالة خطأ'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _showDialog(context, 'نجاح', 'تمت العملية بنجاح!', 'success_sound.mp3');
//               },
//               child: Text('إظهار رسالة نجاح'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDialog(BuildContext context, String title, String message, String soundFile) {
//     // تشغيل النغمة
//     _playSound(soundFile);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('موافق'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _playSound(String soundFile) async {
//     int result = await _audioPlayer.play('assets/$soundFile', isLocal: true);
//     if (result == 1) {
//       print('Success');
//     } else {
//       print('Error');
//     }
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MyHomePage(),
//   ));
// }