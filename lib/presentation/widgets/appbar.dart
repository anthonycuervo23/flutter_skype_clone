import 'package:flutter/material.dart';
import 'package:skype_clone/utils/variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.actions,
      required this.leading,
      required this.centerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Variables.blackColor,
        border: Border(
          bottom: BorderSide(
              color: Variables.separatorColor,
              width: 1.4,
              style: BorderStyle.solid),
        ),
      ),
      child: AppBar(
        backgroundColor: Variables.blackColor,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}
