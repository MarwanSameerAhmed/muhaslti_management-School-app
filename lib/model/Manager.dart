import 'dart:convert';

import 'package:muhaslti/controller/client_controller.dart';
import 'package:muhaslti/model/Employee.dart';

enum NewEmployeeResult{
  successfully,
  nameExists,
  IDCardNumberExists,
  unknownError
}

class Manager extends Employee{
  Manager({required super.ID, required super.employeeName, required super.IDCardNumber, required super.type});
  factory Manager.byEmployee(Employee employee) {
    return Manager(ID: employee.ID, employeeName: employee.employeeName, IDCardNumber: employee.IDCardNumber, type: employee.type);
  }

  Future<List<Employee>> getEmployees() async {
    List<Employee> employees = [];
    String result = await ClientController.getEmployees();
    if (result.isEmpty || int.tryParse(result) != null) return employees;

    List<dynamic> lsEmployees = jsonDecode(result);
    if (lsEmployees.isEmpty) return employees;

    employees = List.generate(lsEmployees.length, (index) => Employee.fromMap(lsEmployees[index]));
    return employees;
  }

  void createEmployee(newEmployee, {required Function(NewEmployeeResult) onResult}) async {
    String result = await ClientController.createEmployee(newEmployee);
    if (result == '0') {
      onResult(NewEmployeeResult.successfully);
      return;
    }
    if (result == '104') {
      onResult(NewEmployeeResult.IDCardNumberExists);
      return;
    }
    if (result == '103') {
      onResult(NewEmployeeResult.nameExists);
      return;
    }
    onResult(NewEmployeeResult.unknownError);
    return;
  }
}