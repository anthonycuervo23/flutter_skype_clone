import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:skype_clone/data/provider/image_upload_provider.dart';
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';
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
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageUploadProvider>(
            create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: <String, Widget Function(BuildContext)>{
          '/search_screen': (_) => const SearchScreen(),
        },
        theme: ThemeData(brightness: Brightness.dark),
        home: FutureBuilder<User?>(
            future: _authMethods.getCurrentUser(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const LoginScreen();
              }
            }),
      ),
    );
  }
}
