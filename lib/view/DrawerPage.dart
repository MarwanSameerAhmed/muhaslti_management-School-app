import 'package:flutter/material.dart';

class DrawerPageSetting extends StatefulWidget {
  @override
  State<DrawerPageSetting> createState() => _DrawerPageSettingState();
}

class _DrawerPageSettingState extends State<DrawerPageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'الإعدادات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('حسابي'),
              onTap: () {
                // أضف كود onTap هنا!
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('إعدادات التطبيق'),
              onTap: () {
                // أضف كود onTap هنا!
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('مساعدة'),
              onTap: () {
                // أضف كود onTap هنا!
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('محتوى صفحة الإعدادات'),
      ),
    );
  }
}
