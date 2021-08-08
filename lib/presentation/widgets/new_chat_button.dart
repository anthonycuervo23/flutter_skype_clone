import 'package:flutter/material.dart';
import 'package:skype_clone/data/constants/colors.dart';

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
