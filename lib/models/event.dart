import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  late String userId;
  late String username;
  late String userDp;
  late Timestamp timestamp;
  EventModel(this.userId, this.username, this.userDp, this.timestamp);

  EventModel.fromJson(Map<String, dynamic> json) {
    userId = json['ownerId'];
    username = json['username'].toString();
    timestamp = json['timestamp'];
    userDp = json['userDp'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ownerId'] = this.userId;
    data['username'] = this.username;
    data['userDp'] = this.userDp;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
