import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//My imports
import 'package:skype_clone/data/constants/data_constants.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/resources/firebase_repository.dart';
import 'package:skype_clone/presentation/widgets/appbar.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/data/models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, this.receiver}) : super(key: key);

  final UserModel? receiver;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();
  final FocusNode textFieldFocus = FocusNode();

  final FirebaseRepository _repository = FirebaseRepository();

  UserModel? sender;

  String? _currentUserId;

  bool isWriting = false;

  bool showEmojiPicker = false;

  @override
  void initState() {
    _repository.getCurrentUser().then((User user) {
      _currentUserId = user.uid;

      setState(() {
        sender = UserModel(
          uid: user.uid,
          name: user.displayName,
          profilePhoto: user.photoURL,
        );
      });
    });
    super.initState();
  }

  void showKeyboard() => textFieldFocus.requestFocus();

  void hideKeyboard() => textFieldFocus.unfocus();

  void hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: customAppBar(context),
      body: Column(
        children: <Widget>[
          Flexible(
            child: messageList(),
          ),
          chatControls(),
          if (showEmojiPicker)
            SizedBox(
              height: 250,
              child: emojiContainer(),
            )
          else
            Container(),
        ],
      ),
    );
  }

  Widget emojiContainer() {
    return EmojiPicker(
        config: const Config(
          bgColor: AppColors.separatorColor,
          indicatorColor: AppColors.blueColor,
        ),
        onEmojiSelected: (Category category, Emoji emoji) {
          setState(() {
            isWriting = true;
          });
          _textFieldController.text = _textFieldController.text + emoji.emoji;
        });
  }

  Widget messageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(AppDBConstants.messagesCollection)
            .doc(_currentUserId)
            .collection(widget.receiver!.uid!)
            .orderBy(AppDBConstants.timestampField, descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CupertinoActivityIndicator(
                animating: true,
              ),
            );
          }

          //this is used to automatically scroll to bottom
          //when new message arrives or new message is typed

          // SchedulerBinding.instance!.addPostFrameCallback((_) {
          //   _listScrollController.animateTo(
          //       _listScrollController.position.minScrollExtent,
          //       duration: const Duration(milliseconds: 250),
          //       curve: Curves.easeInOut);
          // });

          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data!.docs.length,
            reverse: true,
            controller: _listScrollController,
            itemBuilder: (BuildContext context, int index) {
              return chatMessageItem(snapshot.data!.docs[index]);
            },
          );
        });
  }

  Widget chatMessageItem(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final MessageModel _message = MessageModel.fromMap(snapshot.data());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        alignment: _message.senderId == _currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == _currentUserId
            ? senderLayout(_message)
            : receiverLayout(_message),
      ),
    );
  }

  Widget senderLayout(MessageModel message) {
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
            color: AppColors.senderColor,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: getMessage(message),
          ),
        ),
      ],
    );
  }

  Widget receiverLayout(MessageModel message) {
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
            color: AppColors.senderColor,
            borderRadius: BorderRadius.only(
              bottomRight: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: getMessage(message),
          ),
        ),
      ],
    );
  }

  Widget getMessage(MessageModel message) {
    return Text(
      message.message!,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
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
        backgroundColor: AppColors.blackColor,
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
                  gradient: AppColors.fabGradient, shape: BoxShape.circle),
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  controller: _textFieldController,
                  focusNode: textFieldFocus,
                  onTap: () => hideEmojiContainer(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (String val) {
                    (val.isNotEmpty && val.trim() != '')
                        ? setWritingTo(true)
                        : setWritingTo(false);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(
                      color: AppColors.greyColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    filled: true,
                    fillColor: AppColors.separatorColor,
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    if (!showEmojiPicker) {
                      //Keyboard is visible
                      hideKeyboard();
                      showEmojiContainer();
                    } else {
                      //Keyboard is hidden
                      showKeyboard();
                      hideEmojiContainer();
                    }
                  },
                  icon: Icon(
                    Icons.face,
                    color: !showEmojiPicker
                        ? AppColors.greyColor
                        : AppColors.blueColor,
                  ),
                ),
              ],
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
                  gradient: AppColors.fabGradient, shape: BoxShape.circle),
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
    final String text = _textFieldController.text;

    final MessageModel _message = MessageModel(
      receiverId: widget.receiver!.uid,
      senderId: sender!.uid,
      message: text,
      timestamp: Timestamp.now(),
      type: 'text',
    );

    setState(() {
      isWriting = false;
    });

    _textFieldController.text = '';

    _repository.addMessageToDb(_message, sender!, widget.receiver!);
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
            color: AppColors.receiverColor,
          ),
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            color: AppColors.greyColor,
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
            color: AppColors.greyColor,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
