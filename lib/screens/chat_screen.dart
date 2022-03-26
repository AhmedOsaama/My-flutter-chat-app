import 'package:chat_app/widgets/messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
        title: Text("FlutterChat"),
        actions: [
          DropdownButton(icon: Icon(Icons.more_vert,color: Theme.of(context).primaryIconTheme.color,),items: [
            DropdownMenuItem(value: 'logout',child: Container(
              // padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8,),
                  Text("Logout"),
                ],
              ),
            ),
            ),
          ], onChanged: (itemIdentifier){
            if(itemIdentifier == 'logout'){
              FirebaseAuth.instance.signOut();
            }
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     FirebaseFirestore.instance.collection("/chats").add(
      //         {
      //           "message":"Something I added",
      //         });
      //     // await FirebaseAuth.instance.signOut();
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
