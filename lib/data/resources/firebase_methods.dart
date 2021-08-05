import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/utils/utilities.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        .collection('users')
        .where('email', isEqualTo: user.email)
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
        .collection('users')
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
        await firestore.collection('users').get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }
}
