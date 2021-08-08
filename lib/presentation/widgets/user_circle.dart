import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/data/utils/utilities.dart';

class UserCircle extends StatelessWidget {
  const UserCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
              Utils.getInitials(userProvider.getUser!.name!),
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
