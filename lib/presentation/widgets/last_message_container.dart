import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/data/models/message.dart';

class LastMessageContainer extends StatelessWidget {
  const LastMessageContainer({Key? key, required this.stream})
      : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> docList =
                snapshot.data!.docs;

            if (docList.isNotEmpty) {
              final MessageModel message =
                  MessageModel.fromMap(docList.last.data());

              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  message.message!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              );
            }
            return const Text(
              'No Message',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            );
          }
          return const Text(
            '...',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          );
        });
  }
}
