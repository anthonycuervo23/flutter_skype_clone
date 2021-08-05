import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    this.senderId,
    this.receiverId,
    this.type,
    this.message,
    this.timestamp,
  });

  //Will be only called when you wish to send an image
  Message.imageMessage(
      {this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.photoUrl});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['type'] = type;
    map['message'] = message;
    map['timestamp'] = timestamp;
    return map;
  }

  Message fromMap(Map<String, dynamic> map) {
    final Message _message = Message();
    _message.senderId = map['senderId'] as String;
    _message.receiverId = map['receiverID'] as String;
    _message.type = map['type'] as String;
    _message.message = map['message'] as String;
    _message.timestamp = map['timestamp'] as FieldValue;
    return _message;
  }

  String? senderId;
  String? receiverId;
  String? type;
  String? message;
  FieldValue? timestamp;
  String? photoUrl;
}
