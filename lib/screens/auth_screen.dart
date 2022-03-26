import 'dart:io';

import 'package:chat_app/widgets/auth_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _submitAuthForm(String email, String username,File? pickedImage, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;
    try {
      if (!isLogin) {
        setState(() {
          _isLoading = true;
        });
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
    final userImageRef = FirebaseStorage.instance.ref().child('user_image').child(userCredential.user!.uid + '.jpg');
    await userImageRef.putFile(pickedImage!).whenComplete(() => null);
    final url = await userImageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          "email": email,
          "username": username,
          'imageURL': url,
        });
      } else {
        setState(() {
          _isLoading = true;
        });
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (error) {
      var message = "An error occurred, please check your credentials";

      if (error.message != null) {
        message = error.message!;
      }
      print(message);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).primaryColor,
      body: AuthCard(_submitAuthForm, _isLoading),
    );
  }
}
