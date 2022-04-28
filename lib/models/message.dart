import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatmand/models/enum/message_type.dart';

class Message {
  late String content;
  late String senderUid;
  late MessageType type;
  late Timestamp time;

  Message({required this.content, required this.senderUid, required this.type, required this.time});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderUid = json['senderUid'];
    if (json['type'] == 'text') {
      type = MessageType.TEXT;
    } else {
      type = MessageType.IMAGE;
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['senderUid'] = this.senderUid;
    if (this.type == MessageType.TEXT) {
      data['type'] = 'text';
    } else {
      data['type'] = 'image';
    }
    data['time'] = this.time;
    return data;
  }
}
