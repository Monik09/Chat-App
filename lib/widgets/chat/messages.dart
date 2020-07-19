
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').orderBy('time',descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        return (chatSnapshot.connectionState == ConnectionState.waiting)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              reverse: true,
                itemBuilder: (ctx, index) {
                  return Text(chatSnapshot.data.documents[index]['text'],);
                },
                itemCount: chatSnapshot.data.documents.length,
              );
      },
    );
  }
}
