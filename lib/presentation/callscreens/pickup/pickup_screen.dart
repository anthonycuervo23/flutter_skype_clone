import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';

//My imports
import 'package:skype_clone/data/models/call.dart';
import 'package:skype_clone/data/resources/call_methods.dart';
import 'package:skype_clone/data/utils/permissions.dart';
import 'package:skype_clone/presentation/callscreens/call_screen.dart';
import 'package:skype_clone/presentation/widgets/cached_image.dart';

class PickupScreen extends StatelessWidget {
  PickupScreen({Key? key, required this.call}) : super(key: key);

  final CallModel call;
  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Incoming...',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            CachedImage(
              call.callerPic!,
              isRound: true,
              radius: 180,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              call.callerName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                ),
                const SizedBox(
                  width: 25.0,
                ),
                IconButton(
                  icon: const Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () async =>
                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (_) => CallScreen(
                                  call: call,
                                  role: ClientRole.Broadcaster,
                                ),
                              ),
                            )
                          : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
