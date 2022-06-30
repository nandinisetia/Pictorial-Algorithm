import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  _signupscreenState createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                    tag: 'logo',
                    child: Container(
                        height: 160, child: Image.asset('images/logo.png'))),
              ),
              SizedBox(height: 10),
              Text(
                "SignUp",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 338,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Your Email"),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 338,
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Create Your Password"),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                child: MaterialButton(
                  elevation: 2,
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 16),
                  color: Colors.lightBlue,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newuser != null) {
                        Navigator.pushNamed(context, 'chatscreen');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
