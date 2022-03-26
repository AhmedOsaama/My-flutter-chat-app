import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final messageController = TextEditingController();
  String _enteredMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TextField(
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: "Send a message"),
            controller: messageController,
            onChanged: (value){
              setState(() {
              _enteredMessage = value;
              });
            },
          )),
          IconButton(onPressed: _enteredMessage.isEmpty ? null : () async {
            messageController.clear();
            FocusScope.of(context).unfocus();
            final userData = await FirebaseFirestore.instance.collection('/users').doc(FirebaseAuth.instance.currentUser!.uid).get();
            FirebaseFirestore.instance.collection('/chats').add({
              'message': _enteredMessage,
              'createdAt': Timestamp.now(),
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'username': userData['username'],
              'imageURL': userData['imageURL'],
            });
            _enteredMessage = "";
          }, icon: Icon(Icons.send),color: Theme.of(context).accentColor,),
        ],
      ),
    );
  }
}
