import 'dart:developer';
import 'dart:io';

import 'package:employee_data/models/Employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/employee_provider.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode employeeFocus = FocusNode();

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      log(image.toString());
      if(image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }

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
      department: dropdownvalue.toString(),

    );

    Provider.of<EmployeeProvider>(context, listen: false).addEmployee(newEmployee);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("New Employee Added"),
    ));
    nameController.text= '';
    ageController.text= '';
    phoneController.text= '';
    dropdownvalue = 'HR';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Name'),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: nameController,
                  autofocus:  true,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      employeeFocus.requestFocus();
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
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
                  autofocus:  true,
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
                  autofocus:  true,
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
              const SizedBox(height: 20),
              ButtonTheme(
                minWidth: 200.0,
                height: 100.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(350, 50),
                  ),
                  onPressed: () {
                      pickImage();
                  },
                  child: const Text('Upload Profile Image'),
                ),
              ),
              const SizedBox(height: 20),
              ButtonTheme(
                minWidth: 200.0,
                height: 100.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    addEmployee();
                  },
                  child: const Text('Add Employee'),
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }
}