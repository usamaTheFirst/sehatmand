import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sehatmand/screens/form_screen.dart';
import 'package:sehatmand/screens/main-srcreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstTime = true;
  bool isRegistered = false;
  Future<bool> checkIfRegisteredOrNot() async{

    final id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection("users").doc(id).get();
    if(isFirstTime){
      setState(() {
        isRegistered = ds.exists;
        isFirstTime = false;
      });
    }
    return Future<bool>.value(isRegistered);
  }

  @override
  void initState() {
    checkIfRegisteredOrNot();
    super.initState();
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            print('MainScreen');
            didChangeDependencies(){
              checkIfRegisteredOrNot();
            }

            return isRegistered?MainScreen():FormScreen();

          } else {
            print('LoginScreen');
            return LoginScreen();
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
          return e.message.toString();
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
        inputTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        primaryColorAsInputLabel: true,
        accentColor: Colors.deepPurpleAccent,
        titleStyle: TextStyle(
          color: Colors.deepPurpleAccent,
        ),

        buttonTheme: LoginButtonTheme(
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 9.0,
            highlightElevation: 6.0,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        errorColor: Colors.red,

        // pageColorDark: Color(0xFF222831),
      ),
      onRecoverPassword: (String) {},
    );
  }
}
