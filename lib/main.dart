import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:sehatmand/screens/form_screen.dart';
import 'package:sehatmand/screens/main-srcreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // scaffoldBackgroundColor: Color(0xFF4C3AE2),

          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          colorScheme:
              ColorScheme.light().copyWith(secondary: Colors.deepOrange)),
      home: LoginScreen(),
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        FormScreen.routeName: (context) => FormScreen(),
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  late String mode;
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'SehatMand',
      onLogin: (loginData) async {
        final _auth = await FirebaseAuth.instance;

        try {
          final user = await _auth.signInWithEmailAndPassword(
              email: loginData.name, password: loginData.password);
          if (user != null) {
            Navigator.pushNamed(context, MainScreen.routeName);
          }
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );
        }
      },
      onSignup: (signupData) async {
        final _auth = await FirebaseAuth.instance;

        try {
          final user = await _auth.createUserWithEmailAndPassword(
              email: signupData.name.toString(),
              password: signupData.password.toString());
          if (user != null) {
            Navigator.pushNamed(context, FormScreen.routeName);
          }
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );
        }
      },
      theme: LoginTheme(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.blue,
        errorColor: Colors.red,
        pageColorLight: Colors.white,
        pageColorDark: Colors.blue,
      ),
      onRecoverPassword: (String) {},
    );
  }
}
