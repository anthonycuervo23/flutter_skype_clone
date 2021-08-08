import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/data/enum/user_state.dart';
import 'package:skype_clone/data/provider/user_provider.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/presentation/callscreens/pickup/pickup_layout.dart';

//My imports
import 'package:skype_clone/presentation/pageviews/chat_list_page.dart';
import 'package:skype_clone/data/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController? _pageController;
  int _page = 0;

  UserProvider? userProvider;

  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);

      await userProvider!.refreshUser();

      _authMethods.setUserState(
          userId: userProvider!.getUser!.uid!, userState: UserState.Online);
    });

    WidgetsBinding.instance!.addObserver(this);

    _pageController = PageController();
    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    _pageController!.jumpToPage(page);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final String? currentUserId =
        (userProvider != null && userProvider!.getUser! != null)
            ? userProvider!.getUser!.uid
            : '';
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print('==> resumed state');
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print('==> inactive state');
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print('==> paused state');
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print('==> Detached State');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: PageView(
          children: const <Widget>[
            ChatListPage(),
            Center(
              child: Text(
                'Call Logs',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                'Contact Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          controller: _pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
            backgroundColor: AppColors.blackColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: _page == 0
                      ? AppColors.lightBlueColor
                      : AppColors.greyColor,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.call,
                  color: _page == 1
                      ? AppColors.lightBlueColor
                      : AppColors.greyColor,
                ),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.contact_phone,
                  color: _page == 2
                      ? AppColors.lightBlueColor
                      : AppColors.greyColor,
                ),
                label: 'Contacts',
              ),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}
