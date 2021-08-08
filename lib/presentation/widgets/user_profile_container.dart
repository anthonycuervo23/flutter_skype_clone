import 'package:flutter/material.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/presentation/screens/login_screen.dart';
import 'package:skype_clone/presentation/widgets/appbar.dart';
import 'package:skype_clone/presentation/widgets/shimmering_logo.dart';
import 'package:skype_clone/presentation/widgets/user_profile_body.dart';

class UserProfileContainer extends StatelessWidget {
  const UserProfileContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();

      if (isLoggedOut) {
        // navigate the user to login screen,
        // that way user is not able to go back by tapping the back button
        Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(builder: (_) => const LoginScreen()),
            (Route<dynamic> route) => false);
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          CustomAppBar(
            title: const ShimmeringLogo(),
            actions: <Widget>[
              TextButton(
                onPressed: () => signOut(),
                child: const Text(
                  'Sign out',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            centerTitle: true,
          ),
          const UserProfileBody(),
        ],
      ),
    );
  }
}
