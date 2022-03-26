import 'package:flutter/material.dart';
import 'dart:io';


class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  Key? key;

  MessageBubble(this.message, this.userName,this.userImage, this.isMe, {this.key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            key: key,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
              ),
              color: isMe ? Colors.grey[400] : Theme.of(context).accentColor,
            ),
            width: 100,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color),
                  // textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color),
                ),
              ],
            ),
          ),
        ],
      ),
        Positioned(left: isMe ? null : 90,right: isMe ? 90 : null, child: CircleAvatar(backgroundImage: NetworkImage(userImage),)),
    ]
    );
  }
}
