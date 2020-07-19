import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void sendMsg() async{
    _controller.clear();
    FocusScope.of(context).unfocus();
   final user=await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'time': Timestamp.now(),
        'userId':user,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message..'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty ? null : sendMsg,
            )
          ],
        ));
  }
}
