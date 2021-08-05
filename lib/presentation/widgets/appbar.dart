import 'package:flutter/material.dart';
import 'package:skype_clone/utils/variables.dart';

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
        color: blackColor,
        border: Border(
          bottom: BorderSide(
              color: separatorColor, width: 1.4, style: BorderStyle.solid),
        ),
      ),
      child: AppBar(
        backgroundColor: blackColor,
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
