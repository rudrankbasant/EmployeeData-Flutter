import 'dart:convert';
import 'dart:developer';
import 'package:employee_data/models/Employee.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static const String _baseUrl = 'https://employeedata.up.railway.app/allEmployees';

  static Future<List<Employee>> getEmployees() async {
    Uri requestUri = Uri.parse('$_baseUrl/list');
    final response = await http.get(requestUri);
    var decoded = jsonDecode(response.body);
    log(decoded.toString());

    List<Employee> allEmployees = [];

    for(var employeeMap in decoded){
      Employee newEmployee = Employee.fromMap(employeeMap);
      allEmployees.add(newEmployee);
    }

    return allEmployees;
  }

  static Future<void> addEmployee(Employee em) async{
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(requestUri, body: em.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteEmployee(Employee em) async{
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(requestUri, body: em.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

}