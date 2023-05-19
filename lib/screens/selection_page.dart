import 'package:flutter/material.dart';
import 'package:expression_app/screens/login_screen.dart';
import 'package:expression_app/screens/registration_screen.dart';

class Selection_screen extends StatefulWidget {
  const Selection_screen({Key? key}) : super(key: key);

  @override
  _Selection_screenState createState() => _Selection_screenState();
}

class _Selection_screenState extends State<Selection_screen> {
  @override
  Widget build(BuildContext context) {
    //Login Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        minWidth: MediaQuery.of(context).size.width / 2.25,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login_screen()));
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //Register Button
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        minWidth: MediaQuery.of(context).size.width / 2.25,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Registration_screen()));
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage("assets/teal_logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 50),
                loginButton,
                SizedBox(height: 20),
                registerButton,
                SizedBox(height: 20),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't want an account?  "),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
