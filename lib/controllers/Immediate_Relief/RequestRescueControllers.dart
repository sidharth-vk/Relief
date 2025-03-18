import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RRCImageController extends GetxController {
  // List to store the images
  var rrcimages = <File>[].obs;

  // Image picker instance

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Check if the method is available
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print("Picked Image: ${pickedFile.path}");
        rrcimages.add(File(pickedFile.path));
      } else {
        print("No image selected.");
      }
    } on MissingPluginException catch (e) {
      print("Error: ${e.message}");
    }
  }

  void removeImage(int index) {
    rrcimages.removeAt(index);
  }

  @override
  void onClose() {
    rrcimages = <File>[].obs;
    super.onClose();
  }
}
