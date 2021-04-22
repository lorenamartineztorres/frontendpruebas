
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/Home.dart';


class PagePrincipal extends StatefulWidget { 
  PagePrincipal();
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
    Text(
      'Index 1: Buscador',
    ),
    Text(
      'Index 2: Añadir',
    ),
    Text(
      'Index 3: usuario',
    ),
    Text(
      'Index 4: ajustes',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(    
          centerTitle: true,    
          title: Text('ECOPROTECT', style: TextStyle(fontSize: 16.0,fontFamily: 'Glacial Indifference' ),),   
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