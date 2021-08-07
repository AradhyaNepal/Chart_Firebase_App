
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/MessageBubble.dart';

class MessageBox extends StatefulWidget {
  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Messages').orderBy('TimeStamp',descending: true).snapshots(),
      builder: (context,snapshots){
        if (snapshots.connectionState==ConnectionState.waiting){
          return Center(
            child:CircularProgressIndicator(),
          );

        }

        final chartDocs=snapshots.data!.docs;

        return ListView.builder(
          reverse: true,
            itemCount: chartDocs.length,
            itemBuilder:(ctx,index){
              String uid=chartDocs.elementAt(index)['uid'];
              bool isMe=uid==user!.uid;
              return MessageBubble(text:chartDocs.elementAt(index)['Text'],isMe: isMe,uid: uid,);
            }

        );
      }
    );

  }
}
