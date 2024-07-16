import 'package:fancy_avatar/fancy_avatar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/view/TestScreen.dart';

class GradeTable extends StatefulWidget {
  const GradeTable({super.key});

  @override
  State<GradeTable> createState() => _GradeTableState();
}

class _GradeTableState extends State<GradeTable> {
  final String imageUrl = 'images/2024_04_11_15_19_IMG_6269.JPG';

  final List<Map<String, String>> data = [
    {
      'week': 'الاسبوع الاول',
      'oral': '12',
      'homework': '0',
      'written': '0',
      'behavior': '0'
    },
    {
      'week': 'الاسبوع الثاني',
      'oral': '0',
      'homework': '0',
      'written': '0',
      'behavior': '0'
    },
    {
      'week': 'الاسبوع الثالث',
      'oral': '0',
      'homework': '0',
      'written': '0',
      'behavior': '0'
    },
    {
      'week': 'الاسبوع الرابع',
      'oral': '0',
      'homework': '0',
      'written': '0',
      'behavior': '0'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
                body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Container(
          width: double.infinity,
          height: 200,
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
                label: Text('الاسبوع',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
            DataColumn(
                label: Text('الشفوي',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
            DataColumn(
                label: Text('الواجبات',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
            DataColumn(
                label: Text('التحريري',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
            DataColumn(
                label: Text('السلوك',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
            DataColumn(
                label: Text('المجموع',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
          ],
          rows: data.map((row) {
            final total = (int.tryParse(row['oral'] ?? '0') ?? 0) +
                (int.tryParse(row['homework'] ?? '0') ?? 0) +
                (int.tryParse(row['written'] ?? '0') ?? 0) +
                (int.tryParse(row['behavior'] ?? '0') ?? 0);
            return DataRow(cells: [
              DataCell(Text(row['week']!,
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontFamily: 'ElMessiri'))),
              DataCell(buildEditableCell(row, 'oral')),
              DataCell(buildEditableCell(row, 'homework')),
              DataCell(buildEditableCell(row, 'written')),
              DataCell(buildEditableCell(row, 'behavior')),
              DataCell(Text(total.toString())),
            ]);
          }).toList(),
        ),
      ),
    ]))));
  }

  Widget buildEditableCell(Map<String, String> row, String key) {
    return TextFormField(
      initialValue: row[key],
      onChanged: (newValue) {
        setState(() {
          row[key] = newValue;
        });
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      style: const TextStyle(fontSize: 14),
    );
  }
}
