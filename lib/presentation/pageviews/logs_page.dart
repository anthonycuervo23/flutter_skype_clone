import 'package:flutter/material.dart';
import 'package:skype_clone/data/constants/colors.dart';
import 'package:skype_clone/data/local_db/repository/log_repository.dart';
import 'package:skype_clone/data/models/log.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: TextButton(
          child: Text('Hello World!'),
          onPressed: () {
            LogRepository.init(isHive: true);
            LogRepository.addLogs(LogModel());
          },
        ),
      ),
    );
  }
}
