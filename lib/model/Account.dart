import 'dart:convert';
import 'package:muhaslti/controller/client_controller.dart';

enum AccountResult {
  successfully,
  failedProcess,
  wrongUsernameOrPassword
}
class Account {
  int ID;
  int userID;
  bool isEmployee;
  String username;
  String password;


  Account(this.ID, this.userID, this.isEmployee, this.username, this.password);

  factory Account.byMap(Map<String, dynamic> account) {
    return Account(int.parse(account['ID']), int.parse(account['userID']),
        account['isEmployee'] == "1", account['username'], account['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "userID": userID,
      "isEmployee": isEmployee,
      "username": username,
      "password": password
    };
  }

  static Future<void> login(String username, String password,
      Function(Account, AccountResult) onResult) async {
    Map<String, dynamic> response = json.decode(
        await ClientController.login(username, password));
    Account account;
    AccountResult accountResult;
    if (response['error_code'] == 0) {
      account = Account.byMap(jsonDecode(response['data']));
      accountResult = AccountResult.successfully;
    }
    else if (response['error_code'] == 202) {
      account = emptyAccount;
      accountResult = AccountResult.wrongUsernameOrPassword;
    }
    else {
      account = emptyAccount;
      accountResult = AccountResult.failedProcess;
    }
    onResult(account, accountResult);
  }

  static final Account emptyAccount = Account(-1, -1, false, "", "");
}

