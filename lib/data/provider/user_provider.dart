import 'package:flutter/foundation.dart';

import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  final AuthMethods _authMethods = AuthMethods();

  UserModel? get getUser => _user;

  Future<void> refreshUser() async {
    final UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
