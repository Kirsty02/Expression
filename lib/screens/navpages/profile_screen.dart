import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expression_app/model/user_model.dart';
import 'package:expression_app/screens/navpages/music_card.dart';
import 'package:image_picker/image_picker.dart';

import '../login_screen.dart';

class Profile_screen extends StatefulWidget {
  Profile_screen({Key? key}) : super(key: key);

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  //to change profile image
  final picker = ImagePicker();
  File _profile_pic = File('teal_logo.png');
  bool _load = false;

  pickProfileImage() async {
    var profile_pic = await picker.pickImage(source: ImageSource.gallery);
    if (profile_pic == null) return null;

    setState(() {
      _profile_pic = File(profile_pic.path);
    });
  }

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
    //Logout Button
    final logoutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        minWidth: MediaQuery.of(context).size.width / 1.5,
        onPressed: () {
          logout(context);
        },
        child: Text(
          "Logout",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Text(
                  "${loggedInUser.firstName}'s Profile",
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      //ClipRRect(),
                      _load
                          ? CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.amber,
                              child: CircleAvatar(
                                radius: 52,
                                backgroundImage: FileImage(_profile_pic),
                              ),
                            )
                          : CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.amber,
                              child: CircleAvatar(
                                radius: 52,
                                backgroundImage: AssetImage('assets/melon.png'),
                              ),
                            ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                            height: 45,
                            width: 45,
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                  splashColor:
                                      Colors.deepOrange, // inkwell color
                                  child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.camera_alt,
                                        color: Colors.amber),
                                  ),
                                  onTap: () {
                                    pickProfileImage();
                                    _load = true;
                                  },
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 10),
                //Saved congs section
                Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.amber,
                        ),
                        Text(
                          "SAVED SONGS",
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    //Music_card(),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        "Account Information: ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Name: ${loggedInUser.firstName} ${loggedInUser.lastName}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Email: ${loggedInUser.email}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                logoutButton,
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
