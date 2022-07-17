import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sehatmand/components/life_cycle_event_handler.dart';
import 'package:sehatmand/landing/landing_page.dart';
import 'package:sehatmand/screens/mainscreen.dart';
import 'package:sehatmand/services/user_service.dart';
import 'package:sehatmand/utils/config.dart';
import 'package:sehatmand/utils/constants.dart';
import 'package:sehatmand/utils/providers.dart';
import 'package:sehatmand/screens/main-srcreen2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sehatmand/providers/excercise_provider.dart';
import 'package:sehatmand/screens/auth-screen.dart';
import 'package:sehatmand/screens/form_screen.dart';
import 'package:sehatmand/screens/main-srcreen.dart';
import 'package:sehatmand/screens/test_screen.dart';
import 'package:sehatmand/widgets/exercise_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initFirebase();
  runApp(MyApp());
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: FetchPreviousExcercise()),
  ], child: (MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(
      LifecycleEventHandler(
        detachedCallBack: () => UserService().setUserStatus(false),
        resumeCallBack: () => UserService().setUserStatus(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            theme: notifier.dark ? Constants.darkTheme : Constants.lightTheme,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.hasData) {
                  return MainScreen();
                } else
                  return Landing();
              },
            ),
          );
        },
      ),
    );
  }
}
