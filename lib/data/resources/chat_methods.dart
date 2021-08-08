import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/data/constants/data_constants.dart';
import 'package:skype_clone/data/models/message.dart';
import 'package:skype_clone/data/models/user.dart';

class ChatMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> addMessageToDb(
      MessageModel message, UserModel sender, UserModel receiver) async {
    final Map<String, dynamic> map = message.toMap();

    await firestore
        .collection(AppDBConstants.messagesCollection)
        .doc(message.senderId)
        .collection(message.receiverId!)
        .add(map);

    return firestore
        .collection(AppDBConstants.messagesCollection)
        .doc(message.receiverId)
        .collection(message.senderId!)
        .add(map);
  }

  Future<void> setImageMsg(
      String url, String receiverId, String senderId) async {
    MessageModel _message;

    _message = MessageModel.imageMessage(
      message: 'IMAGE',
      receiverId: receiverId,
      senderId: senderId,
      photoUrl: url,
      timestamp: Timestamp.now(),
      type: 'image',
    );

    final Map<String, dynamic> map = _message.toImageMap();

    // Set the data to database
    await firestore
        .collection(AppDBConstants.messagesCollection)
        .doc(_message.senderId)
        .collection(_message.receiverId!)
        .add(map);

    await firestore
        .collection(AppDBConstants.messagesCollection)
        .doc(_message.receiverId)
        .collection(_message.senderId!)
        .add(map);
  }
}
