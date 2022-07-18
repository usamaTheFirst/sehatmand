import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sehatmand/screens/main-srcreen.dart';
import 'package:sehatmand/utils/firebase.dart';
import 'package:sehatmand/services/auth_service.dart';
import '../auth/register/profile_pic.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);
  static const String routeName = '/user-form';
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FormBuilder(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Enter your details',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'Name',
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      } else if (value.length > 20) {
                        return 'Name must be 20 characters or less';
                      } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
                        return 'Name must contain only alphabetical characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        // enabledBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(2),
                        //     borderSide: BorderSide(color: Colors.blueAccent)),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(2),
                        //   borderSide: BorderSide(color: Colors.blue, width: 5),
                        // ),
                        hintText: 'Enter your name'),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'username',
                    enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      } else if (value.length > 20) {
                        return 'Name must be 20 characters or less';
                      } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
                        return 'Name must contain only alphabetical characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter username'),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'Height',
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your height';
                      } else if (double.tryParse(value) == null) {
                        return 'Please enter a valid height';
                      } else if (double.parse(value) < 0) {
                        return 'Height must be positive';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: 'Enter your height in cm'),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'Weight',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      } else if (double.tryParse(value) == null) {
                        return 'Please enter a valid weight';
                      } else if (double.tryParse(value)! < 30) {
                        return 'You must be at least 30kg';
                      } else if (double.tryParse(value)! > 300) {
                        return 'You must be 300kg or less';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: 'Enter your weight in kg'),
                  ),
                  SizedBox(height: 10),
                  FormBuilderDateTimePicker(
                    name: 'dob',
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                    format: DateFormat("dd-MM-yyyy"),
                    inputType: InputType.date,
                    decoration:
                        InputDecoration(hintText: 'Enter your date of birth'),
                  ),
                  SizedBox(height: 10),
                  FormBuilderChoiceChip(
                      name: 'Gender',
                      initialValue: 'Male',
                      elevation: 5,
                      selectedColor: Colors.deepPurpleAccent,
                      decoration: InputDecoration(
                          labelText: 'Please select your Gender',
                          labelStyle: TextStyle(fontSize: 16)),
                      validator: (value) {
                        if (value == null) {
                          return 'Please chose your gender';
                        } else {
                          return null;
                        }
                      },
                      options: const [
                        FormBuilderFieldOption(
                            value: 'Male', child: Text('Male')),
                        FormBuilderFieldOption(
                            value: 'Female', child: Text('Female')),
                      ]),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'bio',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your bio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration:
                    InputDecoration(hintText: 'Enter info about you'),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'country',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your country';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration:
                    InputDecoration(hintText: 'Enter your country'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    height: 30.5,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).colorScheme.secondary,
                    minWidth: MediaQuery.of(context).size.width * 0.70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState!.validate()) {
                        print(_formKey.currentState?.value);

                        final id = await FirebaseAuth.instance.currentUser?.uid;
                        final FirebaseFirestore _firestore =
                            FirebaseFirestore.instance;
                        AuthService auth = AuthService();
                        await auth.saveUserToFirestore(_formKey.currentState?.value['username'], FirebaseAuth.instance.currentUser as User,
                            FirebaseAuth.instance.currentUser!.email.toString(), _formKey.currentState?.value['country']);
                        await _firestore
                            .collection('users')
                            .doc(id)
                            .update(_formKey.currentState!.value);
                        // print("####################");
                        // print(_formKey.currentState?.value['username']);
                        // Navigator.of(context).pushReplacement(
                        //   CupertinoPageRoute(
                        //     builder: (_) => ProfilePicture(),
                        //   ),
                        // );
                        // Navigator.pushReplacementNamed(context, MainScreen.routeName);
                        Navigator.pushReplacementNamed(context, ProfilePicture.routeName);
                      } else {
                        print("validation failed");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
