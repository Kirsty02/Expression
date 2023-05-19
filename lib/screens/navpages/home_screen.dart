import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expression_app/model/user_model.dart';
import 'package:expression_app/screens/login_screen.dart';
import 'package:expression_app/screens/navpages/classification_screen.dart';
import 'package:expression_app/screens/navpages/main_page.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  _Home_screenState createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image(
                    image: AssetImage("assets/teal_logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.fromLTRB(60, 5, 60, 5),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    "Welcome ${loggedInUser.firstName}!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Expression is an app which is designed to help with emotion regualtion through music! \n Use your devices camera or chose a picture from your camera roll and allow the computer to detect your emotion. \n A song will then then be selected for you to listenmto depending on your emotion. Hope this appplicaiton is fun to use ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ActionChip(
                  label: Text(
                    "Get Started!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.amber,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login_screen()));
  }
}
