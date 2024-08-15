import 'dart:convert';
import 'package:muhaslti/api/login_response.dart';
import 'package:muhaslti/controller/client_controller.dart';

enum AccountResult {
  successfully,
  failedProcess,
  wrongUsernameOrPassword,
  failed
}

class Account {
  bool isEmployee;
  String username;

  Account(this.isEmployee, this.username);

  factory Account.byMap(Map<String, dynamic> account) {
    return Account(account['isEmployee'] == "1", account['username']);
  }

  Map<String, dynamic> toMap() {
    return {
      "isEmployee": isEmployee,
      "username": username,
    };
  }

  static Future<void> login(String username, String password,
      Function(Account?, String) onResult) async {
    try {
      LoginResponse? response = await ClientController.login(username, password);
      if (response == null) throw Exception("Unknown error");

      if (response.isEmployee != null && response.displayName != null) {
        Account account = Account(response.isEmployee!, response.displayName!);
        onResult(account, "");
      } else {
        throw Exception("Invalid response data");
      }
    } catch (e) {
      onResult(null, e.toString());
    }
  }
}
