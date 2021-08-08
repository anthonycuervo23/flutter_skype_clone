import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/data/enum/user_state.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/data/utils/utilities.dart';

class StateIndicator extends StatelessWidget {
  StateIndicator({Key? key, required this.uid}) : super(key: key);

  final String uid;
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    Color getColor(int? state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return AppColors.offlineDotColor;
        case UserState.Online:
          return AppColors.onlineDotColor;
        default:
          return AppColors.waitingDotColor;
      }
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _authMethods.getUserStream(uid: uid),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            UserModel user = UserModel();

            if (snapshot.hasData && snapshot.data!.data() != null) {
              user = UserModel.fromMap(snapshot.data!.data()!);
            }
            return Container(
              height: 13.0,
              width: 13.0,
              margin: const EdgeInsets.only(
                right: 8.0,
                top: 8.0,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: getColor(user.state)),
            );
          }),
    );
  }
}
