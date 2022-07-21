import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  late String username;
  late String userId;
  late Timestamp timestamp;
  EventModel(this.username, this.userId, this.timestamp);

  EventModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['userId'].toString();
    timestamp = json['timestamp'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
