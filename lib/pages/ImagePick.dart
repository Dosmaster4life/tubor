
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
class ImagePick extends StatefulWidget {
  @override
 
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
        DocumentSnapshot snapshot;
      _image = image;
      List<int> imageBytes = image.readAsBytesSync();
print(imageBytes);
String base64Image = base64Encode(imageBytes);
FirebaseAuth.instance
      .currentUser()
      .then((FirebaseUser user) {
        return Firestore.instance
          .collection('users')
          .document(user.uid)
          .get();
      })  
      .then((DocumentSnapshot snap) {
        setState(() {
          snapshot = snap;
        });
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}