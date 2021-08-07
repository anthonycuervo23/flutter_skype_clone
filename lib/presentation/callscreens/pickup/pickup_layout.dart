import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/data/resources/call_methods.dart';
import 'package:skype_clone/data/models/call.dart';
import 'package:skype_clone/presentation/callscreens/pickup/pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  PickupLayout({Key? key, required this.scaffold}) : super(key: key);

  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid!),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                final CallModel call =
                    CallModel.fromMap(snapshot.data!.data()!);
                if (!call.hasDialled!) {
                  return PickupScreen(call: call);
                }

                return scaffold;
              }
              return scaffold;
            })
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
