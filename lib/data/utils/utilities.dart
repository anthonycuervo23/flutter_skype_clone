import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
}
