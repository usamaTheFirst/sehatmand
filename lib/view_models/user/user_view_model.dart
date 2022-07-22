import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  late User user;
  FirebaseAuth auth = FirebaseAuth.instance;

  UserViewModel() {
    auth = FirebaseAuth.instance;
    user = auth.currentUser!;
  }

  setUser() {
    user = auth.currentUser!;
    notifyListeners();
  }
}
