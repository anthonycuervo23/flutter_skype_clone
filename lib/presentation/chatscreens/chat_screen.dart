import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/presentation/widgets/appbar.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/utils/variables.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, this.receiver}) : super(key: key);

  final UserModel? receiver;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  bool isWriting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: customAppBar(context),
      body: Column(
        children: <Widget>[
          Flexible(child: messageList()),
          chatControls(),
        ],
      ),
    );
  }

  Widget messageList() {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return chatMessageItem();
        });
  }

  Widget chatMessageItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        child: senderLayout(),
      ),
    );
  }

  Widget senderLayout() {
    const Radius messageRadius = Radius.circular(10.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          // alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(top: 12.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          decoration: const BoxDecoration(
            color: senderColor,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Hello',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget receiverLayout() {
    const Radius messageRadius = Radius.circular(10.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          // alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 12.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          decoration: const BoxDecoration(
            color: senderColor,
            borderRadius: BorderRadius.only(
              bottomRight: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Hello',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget chatControls() {
    void setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    void addMediaModal(BuildContext context) {
      showModalBottomSheet<dynamic>(
        context: context,
        elevation: 0,
        backgroundColor: blackColor,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.close),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Content and tools',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  children: const <Widget>[
                    ModalTile(
                      title: 'Media',
                      subtitle: 'Share Photos and Video',
                      icon: Icons.image,
                    ),
                    ModalTile(
                      title: 'File',
                      subtitle: 'Share Files',
                      icon: Icons.tab,
                    ),
                    ModalTile(
                      title: 'Contact',
                      subtitle: 'Share Contacts',
                      icon: Icons.contacts,
                    ),
                    ModalTile(
                      title: 'Location',
                      subtitle: 'Share a location',
                      icon: Icons.add_location,
                    ),
                    ModalTile(
                      title: 'Schedule Call',
                      subtitle: 'Arrange a skype call and get reminders',
                      icon: Icons.schedule,
                    ),
                    ModalTile(
                      title: 'Create Poll',
                      subtitle: 'Share polls',
                      icon: Icons.poll,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                  gradient: fabGradient, shape: BoxShape.circle),
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (String val) {
                (val.isNotEmpty && val.trim() != '')
                    ? setWritingTo(true)
                    : setWritingTo(false);
              },
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: const TextStyle(
                  color: greyColor,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                filled: true,
                fillColor: separatorColor,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.face),
                ),
              ),
            ),
          ),
          if (isWriting)
            Container()
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.record_voice_over),
            ),
          if (isWriting) Container() else const Icon(Icons.camera_alt),
          if (isWriting)
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              decoration: const BoxDecoration(
                  gradient: fabGradient, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  size: 15.0,
                ),
                onPressed: () => sendMessage(),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  void sendMessage() {
    String text = _controller.text;
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
        title: Text(widget.receiver!.name!),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
          ),
        ],
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        centerTitle: false);
  }
}

class ModalTile extends StatelessWidget {
  const ModalTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon})
      : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: CustomTile(
        mini: false,
        leading: Container(
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: receiverColor,
          ),
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            color: greyColor,
            size: 38,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: greyColor,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
