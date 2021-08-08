import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/data/resources/chat_methods.dart';
import 'package:skype_clone/data/models/contact.dart';
import 'package:skype_clone/presentation/widgets/contact_view.dart';
import 'package:skype_clone/presentation/widgets/quiet_box.dart';

class ChatListContainer extends StatelessWidget {
  ChatListContainer({Key? key}) : super(key: key);

  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _chatMethods.fetchContacts(userId: userProvider.getUser!.uid!),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> docList =
                snapshot.data!.docs;

            if (docList.isEmpty) {
              return const QuietBox();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: docList.length,
              itemBuilder: (BuildContext context, int index) {
                final ContactModel contact =
                    ContactModel.fromMap(docList[index].data());

                return ContactView(contact: contact);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
