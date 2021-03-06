import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//My imports
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/resources/auth_methods.dart';
import 'package:skype_clone/presentation/chatscreens/chat_screen.dart';
import 'package:skype_clone/presentation/widgets/custom_tile.dart';
import 'package:skype_clone/data/constants/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AuthMethods _authMethods = AuthMethods();

  List<UserModel> userList = <UserModel>[];
  String query = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _authMethods.getCurrentUser().then((User? user) {
      _authMethods.fetchAllUsers(user!).then((List<UserModel> list) {
        setState(() {
          userList = list;
        });
      });
    });
    super.initState();
  }

  PreferredSizeWidget searchAppBar(BuildContext context) {
    return NewGradientAppBar(
      gradient: const LinearGradient(colors: <Color>[
        AppColors.gradientColorStart,
        AppColors.gradientColorEnd
      ]),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: searchController,
            onChanged: (String value) {
              setState(() {
                query = value;
              });
            },
            cursorColor: AppColors.blackColor,
            autofocus: true,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35.0),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => searchController.clear(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color(0x88ffffff))),
          ),
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
      ),
    );
  }

  Widget buildSuggestions(String query) {
    final List<UserModel> suggestionList = query.isEmpty
        ? <UserModel>[]
        : userList.where((UserModel user) {
            final String _getUsername = user.username!.toLowerCase();
            final String _query = query.toLowerCase();
            final String _getName = user.name!.toLowerCase();
            final bool matchesUserName = _getUsername.contains(_query);
            final bool matchesName = _getName.contains(_query);

            return matchesUserName || matchesName;
          }
            // (UserModel user) =>
            //     user.username!.toLowerCase().contains(query.toLowerCase()) || user.name!.toLowerCase().contains(query.toLowerCase()),
            ).toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          final UserModel searchedUser = UserModel(
            uid: suggestionList[index].uid,
            profilePhoto: suggestionList[index].profilePhoto,
            name: suggestionList[index].name,
            username: suggestionList[index].username,
          );
          return CustomTile(
            mini: false,
            onTap: () {
              Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (_) => ChatScreen(receiver: searchedUser)));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(searchedUser.profilePhoto!),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              searchedUser.username!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              searchedUser.name!,
              style: const TextStyle(color: AppColors.greyColor),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: buildSuggestions(query),
      ),
    );
  }
}
