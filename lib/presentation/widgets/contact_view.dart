import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//My imports
import 'package:skype_clone/data/models/contact.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/presentation/widgets/contact_view_layout.dart';

class ContactView extends StatelessWidget {
  ContactView({Key? key, this.contact}) : super(key: key);

  final ContactModel? contact;
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: _authMethods.getUserDetailsById(contact!.uid!),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            final UserModel user = snapshot.data!;

            return ViewLayout(
              contact: user,
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(
              animating: true,
            ),
          );
        });
  }
}
