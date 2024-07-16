import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class NewTest extends StatefulWidget {
  const NewTest({super.key});

  @override
  State<NewTest> createState() => _NewTestState();
}

class _NewTestState extends State<NewTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          AnimatedButton(pressEvent: () {
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.topSlide,
                    showCloseIcon: true,
                    title: "waring",
                    desc: '',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {})
                .show();
          })
        ],
      )),
    );
  }
}
