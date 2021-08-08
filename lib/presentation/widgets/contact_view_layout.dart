import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/data/resources/chat_methods.dart';
import 'package:skype_clone/presentation/chatscreens/chat_screen.dart';
import 'package:skype_clone/presentation/widgets/cached_image.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/presentation/widgets/last_message_container.dart';
import 'package:skype_clone/presentation/widgets/state_dot_indicator.dart';

class ViewLayout extends StatelessWidget {
  ViewLayout({Key? key, this.contact}) : super(key: key);

  final UserModel? contact;
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => ChatScreen(
            receiver: contact,
          ),
        ),
      ),
      title: Text(
        contact?.name ?? '...',
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Arial',
          fontSize: 19,
        ),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
            senderId: userProvider.getUser!.uid!, receiverId: contact!.uid!),
      ),
      leading: Container(
        constraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact!.profilePhoto!,
              radius: 80.0,
              isRound: true,
            ),
            StateIndicator(uid: contact!.uid!),
          ],
        ),
      ),
    );
  }
}
