import 'dart:convert';
import 'dart:ffi';

class Employee{
  String? id;
  String? name;
  String? age;
  String? phone_number;
  String? department;

  Employee({
    this.id,
    this.name,
    this.age,
    this.phone_number,
    this.department
  });

  factory Employee.fromMap(Map<String, dynamic> map){
    return Employee(
        id: map['id'],
        name: map['name'],
        age: map['age'].toString(),
        phone_number: map['phone_number'].toString(),
        department: map['department']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone_number': phone_number,
      'department': department
    };
  }


}