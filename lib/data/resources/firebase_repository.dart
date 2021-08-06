import 'package:firebase_auth/firebase_auth.dart';

//My imports
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/models/message.dart';
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
}
