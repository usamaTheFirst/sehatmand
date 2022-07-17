import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String username;
  late String email;
  late String photoUrl;
  late String? country;
  late String? bio;
  late String? id;
  late Timestamp? signedUpAt;
  late Timestamp? lastSeen;
  late bool? isOnline;

  UserModel(
      {required this.username,
      required this.email,
      this.id,
      required this.photoUrl,
      this.signedUpAt,
      this.isOnline,
      this.lastSeen,
      this.bio,
      this.country});

  UserModel.fromJson(Map<String?, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    bio = json['bio'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['country'] = this.country;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['bio'] = this.bio;
    data['signedUpAt'] = this.signedUpAt;
    data['isOnline'] = this.isOnline;
    data['lastSeen'] = this.lastSeen;
    data['id'] = this.id;

    return data;
  }
}
