import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String uid;

  MessageBubble({required this.text, required this.uid, required this.isMe});

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Row(
     mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
     children: [
       Container(
         decoration: BoxDecoration(
           color: isMe ? Colors.grey[100] : Theme
               .of(context)
               .accentColor,
           borderRadius: BorderRadius.circular(12),

         ),
         width: 140,
         padding: EdgeInsets.symmetric(
             vertical: 10,
             horizontal: 16
         ),
         margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Text(text,textAlign: isMe?TextAlign.right:TextAlign.left, style: TextStyle(color: Colors.black),),
             isMe ?
             Text(
                 'By Me',textAlign: TextAlign.left,
                 style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold)
             ) : StreamBuilder<DocumentSnapshot>(
                 stream: FirebaseFirestore.instance.collection('Users').doc(
                     uid).snapshots(),
                 builder: (context, snapshot) {
                   if(snapshot.hasData){
                     var document=snapshot.data as DocumentSnapshot;
                     return Text(
                         document['Username'],
                       textAlign: TextAlign.right
                         , style: TextStyle(
                         color: Colors.black,

                         fontWeight: FontWeight.bold,));
                     }
                   return SizedBox();
                 }


             ),

           ],
         ),
       ),
     ],
   );
  }
}
