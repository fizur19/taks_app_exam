import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/screen/add.dart';
import 'package:taks_app/presetetion/screen/cansell.dart';
import 'package:taks_app/presetetion/screen/completed.dart';
import 'package:taks_app/presetetion/screen/newtaks.dart';
import 'package:taks_app/presetetion/screen/progess.dart';

class Main_screen extends StatefulWidget {
  const Main_screen({super.key});

  @override
  State<Main_screen> createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {
  int index = 0;
  List list = [
    newtaks(),
    completed(),
    progess(),
    cansell(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (value) {
            index = value;

            if (mounted) {
              setState(() {});
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.file_copy_outlined), label: 'New Taks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all_outlined), label: 'Completed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_copy_outlined), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled')
          ]),
    );
  }
}
