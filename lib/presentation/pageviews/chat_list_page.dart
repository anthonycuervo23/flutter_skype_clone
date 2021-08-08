import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//My imports
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/data/utils/utilities.dart';
import 'package:skype_clone/presentation/widgets/appbar.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/data/constants/colors.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

//global
final AuthMethods _authMethods = AuthMethods();

class _ChatListPageState extends State<ChatListPage> {
  String? currentUserId;
  String initials = '';

  @override
  void initState() {
    _authMethods.getCurrentUser().then((User user) {
      setState(() {
        currentUserId = user.uid;
        initials = Utils.getInitials(user.displayName!);
      });
    });
    super.initState();
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
        title: UserCircle(text: initials),
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
      body: ChatListContainer(currentUserId: currentUserId),
    );
  }
}

class UserCircle extends StatelessWidget {
  const UserCircle({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: AppColors.separatorColor),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              text!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightBlueColor,
                  fontSize: 13),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.blackColor,
                    width: 2,
                  ),
                  color: AppColors.onlineDotColor),
            ),
          )
        ],
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  const NewChatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.fabGradient,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: const EdgeInsets.all(15.0),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  const ChatListContainer({Key? key, this.currentUserId}) : super(key: key);

  final String? currentUserId;

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return CustomTile(
            mini: false,
            onTap: () {},
            title: const Text(
              'Jean Cuervo',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Arial',
                fontSize: 19,
              ),
            ),
            subtitle: const Text(
              'Hello',
              style: TextStyle(color: AppColors.greyColor, fontSize: 14),
            ),
            leading: Container(
              constraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: <Widget>[
                  const CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        'https://yt3.ggpht.com/a/AGF-l7_zT8BuWwHTymaQaBptCy7WrsOD72gYGp-puw=s900-c-k-c0xffffffff-no-rj-mo'),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.onlineDotColor,
                          border: Border.all(
                              color: AppColors.blackColor, width: 2.0)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
