import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/constants/contact_fields.dart';

class ContactModel {
  ContactModel({this.uid, this.addedOn});

  Map<String, dynamic> toMap(ContactModel contact) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ContactFields.contactUid] = contact.uid;
    data[ContactFields.contactAddedOn] = contact.addedOn;
    return data;
  }

  ContactModel.fromMap(Map<String, dynamic> data) {
    uid = data[ContactFields.contactUid];
    addedOn = data[ContactFields.contactAddedOn];
  }

  String? uid;
  Timestamp? addedOn;
}
