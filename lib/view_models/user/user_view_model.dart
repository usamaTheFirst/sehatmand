import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  late User user;
  FirebaseAuth auth = FirebaseAuth.instance;

  setUser() {
    user = auth.currentUser!;
    notifyListeners();
  }
}
