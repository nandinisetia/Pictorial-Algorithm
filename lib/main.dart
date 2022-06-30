import 'package:firebase_core/firebase_core.dart';
import 'package:flash/chatscreen.dart';
import 'package:flash/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(routes: {
    'signup': (context) => signupscreen(),
    'chatscreen': (context) => chatscreen()
  }, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController control;
  late AnimationController controlsecond;
  late Animation animationvalue;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();

    control = AnimationController(vsync: this, duration: Duration(seconds: 1));
    control.forward();
    control.addListener(() {
      setState(() {});
    });

    controlsecond =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controlsecond.forward();

    control.addListener(() {
      setState(() {});
    });

    animationvalue =
        CurvedAnimation(parent: controlsecond, curve: Curves.decelerate);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(control.value),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: (animationvalue.value) * 68,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  Text(
                    "FlashChat",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                  ),
                ]),
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: 338,
                  child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter Your Email")),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 338,
                  child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter Your Password")),
                ),
                SizedBox(
                  height: 50,
                ),
                Material(
                  child: MaterialButton(
                    elevation: 2,
                    padding:
                        EdgeInsets.symmetric(horizontal: 145, vertical: 16),
                    color: Colors.blue,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(
                            context,
                            'chatscreen',
                          );
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Material(
                  child: MaterialButton(
                    elevation: 2,
                    padding:
                        EdgeInsets.symmetric(horizontal: 140, vertical: 16),
                    color: Colors.lightBlue,
                    onPressed: () {
                      Navigator.pushNamed(context, 'signup');
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
