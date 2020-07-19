import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;
  final Key key;
  MessageBubble({this.msg, this.isMe,this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
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
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            msg,
            style: TextStyle(
              color: isMe == true
                  ? Colors.black
                  : Theme.of(context).accentTextTheme.headline1.color,
            ),
          ),
        ),
      ],
    );
  }
}
