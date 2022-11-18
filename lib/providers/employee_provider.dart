import 'dart:developer';

import 'package:employee_data/models/Employee.dart';
import 'package:flutter/cupertino.dart';

import '../services/api_service.dart';


class EmployeeProvider with ChangeNotifier {
  bool isLoading = true;
  List<Employee> allEmployees = [];

  EmployeeProvider() {
    getEmployees();
  }

  void sortEmployees() {
    allEmployees.sort((a, b) => a.name!.compareTo(b.name!));
  }

  void getEmployees() async{
    allEmployees = await ApiService.getEmployees();
    sortEmployees();
    isLoading = false;
    notifyListeners();
  }

  List<Employee> getFilteredEmployees(String query) {
    return allEmployees.where((note) => note.name!.toLowerCase().contains(query.toLowerCase())
        || note.department!.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void addEmployee(Employee em) {
    allEmployees.add(em);
    sortEmployees();
    notifyListeners();
    ApiService.addEmployee(em);
  }

  void updateEmployee(Employee em) {
    final employeeIndex = allEmployees.indexWhere((element) => element.id == em.id);
    allEmployees[employeeIndex] = em;
    sortEmployees();
    notifyListeners();
    ApiService.addEmployee(em);
  }

  void deleteEmployee(Employee em) {
    final employeeIndex = allEmployees.indexWhere((element) => element.id == em.id);
    allEmployees.removeAt(employeeIndex);
    sortEmployees();
    notifyListeners();
    ApiService.deleteEmployee(em);
  }
}