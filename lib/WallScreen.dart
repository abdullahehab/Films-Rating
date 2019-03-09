import 'package:backgroud/showRates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class wallScreen extends StatefulWidget {
  @override
  _wallScreenState createState() => _wallScreenState();
}

class _wallScreenState extends State<wallScreen> {

  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String filmsApi = 'https://gist.githubusercontent.com/yannski/3019778/raw/dfb34d018165f47b61b3bf089358a3d5ca199d96/movies.json';

  List films;

  @override
  void initState() {
    fetch();
    super.initState();
  }

  Future<String> fetch() async {
    var response = await http.get(Uri.encodeFull(filmsApi),

        headers: {"Accept": "application/json"}
    );

    print(response.body);

    final resopnseJson = json.decode(response.body);

    setState(() {
      films = resopnseJson;
    });

    print(films.length);
    return 'seccess';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 0.75,
        // el msa7a ben el filmes
        // Generate 100 Widgets that display their index in the List
        children:
        List.generate(films == null ? 10 : films.length, (index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              //child: Text(films[index]['title']),
              child: InkWell(
                onTap: () {
                  _showonTapMessage(context, films[index]['description'],
                      films[index]['title']);
                },
                child: Card(
                  elevation: 50.0,
                  child: Image.network(
                    films[index]['cover_url'] == null
                        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/No_image_available_400_x_600.svg/2000px-No_image_available_400_x_600.svg.png'
                        : films[index]['cover_url'],
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 10.0,
          child: Icon(Icons.whatshot),
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => showRates()));
          }
      ),
    );
  }

  void _showonTapMessage(BuildContext context, String filmDes, String filmTitle) {

    var alert = new AlertDialog(
      title: Text(filmTitle),
      content: Text(filmDes) == null ? Text("No description") : Text(filmDes),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Good"),
          onPressed: (){
            insertToDataBaseGood(filmTitle);
            //TODO back-end
          },
        ),
        FlatButton(
          child: Text("Bad"),
          onPressed: (){
            insertToDataBaseBad(filmTitle);
            //TODO back-end
          },
        ),
      ],
    );
    // showDialog(context: context, child: alert);
    showDialog(context: context, builder: (context) => alert);
  }
  void insertToDataBaseGood(String filmTitle)
  {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {'Movie Title': filmTitle, 'Rate': 'Good'};
      ref.child('Movie Rate').push().set(data);
      print('insert done');
    }catch(e)
    {
      print(e.toString());
    }
  }

  void insertToDataBaseBad(String filmTitle)
  {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {'Movie Title': filmTitle, 'Rate': 'Bad'};
      ref.child('Movie Rate').push().set(data);
      print('insert done');
    }catch(e)
    {
      print(e.toString());
    }
  }


}