import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:employee_data/providers/employee_provider.dart';
import 'package:provider/provider.dart';

import 'employee_profile.dart';


class AllEmployee extends StatefulWidget {

  const AllEmployee({Key? key}) : super(key: key);
  @override
  _AllEmployeeState createState() => _AllEmployeeState();
}

class _AllEmployeeState extends State<AllEmployee> {

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    EmployeeProvider employeesProvider = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        centerTitle: true,
      ),
      body: (employeesProvider.isLoading == false) ? SafeArea(
        child:(employeesProvider.allEmployees.isNotEmpty) ? ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            (employeesProvider.getFilteredEmployees(searchQuery).isNotEmpty) ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: employeesProvider.getFilteredEmployees(searchQuery).length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => EmployeeProfile(isUpdate: true, em: employeesProvider.getFilteredEmployees(searchQuery)[index],)));
                    },
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: 75.0,
                            height: 75.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://i.imgur.com/BoN9kdC.png")
                                )
                            )
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF1D1E33) ,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(employeesProvider.getFilteredEmployees(searchQuery)[index].name.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(employeesProvider.getFilteredEmployees(searchQuery)[index].department.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }) : const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text('No Employees Found')),
            ),],
        ) : const Center(child: Text('No Employees Found')),
      ) : const Center(child: CircularProgressIndicator()),
    );
  }
}