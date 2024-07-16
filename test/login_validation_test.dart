import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muhaslti/controller/client_controller.dart';
import 'package:muhaslti/model/Account.dart';

void main() {
  group('loginPage tests', () {
    test('login function success', () async {
      bool successpassword = false;
      await ClientController.login('1234', '12345678').then((_) {
        successpassword = true;
      });

      expect(successpassword, true);
    });

    test('login function failed process', () async {
      bool failedProcess = false;
      await ClientController.login('', '').then((_) {
        failedProcess = true;
      });
      expect(failedProcess, true);
    });

    test('login function wrong Username or Password', () async {
      bool wrongpassword= false;
      await ClientController.login('12345', '123456788').then((_) {
        wrongpassword= true;
      });
      expect(wrongpassword, true);
    });
  });
}