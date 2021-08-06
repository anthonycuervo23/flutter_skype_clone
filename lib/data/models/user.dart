//My imports
import 'package:skype_clone/data/constants/user_fields.dart';

class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData[UserFields.uid];
    name = mapData[UserFields.name];
    email = mapData[UserFields.email];
    username = mapData[UserFields.username];
    status = mapData[UserFields.status];
    state = mapData[UserFields.state];
    profilePhoto = mapData[UserFields.profilePhoto];
  }

  Map<String, dynamic> toMap(UserModel user) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[UserFields.uid] = user.uid;
    data[UserFields.name] = user.name;
    data[UserFields.email] = user.email;
    data[UserFields.username] = user.username;
    data[UserFields.status] = user.status;
    data[UserFields.state] = user.state;
    data[UserFields.profilePhoto] = user.profilePhoto;
    return data;
  }

  String? uid;
  String? name;
  String? email;
  String? username;
  String? status;
  int? state;
  String? profilePhoto;
}
