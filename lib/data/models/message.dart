import 'package:cloud_firestore/cloud_firestore.dart';

//My imports
import 'package:skype_clone/data/constants/message_fields.dart';

class MessageModel {
  MessageModel({
    this.senderId,
    this.receiverId,
    this.type,
    this.message,
    this.timestamp,
  });

  //Will be only called when you wish to send an image
  MessageModel.imageMessage(
      {this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.photoUrl});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[MessageFields.senderId] = senderId;
    map[MessageFields.receiverId] = receiverId;
    map[MessageFields.type] = type;
    map[MessageFields.message] = message;
    map[MessageFields.timestamp] = timestamp;
    return map;
  }

  Map<String, dynamic> toImageMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map[MessageFields.senderId] = senderId;
    map[MessageFields.receiverId] = receiverId;
    map[MessageFields.type] = type;
    map[MessageFields.message] = message;
    map[MessageFields.timestamp] = timestamp;
    map[MessageFields.photoUrl] = photoUrl;
    return map;
  }

  MessageModel.fromMap(Map<String, dynamic> map) {
    senderId = map[MessageFields.senderId];
    receiverId = map[MessageFields.receiverId];
    type = map[MessageFields.type];
    message = map[MessageFields.message];
    timestamp = map[MessageFields.timestamp];
    photoUrl = map[MessageFields.photoUrl];
  }

  String? senderId;
  String? receiverId;
  String? type;
  String? message;
  Timestamp? timestamp;
  String? photoUrl;
}
