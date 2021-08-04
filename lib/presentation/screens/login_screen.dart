import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype_clone/data/resources/firebase_repository.dart';
import 'package:skype_clone/presentation/screens/home_screen.dart';
import 'package:skype_clone/utils/variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Variables.blackColor,
        body: Stack(
          children: [
            Center(
              child: loginButton(),
            ),
            isLoginPressed
                ? Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                    ),
                  )
                : Container()
          ],
        ));
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Variables.senderColor,
      child: MaterialButton(
        padding: EdgeInsets.all(35.0),
        onPressed: () => performLogin(),
        child: Text(
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
    _repository.signIn().then((UserCredential? user) {
      if (user != null) {
        authenticateUser(user.user!);
      } else {
        print('There was an error performing login');
      }
    });
  }

  void authenticateUser(User user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }
}
