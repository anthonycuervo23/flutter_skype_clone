import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/data/constants/data_constants.dart';
import 'package:skype_clone/data/models/message.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/models/contact.dart';

class ChatMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference<Map<String, dynamic>> _messageCollection =
      firestore.collection(AppDBConstants.messagesCollection);

  static final CollectionReference<Map<String, dynamic>> _userCollection =
      firestore.collection(AppDBConstants.usersCollection);

  Future<DocumentReference<Map<String, dynamic>>> addMessageToDb(
      MessageModel message, UserModel sender, UserModel receiver) async {
    final Map<String, dynamic> map = message.toMap();

    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId!)
        .add(map);

    addToContacts(senderId: message.senderId, receiverId: message.receiverId);

    return _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId!)
        .add(map);
  }

  DocumentReference<Map<String, dynamic>> getContactsDocuments(
          {String? of, String? forContact}) =>
      _userCollection.doc(of).collection('contacts').doc(forContact);

  Future<void> addToContacts({String? senderId, String? receiverId}) async {
    final Timestamp currentTime = Timestamp.now();

    await addToSenderContact(senderId!, receiverId!, currentTime);
    await addToReceiverContact(receiverId, senderId, currentTime);
  }

  Future<void> addToSenderContact(
      String senderId, String receiverId, Timestamp currentTime) async {
    final DocumentSnapshot<Map<String, dynamic>> senderSnapshot =
        await getContactsDocuments(of: senderId, forContact: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      final ContactModel receiverContact = ContactModel(
        uid: receiverId,
        addedOn: currentTime,
      );

      final Map<String, dynamic> receiverData =
          receiverContact.toMap(receiverContact);

      await getContactsDocuments(of: senderId, forContact: receiverId)
          .set(receiverData);
    }
  }

  Future<void> addToReceiverContact(
      String receiverId, String senderId, Timestamp currentTime) async {
    final DocumentSnapshot<Map<String, dynamic>> receiverSnapshot =
        await getContactsDocuments(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      final ContactModel senderContact = ContactModel(
        uid: senderId,
        addedOn: currentTime,
      );

      final Map<String, dynamic> senderData =
          senderContact.toMap(senderContact);

      await getContactsDocuments(of: receiverId, forContact: senderId)
          .set(senderData);
    }
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
    await _messageCollection
        .doc(_message.senderId)
        .collection(_message.receiverId!)
        .add(map);

    await _messageCollection
        .doc(_message.receiverId)
        .collection(_message.senderId!)
        .add(map);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchContacts(
          {required String userId}) =>
      _userCollection
          .doc(userId)
          .collection(AppDBConstants.contactsCollection)
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchLastMessageBetween(
          {required String senderId, required String receiverId}) =>
      _messageCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy(AppDBConstants.timestampField)
          .snapshots();
}
