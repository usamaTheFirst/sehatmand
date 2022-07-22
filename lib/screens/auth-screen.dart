import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sehatmand/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String routeName = '/authScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "SehatMand",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 25,
                ),
              ),
              AuthForm(submitAuthForm: _submitAuthForm, loader: loader),
            ],
          ),
        ),
      ),
    );
  }

  bool loader = false;
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
      {required String email,
      required String password,
      required String confirmPassword,
      required bool isLoginMode}) async {
    UserCredential _credential;
    try {
      setState(() {
        loader = true;
      });
      if (isLoginMode) {
        _credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      if (mounted)
        setState(() {
          loader = false;
        });
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred please check your credentials';
      // print(message);
      if (error.message != null) {
        message = error.message.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$message'),
          backgroundColor: Theme.of(context).errorColor,
        ));
        setState(() {
          loader = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
