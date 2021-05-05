import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'loginForm.dart';
import 'registerForm.dart';

String finalemail;

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {

  /*void initState(){
      
      getValidationData().whenComplete(() async{
        if (finalemail == null){
         
         MaterialApp(home: finalemail == null ? LoginForm() : RegisterForm());
        }else{
         runApp(MaterialApp(home: finalemail == null ? LoginForm() : RegisterForm()));
        }
        //Timer(Duration (seconds:2), () => Get.to(finalemail == null ? RegisterForm(): RegisterForm()));
        /*if (finalemail==null){
          RegisterForm();
        }else{
          Home();
        }*/
       print(finalemail);
    });
    super.initState();

}
  Future getValidationData() async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
       finalemail = obtainedEmail;    
      });

   //finalemail = sharedPreferences.get('tok');
    print("Final email");
    print(finalemail);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(          
          image: DecorationImage(
            image: AssetImage('images/hoja.png'),
            fit:  BoxFit.fill,        
          ),
        ),
        child: Column(
          children: <Widget>[
            
            //Boton Login
            Padding(
                padding: const EdgeInsets.only(
                    left: 70.0, right: 70.0, top: 300, bottom: 0),
                child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    //Dirigirse pantalla login
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => LoginForm(),
                    ));
                  },
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
             
             //Linea de Separacion
             Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 25.0, right: 15.0,top:20),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
                
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, right: 6, top: 20, bottom: 0),
                child: Text("O")
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 25.0, top:20),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),
            
            //Boton Registrarse
            Padding(
                padding: const EdgeInsets.only(
                    left: 70.0, right: 70.0, top: 20, bottom: 0),
                child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)
                    ),
                child: FlatButton(
                  onPressed: () {
                    //Dirigirse pantalla registrarse
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => RegisterForm(),
                    ));
                  },
                  child: Text(
                    'Registrate',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}