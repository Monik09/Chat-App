import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;
  final Key key;
  final String userName;
  final String userImage;
  MessageBubble({this.msg, this.isMe, this.key,this.userImage, this.userName});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isMe == true ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight: !isMe ? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe == true
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    msg,
                    style: TextStyle(
                      color: isMe == true
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      Positioned(top:-10,right:isMe?120:null,left:isMe?null:120,child: CircleAvatar(backgroundImage: NetworkImage(userImage),)),
      ],
      overflow: Overflow.visible,
    );
  }
}
