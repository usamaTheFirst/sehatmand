import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sehatmand/providers/excercise_provider.dart';
import 'package:sehatmand/screens/auth-screen.dart';
import 'package:sehatmand/screens/form_screen.dart';
import 'package:sehatmand/screens/main-srcreen.dart';
import 'package:sehatmand/screens/test_screen.dart';
import 'package:sehatmand/utils/providers.dart';
import 'package:sehatmand/view_models/auth/register_view_model.dart';
import 'package:sehatmand/view_models/profile/edit_profile_view_model.dart';
import 'package:sehatmand/view_models/user/user_view_model.dart';
import 'package:sehatmand/widgets/exercise_widget.dart';
import 'package:sehatmand/auth/register/profile_pic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: FetchPreviousExcercise()),
    ...providers
  ], child: (MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Scaffold(body: ListView(children: [])));
//   }
// }

class _MyAppState extends State<MyApp> {
  bool isFirstTime = true;
  bool isRegistered = false;
  checkIfRegisteredOrNot() async {
    if (isFirstTime && mounted) {
      final id = FirebaseAuth.instance.currentUser!.uid;
      print(id);
      DocumentSnapshot ds =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      setState(() {
        print(ds.data());
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
      debugShowCheckedModeBanner: false,
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
            Future.delayed(Duration(microseconds: 2)).then((value) async {
              await checkIfRegisteredOrNot();
            });

            if (isRegistered != null) {
              print("isRegistered: $isRegistered");
              return isRegistered! ? MainScreen() : const FormScreen();
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
        ProfilePicture.routeName: (context) => ProfilePicture(),
      },
    );
  }
}
