import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String id;
  late String postId;
  late String ownerId;
  late String username;
  late String location;
  late String description;
  late String mediaUrl;
  late Timestamp timestamp;
  

  PostModel({
    required this.id,
    required this.postId,
    required this.ownerId,
    required this.location,
    required this.description,
    required this.mediaUrl,
    required this.username,
    required this.timestamp,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    location = json['location'];
    username= json['username'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;

    data['timestamp'] = this.timestamp;
    data['username'] = this.username;
    return data;
  }
}
