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

  Future<String> getUserId() async {
    dynamic auth = await FirebaseAuth.instance.currentUser();
    return auth.uid;
  }

  Future<String> getUserName() async {
    dynamic authUser = await FirebaseAuth.instance.currentUser();
    dynamic auth = await Firestore.instance
        .collection('users')
        .document(authUser.uid)
        .get();
    return auth['username'];
  }
  Future<String> getUserImage() async {
    dynamic authUser = await FirebaseAuth.instance.currentUser();
    dynamic auth = await Firestore.instance
        .collection('users')
        .document(authUser.uid)
        .get();
    return auth['imageUrl'];
  }

  Future<Map<String, dynamic>> getUser() async {
    Map<String, dynamic> comdata = <String, dynamic>{
      'text': _enteredMessage,
      'time': Timestamp.now(),
      'userId': await getUserId(),
      'username': await getUserName(),
      'userImage':await getUserImage(),
    };
    return comdata;
  }

  void sendMsg() async {
    _controller.clear();
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').add(
          await getUser(),
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
      ),
    );
  }
}
