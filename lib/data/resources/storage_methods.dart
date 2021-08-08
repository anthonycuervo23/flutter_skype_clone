import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skype_clone/data/models/user.dart';
import 'package:skype_clone/data/provider/image_upload_provider.dart';
import 'package:skype_clone/data/resources/chat_methods.dart';

class StorageMethods {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  UserModel userModel = UserModel();

  Future<String> uploadImageToStorage(File image) async {
    try {
      final Reference _ref =
          storage.ref().child('${DateTime.now().millisecondsSinceEpoch}');

      final UploadTask _uploadTask = _ref.putFile(image);

      await _uploadTask;
      return _ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<void> uploadImage({
    required File image,
    required String receiverId,
    required String senderId,
    required ImageUploadProvider imageUploadProvider,
  }) async {
    final ChatMethods chatMethods = ChatMethods();
    //Show loading
    imageUploadProvider.setToLoading();

    //Get url from the image bucket
    final String url = await uploadImageToStorage(image);

    //Hide loading
    imageUploadProvider.setToIdle();

    chatMethods.setImageMsg(url, receiverId, senderId);
  }
}
