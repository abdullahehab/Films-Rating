import 'package:backgroud/flimsData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class showRates extends StatefulWidget {
  @override
  _showRatesState createState() => _showRatesState();
}

class _showRatesState extends State<showRates> {

  List<films> allFilmes = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Movie Rate').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allFilmes.clear(); // To clean list before add data
      for (var key in keys) {
        films f = new films(
            data[key]['Movie Title'].toString(),data[key]['Rate'].toString());

        allFilmes.add(f);
      }
      setState(() {
        print('Length : ${data.length}');
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 30.0,
        title: Text("Films Rate"),
      ),
      body: new Container(
          child: Center(
            child: allFilmes.length == 0
                ? new CircularProgressIndicator(strokeWidth: 1.0)
                : new ListView.builder(
                itemBuilder: (context, index) {
                  return UI(
                      allFilmes[index].name,
                      allFilmes[index].rate,
                  );
                },
                itemCount: allFilmes.length),
          )),
    );
  }

  Widget UI(String name, String message) {
    return Card(
      color: Colors.deepPurpleAccent[100],
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 50.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Name : $name',style: Theme.of(context).textTheme.title),
            new Text('Rate : $message',style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
  }

