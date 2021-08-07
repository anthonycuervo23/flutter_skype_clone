import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/data/resources/call_methods.dart';
import 'package:skype_clone/data/models/call.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/presentation/callscreens/call_screen.dart';

class CallUtils {
  final CallMethods callMethods = CallMethods();

  Future<void> dial(
      {required UserModel from,
      required UserModel to,
      required BuildContext context}) async {
    final CallModel call = CallModel(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    final bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => CallScreen(
            call: call,
            role: ClientRole.Broadcaster,
          ),
        ),
      );
    }
  }
}
