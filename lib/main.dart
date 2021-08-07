import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/Provider/ChartsProvider.dart';
import 'Provider/AuthenticationClass.dart';
import 'package:login_app/ChartsPage.dart';
import 'package:login_app/Provider/LoadingProvider.dart';
import 'package:login_app/SignInPage.dart';
import 'package:login_app/SignUpPage.dart';
import 'package:login_app/SplashPage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<AuthenticationClass>(
          create: (_)=>AuthenticationClass(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<LoadingProvider>(
          create: (_)=>LoadingProvider(),
        ),
        ChangeNotifierProvider<ChartsProvider>(
            create: (_)=>ChartsProvider(),
        ),
        ChangeNotifierProvider<LoadingProvider>(
          create:(_)=>LoadingProvider(),

        ),
        StreamProvider(
          create: (context)=>context.read<AuthenticationClass>().authStateChange, initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Login App',
        theme: ThemeData.dark(),
        initialRoute: SplashPage.route,
        routes: {
          SplashPage.route:(context)=>SplashPage(),
          SignInPage.route:(context)=>SignInPage(),
          SignUpPage.route:(context)=>SignUpPage(),
          ChartsPage.route:(context)=>ChartsPage(),
        },

      ),
    );
  }
}
