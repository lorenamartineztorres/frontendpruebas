import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ajustes.dart';
import 'package:flutter_application_1/cambiarNombre.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/profilePage.dart';
import 'package:flutter_application_1/searchPublication.dart';
import 'package:flutter_application_1/uploadPublication.dart';
import 'globals.dart' as globals;

class PagePrincipal extends StatefulWidget {
  /*var token;
  PagePrincipal(@required this.token);*/
  
  @override
  _PagePrincipalState createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
     
    });
  }

  final List<Widget> pantallas = [
    Home(),
    Search(),
    Upload(),
    Profile(),
    ajustes()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'ECOPROTECT',
          style: TextStyle(fontSize: 16.0, fontFamily: 'Glacial Indifference'),
        ),
      ),
      body: pantallas[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(            
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color.fromRGBO(100, 211, 83, 1),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
