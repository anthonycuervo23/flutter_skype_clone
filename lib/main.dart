import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/data/resources/firebase_repository.dart';
import 'package:skype_clone/presentation/screens/home_screen.dart';
import 'package:skype_clone/presentation/screens/login_screen.dart';
import 'package:skype_clone/presentation/screens/search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, Widget Function(BuildContext)>{
        '/search_screen': (_) => const SearchScreen(),
      },
      home: FutureBuilder<User>(
          future: _repository.getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
