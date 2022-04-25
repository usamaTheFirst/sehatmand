import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key? key, required this.submitAuthForm, required this.loader})
      : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
  final Function(
      {required String email,
      required String password,
      required String confirmPassword,
      required bool isLoginMode}) submitAuthForm;
  bool loader;
}

class _AuthFormState extends State<AuthForm> {
  String? _email, _password, _confirmPassword;
  bool signinMode = true;
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 20,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value != null && value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                  onSaved: (value) => _password = value,
                  obscureText: true,
                ),
                if (!signinMode)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your password';
                      } else if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onSaved: (value) => _confirmPassword = value,
                    obscureText: true,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.loader) CircularProgressIndicator(),
                if (!widget.loader)
                  ElevatedButton(
                    child: signinMode ? Text('Sign In') : Text('Sign Up'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(_email);
                        print(_password);
                        print(_confirmPassword);
                        widget.submitAuthForm(
                            email: _email!.trim().toString(),
                            password: _password.toString(),
                            confirmPassword: _confirmPassword.toString(),
                            isLoginMode: signinMode);
                      }
                    },
                  ),
                if (!widget.loader)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        signinMode = !signinMode;
                      });
                    },
                    child: Text(signinMode
                        ? "Create a new account"
                        : 'I already have an account'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
