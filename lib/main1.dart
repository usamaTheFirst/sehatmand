import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sehatmand/screens/auth-screen.dart';
import 'package:sehatmand/screens/form_screen.dart';
import 'package:sehatmand/screens/main-srcreen2.dart';
import 'package:sehatmand/screens/test_screen.dart';
import 'package:sehatmand/screens/mainscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstTime = true;
  bool? isRegistered;
  checkIfRegisteredOrNot() async {
    if (isFirstTime && mounted) {
      final id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot ds =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      setState(() {
        isRegistered = ds.exists;
        isFirstTime = false;
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SehatMand',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF222831),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.deepPurpleAccent)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 5),
            ),
          ),
          colorScheme: ColorScheme.dark().copyWith(
            secondary: Colors.deepPurpleAccent,
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Future.delayed(Duration(microseconds: 1)).then((value) async {
              await checkIfRegisteredOrNot();
            });

            if (isRegistered != null) {
              // return isRegistered! ? MainScreen() : const FormScreen();
              return isRegistered! ? TabScreen() : const AuthScreen();
            } else {
              print("isRegistered is null");
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
          } else {
            print('LoginScreen');
            return AuthScreen();
          }
        },
      ),
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        FormScreen.routeName: (context) => FormScreen(),
      },
    );
  }
}
