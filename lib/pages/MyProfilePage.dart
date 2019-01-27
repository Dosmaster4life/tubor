import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import './ImagePick.dart';
import 'dart:io';
DocumentSnapshot snapshot;
class MyProfilePage extends StatelessWidget {
  final DocumentReference reference;
  final DocumentSnapshot snapshot;
  MyProfilePage({this.snapshot, this.reference});

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((void x) {
      Navigator.pop(context);
    });
  }

  void _chooseTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    showDatePicker(
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(Duration(hours: 168, minutes: 0, seconds: 0)),
        initialDate: DateTime.now(),
        context: context);
  }

  @override
  
  Widget build(BuildContext context) {
    if (snapshot == null)
      return Container(child: Text('loading'));
    return Material(
        color: Colors.greenAccent,
        child: Scaffold(
            appBar: AppBar(
              title: Text('My Profile'),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Center(
                  child: InkWell(
                    onLongPress: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ImagePick()

                    )),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: CircleAvatar(
                        backgroundImage: 
                          (snapshot['photo'] != null)
                            ? NetworkImage("${snapshot['photo']}")
                            : AssetImage('assets/DefaultGuy.png'),
                        minRadius: 50,
                        maxRadius: 100,
                      ),
                    ),
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "${snapshot['name']}\n${snapshot['email']}\n\nBio",
                    style: new TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    maxLines: 4,
                    maxLength: 150,
                    maxLengthEnforced: true,
                  ),
                ),
                RaisedButton(
                  child: Text("Choose Time"),
                  onPressed: () => _chooseTime(context),
                ),
                RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: () => _logout(context),
                ),
              ],
            ))));
  }
}
