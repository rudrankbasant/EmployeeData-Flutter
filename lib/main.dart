import 'package:employee_data/providers/employee_provider.dart';
import 'package:employee_data/screens/add_employee.dart';
import 'package:employee_data/screens/all_employee.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EmployeeProvider()),
    ],
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(

          primary: const Color(0xFF1D1E33),
          secondary: const Color(0xFFEB1555),


        ),
      ),
      home: const BottomNavigationBar(),
    );
  }
}

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({Key? key}) : super(key: key);
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  void onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex = 0;
  final List<Widget> children = [
    const AddEmployee(),
    const AllEmployee(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_selectedIndex],
      bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: GNav(
                tabBackgroundColor: Colors.grey,
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                gap: 8,
                onTabChange: (index) {
                    onTappedBar(index);
                  },
                padding: EdgeInsets.all(16),
                tabs: const [
                  GButton(icon: Icons.add_outlined, text: 'Add Employee'),
                  GButton(icon: Icons.account_circle_sharp, text: 'All Employees'),
                ],
              )
          )));

  }
}



