import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:skype_clone/data/enum/user_state.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getUserName(String email) {
    return 'live:${email.split('@')[0]}';
  }

  static String getInitials(String name) {
    final List<String> nameSplit = name.split(' ');
    final String firstNameInitial = nameSplit[0][0];
    final String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  static Future<File?> pickImage({required ImageSource source}) async {
    final XFile? image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 500,
      maxHeight: 500,
    );
    final File selectedImage = File(image!.path);
    return selectedImage;
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;
      case UserState.Online:
        return 1;
      default:
        return 2;
    }
  }

  static UserState numToState(int? number) {
    switch (number) {
      case 0:
        return UserState.Offline;
      case 1:
        return UserState.Online;
      default:
        return UserState.Waiting;
    }
  }

  static String formatDateString(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd/MM/yy');
    return formatter.format(dateTime);
  }
}
