import 'package:flutter/material.dart';
import 'package:skype_clone/data/resources/firebase_repository.dart';
import 'package:skype_clone/presentation/widgets/appbar.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/utils/utilities.dart';
import 'package:skype_clone/utils/variables.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

//global
final FirebaseRepository _repository = FirebaseRepository();

class _ChatListPageState extends State<ChatListPage> {
  String? currentUserId;
  String initials = '';

  @override
  void initState() {
    _repository.getCurrentUser().then((user) {
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        centerTitle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
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
          color: Variables.separatorColor),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              text!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Variables.lightBlueColor,
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
                    color: Variables.blackColor,
                    width: 2,
                  ),
                  color: Variables.onlineDotColor),
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
        gradient: Variables.fabGradient,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15.0),
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
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return CustomTile(
              mini: false,
              onTap: () {},
              title: Text(
                'Jean Cuervo',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Arial',
                  fontSize: 19,
                ),
              ),
              subtitle: Text(
                'Hello',
                style: TextStyle(color: Variables.greyColor, fontSize: 14),
              ),
              leading: Container(
                constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
                child: Stack(
                  children: [
                    CircleAvatar(
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
                            color: Variables.onlineDotColor,
                            border: Border.all(
                                color: Variables.blackColor, width: 2.0)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
