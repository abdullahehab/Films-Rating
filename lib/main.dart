import 'package:backgroud/WallScreen.dart';
import 'package:backgroud/splashScren.dart';
//import 'package:backgroud/splashScren.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splashScren(),

  ));
  /*splashScren()*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Films';
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 30.0,
          automaticallyImplyLeading: false,
          title: Text(title),
        ),
        body: new Container(
          child: wallScreen(),
          decoration: BoxDecoration(
              image: new DecorationImage(image: new AssetImage('images/background.jpg'),
                fit: BoxFit.fill
              )
          ),
        )
    );
  }

}
