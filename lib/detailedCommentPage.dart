import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';
import 'globals.dart' as globals;

class CommentsPage extends StatefulWidget {
  var _publication;
  CommentsPage(this._publication);
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  int num_mg = 0;
  final newcomment = TextEditingController();
 
  
  
  bool likedComment(String comment) {
    bool liked = false;
    if (globals.likedComments.contains(comment)){
      liked = true;
    }
    return liked;
  }

  Widget _buildRow(Map<String, dynamic> publication, int index) {
     return SingleChildScrollView(
      child: Column(
      children: <Widget>[
         Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(publication['comments'][index],
                            style: TextStyle(
                                color: Color.fromRGBO(71, 82, 94,
                                    0.58))), //cambiar por comentario del usuario
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite,
                          color:  publication['mgCount'][index] > 0 ? Colors.red
                        : Colors.grey,),
                          onPressed: () {
                            setState(() {
                              String comment1 = publication['comments'][index];
                              if(likedComment(comment1)) {
                                num_mg = publication['mgCount'][index];
                                num_mg--;
                                publication['mgCount'][index] = num_mg;
                                globals.likedComments.remove(comment1);
                                doLike(publication['_id'], index);
                              }
                              else {
                                num_mg = publication['mgCount'][index];
                                num_mg++;
                                publication['mgCount'][index] = num_mg;
                                globals.likedComments.add(comment1);
                                doLike(publication['_id'], index);
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(publication['mgCount'][index].toString(),
                            style: TextStyle(
                                color: Color.fromRGBO(71, 82, 94,
                                    0.58))), //cambiar numeros de mg reales del comentario
                      ],
                    ),
                    
                  ],
                  ),
                  ),
        /*           
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: newcomment,
            decoration: InputDecoration(
              hintText: 'Añade un nuevo comentario',
              suffixIcon: IconButton(
                onPressed: () => {
                  addComment(newcomment.text, publication['_id']),
                  print(newcomment.text)
                },
                icon: Icon(Icons.check_outlined),
              ),
            ),
          ),
        )*/
      ]),
      );
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Comentarios',
          style: TextStyle(fontSize: 16.0, fontFamily: 'Glacial Indifference'),
        ),
      ),
      body: ListView.separated(
        // it's like ListView.builder() but better because it includes a separator between items
        padding: const EdgeInsets.all(16.0),
        itemCount: widget._publication["comments"].length,
        itemBuilder: (BuildContext context, int index) =>
            _buildRow(widget._publication, index),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

 