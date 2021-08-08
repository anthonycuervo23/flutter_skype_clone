import 'package:flutter/material.dart';
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/presentation/screens/search_screen.dart';

class QuietBox extends StatelessWidget {
  const QuietBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Container(
          color: AppColors.separatorColor,
          padding: const EdgeInsets.symmetric(
            vertical: 35.0,
            horizontal: 25.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'This is where all the contacts are listed',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                'Search for your friends and family to start calling or chatting with them',
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0),
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextButton(
                onPressed: () => Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => const SearchScreen(),
                  ),
                ),
                child: const Text('START SEARCHING'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
