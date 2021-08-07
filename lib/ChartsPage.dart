import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/Constants/Constants.dart';
import 'package:login_app/MessageBox.dart';
import 'package:login_app/Provider/AuthenticationClass.dart';
import 'package:login_app/Provider/ChartsProvider.dart';
import 'package:login_app/SplashPage.dart';
import 'package:provider/provider.dart';

class ChartsPage extends StatefulWidget {
  static const route='/chatsPage';
  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {

  final messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ChartsProvider>().currentUser),
        automaticallyImplyLeading: false,
        actions: [

          IconButton(onPressed: (){
            context.read<AuthenticationClass>().signOut().then((value){
              Navigator.pushReplacementNamed(context,SplashPage.route);
            });


          }, icon:Icon(Icons.logout) ),
        ],
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child:MessageBox(),

          ),
          Divider(),
          Card(
            elevation: 5,
            color: Colors.white,
            child: Row(

              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        keyboardType:TextInputType.multiline ,
                        maxLines:2,
                        minLines: 1,
                        controller: messageController,
                        decoration:InputDecoration(
                          hintText: 'Message...',
                          hintStyle: TextStyle(color: Colors.black),

                        ),
                        style: TextStyle(

                          color: Colors.black
                        ),
                      ),
                    ),
                ),
                IconButton(onPressed: (){
                  if(messageController.text.isNotEmpty){
                    FirebaseFirestore.instance.collection('Messages').add({
                      'Text':messageController.text,
                      'TimeStamp':Timestamp.now(),
                      'uid':FirebaseAuth.instance.currentUser!.uid,
                    });
                    messageController.clear();

                  }

                }, icon: Icon(Icons.send,color: Colors.redAccent,))
              ],
            ),
          ),


        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }
}
