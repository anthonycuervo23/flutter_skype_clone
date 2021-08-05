import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/presentation/pageviews/chat_list_page.dart';
import 'package:skype_clone/utils/variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _page = 0;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
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
          backgroundColor: blackColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: _page == 0 ? lightBlueColor : greyColor,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
                color: _page == 1 ? lightBlueColor : greyColor,
              ),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.contact_phone,
                color: _page == 2 ? lightBlueColor : greyColor,
              ),
              label: 'Contacts',
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
