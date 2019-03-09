import 'package:backgroud/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 30.0,
        title: const Text('Favorite Movies App'),
        automaticallyImplyLeading: false,
      ), //backgroundColor: Colors.white70,
      body: Column(
        children: <Widget>[

          new Container(
            margin: EdgeInsets.only(top: 50.0),
            child: new Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: new Theme(
                      data: new ThemeData(
                        //brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                            //color: Colors.teal,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      child: new Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'Welcome To Favorite Movie App',
                              style: TextStyle(color: Colors.blue, fontSize: 20.0),
                            ),
                            SizedBox(height: 50.0),
                            new TextFormField(
                              validator: validateEmail,
                              decoration: new InputDecoration(
                                  labelText: "Enter Your Email ",
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (val) => _email = val,
                            ),
                            SizedBox(height: 10.0),
                            new TextFormField(
                              validator: validatePassword,
                              decoration: new InputDecoration(
                                  labelText: "Enter Your Password ",
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              onSaved: (val) => _password = val,
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            new MaterialButton(
                              height: 40.0,
                              minWidth: 200.0,
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              child: new Text(
                                "Log In",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: signIn,
                              splashColor: Colors.redAccent,
                            ),
                            new MaterialButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                              height: 30.0,
                              minWidth: 200.0,
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              child: new Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: navigateToSignUp,
                              splashColor: Colors.redAccent,
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        print(user.uid);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void navigateToSignUp() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SingUp()));
  }

  String validatePassword(String val ){
    return val.length == 0 ? 'Enter Your password' : null;
  }

  String validateEmail(String val){
    return val.length == 0 ? 'Enter Your Emain' : null;
  }
}
