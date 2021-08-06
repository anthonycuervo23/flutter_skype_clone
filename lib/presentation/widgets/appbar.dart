import 'package:flutter/material.dart';

//My imports
import 'package:skype_clone/data/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.actions,
      required this.leading,
      required this.centerTitle})
      : super(key: key);

  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: AppColors.blackColor,
        border: Border(
          bottom: BorderSide(
              color: AppColors.separatorColor,
              width: 1.4,
              style: BorderStyle.solid),
        ),
      ),
      child: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
