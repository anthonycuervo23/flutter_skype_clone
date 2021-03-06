import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

//My imports
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/presentation/screens/home_screen.dart';
import 'package:skype_clone/data/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Stack(
          children: <Widget>[
            Center(
              child: loginButton(),
            ),
            if (isLoginPressed)
              const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                ),
              )
            else
              Container()
          ],
        ));
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: AppColors.senderColor,
      child: MaterialButton(
        padding: const EdgeInsets.all(35.0),
        onPressed: () => performLogin(),
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  void performLogin() {
    print('Trying to perform login');
    setState(() {
      isLoginPressed = true;
    });
    _authMethods.signIn().then((UserCredential? user) {
      if (user != null) {
        authenticateUser(user.user!);
      } else {
        print('There was an error performing login');
      }
    });
  }

  void authenticateUser(User user) {
    _authMethods.authenticateUser(user).then((bool isNewUser) {
      setState(() {
        isLoginPressed = false;
      });
      if (isNewUser) {
        _authMethods.addDataToDb(user).then((void value) {
          Navigator.pushReplacement<dynamic, dynamic>(context,
              MaterialPageRoute<dynamic>(builder: (_) => const HomeScreen()));
        });
      } else {
        Navigator.pushReplacement<dynamic, dynamic>(context,
            MaterialPageRoute<dynamic>(builder: (_) => const HomeScreen()));
      }
    });
  }
}
