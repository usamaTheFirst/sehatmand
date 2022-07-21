import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAttributesProvider extends ChangeNotifier {
  double? weight, height;
  int? age;

  Future<void> fetchUserAttributes() async {
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
    if (userId != null) {
      final _firestore = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('users').doc(userId).get();
      weight = double.parse(doc.get('Weight'));
      height = double.parse(doc.get('Height'));
      final dob = doc.get("dob").toDate();
      age = DateTime.now().difference(dob).inDays ~/ 365;
      notifyListeners();

      //   .then((value) {
      //     if (value.exists) {
      //       final data = value.data();
      //       print("data is >>>>>>>>>> $data");
      //       final dob = (data!['dob']).toDate();
      //       // age = dob.difference(DateTime.now()).inDays / 365;
      //       age = DateTime.now().difference(dob).inDays ~/ 365;
      //
      //       print("Weight is >>>>>>>>>> ${data['Weight']}");
      //       weight = double.parse(data['Weight'].toString());
      //       height = double.parse(data['Height'].toString());
      //       debugPrint('age: $age, weight: $weight, height: $height');
      //
      //       notifyListeners();
      //       return true;
      //     }
      //   });
      // }
    }
  }
}
