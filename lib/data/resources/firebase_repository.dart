import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

//My imports
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/models/message.dart';
import 'package:skype_clone/data/provider/image_upload_provider.dart';
import 'package:skype_clone/data/resources/firebase_methods.dart';

class FirebaseRepository {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<UserCredential> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<UserModel>> fetchAllUsers(User currentUser) =>
      _firebaseMethods.fetchAllUsers(currentUser);

  // Future<UserModel> fetchUserDetailsById(String uid) => _firebaseMethods.fetchUserDetailsById(uid);

  Future<void> addMessageToDb(
          MessageModel message, UserModel sender, UserModel receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

  void uploadImage({
    required File? image,
    required String receiverId,
    required String senderId,
    required ImageUploadProvider imageUploadProvider,
  }) =>
      _firebaseMethods.uploadImage(
        image!,
        receiverId,
        senderId,
        imageUploadProvider,
      );
}
