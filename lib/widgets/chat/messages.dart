import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            return (chatSnapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true,
                    itemBuilder: (ctx, index) {
                      return MessageBubble(
                        msg: chatSnapshot.data.documents[index]['text'],
                        isMe: chatSnapshot.data.documents[index]['userId'] ==
                            futureSnapshot.data.uid,
                        key: ValueKey(
                            chatSnapshot.data.documents[index].documentID),
                        userName: chatSnapshot.data.documents[index]
                            ['username'],
                        userImage:chatSnapshot.data.documents[index]['userImage'],
                      );
                    },
                    itemCount: chatSnapshot.data.documents.length,
                  );
          },
        );
      },
    );
  }
}
