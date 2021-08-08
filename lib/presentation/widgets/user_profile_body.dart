import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/presentation/widgets/cached_image.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.getUser;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          CachedImage(
            user!.profilePhoto!,
            isRound: true,
            radius: 50.0,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                user.email!,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
