import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:firebase_database/firebase_database.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password , _name , _phone;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: Text("Registraion Form"),
        backgroundColor: Colors.deepPurple,
        elevation: 30.0,
        automaticallyImplyLeading: false,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                  height: 20.0
              ),
              TextFormField(
                validator: (input){
                  if(input.isEmpty)
                    return 'Enter your name';
                },
                decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
                onSaved: (input) => _name = input,
              ),
              SizedBox(
                  height: 20.0
              ),
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Provide an email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
                onSaved: (input) => _email = input,
              ),
              SizedBox(
                  height: 20.0
              ),
              TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Longer password please';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )
                ),

                onSaved: (input) => _password = input,
                obscureText: true,
              ),
              SizedBox(
                  height: 20.0
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Phone',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
                onSaved: (input) => _phone = input,
              ),
              SizedBox(
                  height: 20.0
              ),
          new MaterialButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            height: 40.0,
            minWidth: 200.0,
            color: Colors.lightBlue,
            textColor: Colors.white,
            child: new Text("Sign Up", style: TextStyle(fontSize: 20.0),),
            onPressed: signUp,
            splashColor: Colors.redAccent,
          )],
          )
      ),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        print(user.uid);

        DatabaseReference ref = FirebaseDatabase.instance.reference();
        var data = {'User Name': _name, 'E-Mail': _email, 'Phone': _phone};
        ref.child('Accounts').push().set(data);
        print(data.values);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}