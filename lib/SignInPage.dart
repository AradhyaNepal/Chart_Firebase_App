
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ChartsPage.dart';
import 'Provider/AuthenticationClass.dart';
import 'package:login_app/SignUpPage.dart';
import 'package:login_app/SplashPage.dart';
import 'package:provider/provider.dart';

import 'Constants/Constants.dart';
import 'Provider/LoadingProvider.dart';

class SignInPage extends StatefulWidget {
  static const String route='SignInPage';
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key=GlobalKey<FormState>();
    Firebase.initializeApp();
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(

          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child:Container(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(backgroundImage: AssetImage('images/logo.jpg'),),
                  ),
                ),
                Text('Sign In',style: TextStyle(fontSize: 40),),

                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: usernameController,
                    maxLength: 30,
                    textInputAction: TextInputAction.next,
                    decoration: Constants().getInputDecoration('Email'),
                    validator: (value)=>value==null || value.length<1?'Please Enter Email':null,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: passwordController,
                    maxLength: 30,
                    decoration: Constants().getInputDecoration('Password',passwordMode:false),
                    obscureText: true,
                    validator: (value)=>value==null || value.length<1?'Please Enter Password':null,




                  ),
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  child: context.watch<LoadingProvider>().getLoading()?
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: (){
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 10,),
                          Text('Loading...')
                        ]),
                  ):ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: (){

                          if(key.currentState!.validate()){
                            context.read<LoadingProvider>().toggleLoading();
                            Future.delayed(Duration(seconds: 1),(){
                              context.read<AuthenticationClass>().signIn(email:usernameController.text.trim(), password: passwordController.text.trim())
                                  .then((value){
                                if (value=='Done'){
                                  Navigator.pushReplacementNamed(context,ChartsPage.route);
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                                }


                                context.read<LoadingProvider>().toggleLoading();

                              });

                            });

                          }
                        },




                      child:Text('Sign In'),
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, SignUpPage.route);
                    },
                    child: Text('Go to Sign Up')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void submitAuthForm(String email,String password,String username,bool isLogin){

  }
}
