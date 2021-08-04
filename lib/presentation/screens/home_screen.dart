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
    double _labelFontSize = 10.0;
    return Scaffold(
      backgroundColor: Variables.blackColor,
      body: PageView(
        children: [
          Container(
            child: ChatListPage(),
          ),
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
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
            backgroundColor: Variables.blackColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: _page == 0
                      ? Variables.lightBlueColor
                      : Variables.greyColor,
                ),
                title: Text(
                  'Chats',
                  style: TextStyle(
                      fontSize: _labelFontSize,
                      color: _page == 0
                          ? Variables.lightBlueColor
                          : Variables.greyColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.call,
                  color: _page == 1
                      ? Variables.lightBlueColor
                      : Variables.greyColor,
                ),
                title: Text(
                  'Calls',
                  style: TextStyle(
                      fontSize: _labelFontSize,
                      color: _page == 1
                          ? Variables.lightBlueColor
                          : Variables.greyColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.contact_phone,
                  color: _page == 2
                      ? Variables.lightBlueColor
                      : Variables.greyColor,
                ),
                title: Text(
                  'Contacts',
                  style: TextStyle(
                      fontSize: _labelFontSize,
                      color: _page == 2
                          ? Variables.lightBlueColor
                          : Variables.greyColor),
                ),
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
