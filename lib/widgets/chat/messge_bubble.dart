import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  MessageBubble(this.msg);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(msg,style: TextStyle(color: Theme.of(context).accentTextTheme.headline1.color,),),
        ),
      ],
    );
  }
}
