import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

//My imports
import 'package:skype_clone/data/constants/data_constants.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/models/message.dart';
import 'package:skype_clone/data/provider/image_upload_provider.dart';
import 'package:skype_clone/data/utils/utilities.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  UserModel userModel = UserModel();

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser!;
    return currentUser;
  }

  Future<UserCredential> signIn() async {
    final GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _signInAuth =
        await _signInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _signInAuth.accessToken, idToken: _signInAuth.idToken);

    final UserCredential user = await _auth.signInWithCredential(credential);

    return user;
  }

  Future<bool> authenticateUser(User user) async {
    final QuerySnapshot<Object?> result = await firestore
        .collection(AppDBConstants.usersCollection)
        .where(AppDBConstants.emailField, isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot<Object?>> docs = result.docs;

    //if user is registered then length of list > 0 else length = 0
    return docs.isEmpty || false;
  }

  Future<void> addDataToDb(User currentUser) async {
    final String username = Utils.getUserName(currentUser.email!);

    userModel = UserModel(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoURL,
      username: username,
    );

    firestore
        .collection(AppDBConstants.usersCollection)
        .doc(currentUser.uid)
        .set(userModel.toMap(userModel));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return _auth.signOut();
  }

  Future<List<UserModel>> fetchAllUsers(User currentUser) async {
    final List<UserModel> userList = <UserModel>[];

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection(AppDBConstants.usersCollection).get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

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

  Future<String> uploadImageToStorage(File image) async {
    try {
      final Reference _ref =
          storage.ref().child('${DateTime.now().millisecondsSinceEpoch}');

      final UploadTask _uploadTask = _ref.putFile(image);

      await _uploadTask;
      return _ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
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

  Future<void> uploadImage(
    File image,
    String receiverId,
    String senderId,
    ImageUploadProvider imageUploadProvider,
  ) async {
    //Show loading
    imageUploadProvider.setToLoading();

    //Get url from the image bucket
    final String url = await uploadImageToStorage(image);

    //Hide loading
    imageUploadProvider.setToIdle();

    setImageMsg(url, receiverId, senderId);
  }
}
