import 'package:chat_app/widgets/message_bubble.dart';
import 'package:chat_app/widgets/skeleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      return;
    });
    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   print(message);
    // });
    fbm.subscribeToTopic('chats');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("/chats")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future.delayed(const Duration(seconds: 3));
            return ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) => NewsCardSkeleton(),
              separatorBuilder: (context, index) =>
              const SizedBox(height: 16),
            );
          }
          final messages = snapshot.data!.docs;
          return ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8.0),
                    child: MessageBubble(
                        messages[index]['message'],
                        messages[index]['username'],
                        messages[index]['imageURL'],
                        messages[index]['userId'] ==
                            FirebaseAuth.instance.currentUser!.uid, key: ValueKey(messages[index].id),
              ),
                  ));
        });
  }
}

class NewsCardSkeleton extends StatelessWidget {
   NewsCardSkeleton({
    Key? key,
  }) : super(key: key);

  var defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Skeleton(height: 120, width: 120),
         SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Skeleton(width: 80),
               SizedBox(height: defaultPadding / 2),
               Skeleton(),
               SizedBox(height: defaultPadding / 2),
               Skeleton(),
               SizedBox(height: defaultPadding / 2),
              Row(
                children:  [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}


