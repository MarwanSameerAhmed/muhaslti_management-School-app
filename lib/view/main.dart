import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muhaslti/view/FirstLunchHandler.dart';
import 'package:muhaslti/view/GradeMark.dart';
import 'package:muhaslti/view/NewLoginPage.dart';
import 'package:muhaslti/view/StudentGradeInfo.dart';
import 'package:muhaslti/view/TestScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Employee.dart';

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          Employee.emptyEmployee, // Create and provide the Employee instance
      child: const MaterialApp(
        home: NewLoginPage(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static bool hasPermission = false;
  @override
  Widget build(BuildContext context) {
    Settings.loadSettings();
    Provider.of<Employee>(context).setColor();
    return MaterialApp(
      theme: ThemeData(primaryColor: Employee.color),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      home: AnimatedSplashScreen(
          duration: 2000,
          splashTransition: SplashTransition.fadeTransition,
          splash: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: const Image(
                      image: AssetImage(
                          'images/WhatsApp Image 2023-10-17 at 19.10.56_8770f79d.jpg')),
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: const Text(
                    'Muhasilati',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ]),
          ),
          nextScreen: const NewLoginPage()),
      debugShowCheckedModeBanner: false
    );
  }
}

class Settings {
  static Map<String, dynamic> settings = {'ip': 'test'};

  static Future<bool> requestPermission() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus == PermissionStatus.denied) {
      await Permission.storage.request();
      permissionStatus = await Permission.storage.status;
      if (permissionStatus == PermissionStatus.granted) {
        return true;
      }
      return false;
    }
    return true;
  }

  static void saveSettings() async {
    if (!await requestPermission()) return;
    final downloadsDirectory = await getExternalStorageDirectory();
    if (downloadsDirectory == null) {
      return;
    }

    final filePath = '${downloadsDirectory.path}/settings.js';
    final file = File(filePath);

    try {
      await file.writeAsString(jsonEncode(settings));
      loadSettings();
    } catch (e) {}
  }

  static void loadSettings() async {
    if (!await requestPermission()) return;
    final downloadsDirectory = await getExternalStorageDirectory();
    if (downloadsDirectory == null) {
      return;
    }

    final filePath = '${downloadsDirectory.path}/settings.js';
    final file = File(filePath);

    try {
      String data = await file.readAsString();
      if (data.isEmpty) return;
      settings = jsonDecode(data);
    } catch (e) {}
  }
}
