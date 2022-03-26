import 'dart:io';

import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatefulWidget {
  bool isLoading;
  final void Function(String email, String username,File? pickedImage, String password,
      bool isLogin, BuildContext ctx) submitAuthForm;
  AuthCard(this.submitAuthForm, this.isLoading);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  var _userName = "";
  var _userEmail = "";
  var _userPassword = "";
  File? _pickedImage;

  void _getPickedImage(File image){
    _pickedImage = image;
  }

  void _trySubmit() {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_pickedImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please provide a valid image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitAuthForm(
          _userEmail, _userName,_pickedImage, _userPassword, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Register to Chat app",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                if (!_isLogin) ImagePickerWidget(_getPickedImage),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey("username"),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: "Username"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return "Username must be 4 or more characters long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                TextFormField(
                  key: ValueKey("email"),
                  decoration: InputDecoration(labelText: "Email address"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Invalid email address";
                    }
                  },
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                TextFormField(
                  key: ValueKey("password"),
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return "Password must be 7 or more characters long";
                    }
                  },
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                      onPressed: _trySubmit,
                      child: _isLogin ? Text("Login") : Text("Sign up")),
                if (!widget.isLoading)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: _isLogin
                        ? Text("Create new account")
                        : Text("I already have an account"),
                    textColor: Theme.of(context).primaryColor,
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
