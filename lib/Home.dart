
import 'package:flutter/material.dart';


class Home extends StatefulWidget { //stateful ja que cambiara depende un parametro de entrada, la ubicación
  Home();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Column(
        
        children: <Widget>[

        // nombre de usuario
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
              Text("PedroPiqueras", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
              ]
            )
           ),
        // ubicación
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                Image.asset('images/location.png', width: 15.0, height: 15.0,), 
                SizedBox(width: 5.0,),    
                Text("Barcelona", style: TextStyle(color: Colors.black.withOpacity(0.5))),
                ]
              )
            ), 
        // imagen
          Image.network('https://imagenes.20minutos.es/files/image_656_370/uploads/imagenes/2020/07/13/basura-alrededor-de-los-contenedores-de-la-playa-en-cadiz.jpeg'),      
        // Gradiente
        // Descripción
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                Text("Descripción", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),                
                ]
              )
            ), 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                Text("Playa de Cádiz sucia", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 0.58))), //cambiar por descripción del usuario
                ]
              )
            ),
        // Comentarios
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                Text("Comentarios", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),                
                ]
              )
            ), 
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  Row(children: <Widget>[
                    Text("AlbertoRomero: ", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 0.58))), //cambiar por nombre del usuario
                    Text("Vergonzoso!", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 0.58))), //cambiar por comentario del usuario
                  ],),

                  Row(children: <Widget>[
                    Image.asset('images/mgcomentario.png', width: 15.0, height: 15.0, ), 
                    SizedBox(width: 5.0,),                   
                    Text("3", style: TextStyle(color: Color.fromRGBO(71, 82, 94, 0.58))), //cambiar numeros de mg reales del comentario
                  ],),

                  

                ]
              )
            ),
          


          ],
        ),

        
      );
  }
  

}