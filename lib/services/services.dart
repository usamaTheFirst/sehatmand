import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:sehatmand/utils/file_utils.dart';
import 'package:sehatmand/utils/firebase.dart';

abstract class Service {

  //function to upload images to firebase storage and retrieve the url.
  Future<String> uploadImage(Reference ref, File file) async {
    print("uploading image");
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }
}
