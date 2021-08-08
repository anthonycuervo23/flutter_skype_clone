import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//My imports
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/data/utils/utilities.dart';
import 'package:skype_clone/presentation/widgets/appbar.dart';
import 'package:skype_clone/presentation/widgets/chat_list_container.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/presentation/widgets/new_chat_button.dart';
import 'package:skype_clone/presentation/widgets/user_circle.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
        title: const UserCircle(),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search_screen');
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        centerTitle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: const NewChatButton(),
      body: ChatListContainer(),
    );
  }
}
