import 'package:flutter/foundation.dart';

import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/resources/firebase_repository.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    final UserModel user = await _firebaseRepository.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
