import 'package:employee_data/models/Employee.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/employee_provider.dart';

class EmployeeProfile extends StatefulWidget {
  final bool isUpdate;
  final Employee? em;
  const EmployeeProfile({Key? key, required this.isUpdate, this.em}) : super(key: key);

  @override
  _EmployeeProfileState createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  //NotesProvider notesProvider = Provider.of<NotesProvider>(context);
  FocusNode employeeFocus = FocusNode();
  //Initial Selected Value
  String dropdownvalue = 'HR';

  // List of items in our dropdown menu
  var items = [
    'HR',
    'Finance',
    'House Keeping',
    'Marketing',
  ];


  void addEmployee() {
    Employee newEmployee = Employee(
      id: const Uuid().v1(),
      name: nameController.text,
      age: ageController.text,
      phone_number: phoneController.text,
      department: departmentController.text,
    );

    Provider.of<EmployeeProvider>(context, listen: false).addEmployee(newEmployee);
    Navigator.pop(context);
  }

  void updateEmployee() {
      Employee updatedEmployee = Employee(
        id: widget.em!.id,
        name: nameController.text,
        age: ageController.text,
        phone_number: phoneController.text,
        department: dropdownvalue,
    );

    Provider.of<EmployeeProvider>(context, listen: false).updateEmployee(updatedEmployee);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      nameController.text = widget.em!.name.toString();
      ageController.text = widget.em!.age.toString();
      phoneController.text = widget.em!.phone_number.toString();
      dropdownvalue = widget.em!.department.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.isUpdate,
            child: IconButton(
              onPressed: () {
                if(widget.isUpdate){
                  Provider.of<EmployeeProvider>(context, listen: false).deleteEmployee(widget.em!);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ),
          IconButton(
            onPressed: (){
              if(widget.isUpdate) {
                updateEmployee();
              }else{
                addEmployee();
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Name'),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: nameController,
                autofocus:  false,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    employeeFocus.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Title',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Age'),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: ageController,
                autofocus:  false,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    employeeFocus.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Age',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Phone Number'),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                autofocus:  false,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    employeeFocus.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Department'),
            const SizedBox(height: 10),
            //add drop down menu
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}