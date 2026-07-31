import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_10/image.dart';
import 'package:ppkd_b7/day_13/input_widget/checkbox.dart';
import 'package:ppkd_b7/day_6/expanded.dart';
import 'package:ppkd_b7/day_8/stack.dart';
import 'package:ppkd_b7/extension/navigator.dart';

class DrawerDay13 extends StatefulWidget {
  const DrawerDay13({super.key});

  @override
  State<DrawerDay13> createState() => _DrawerDay13State();
}

class _DrawerDay13State extends State<DrawerDay13> {
  int _selectedBottom = 0;

  void changeBottom(int index) {
    _selectedBottom = index;
    print("Ini adalah value dari $_selectedBottom");
    setState(() {});
    context.pop();
  }

  final List<Widget> _widgetOptions = [
    ExpandedDay6(),
    StackDay8(),
    ShowImageDay10(),
    InputWidgetDay13(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawer")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                changeBottom(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text("school"),
              onTap: () {
                changeBottom(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text("business"),
              onTap: () {
                changeBottom(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text("Input Widget"),
              onTap: () {
                changeBottom(3);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedBottom),
    );
  }
}
