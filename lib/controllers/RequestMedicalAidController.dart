import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RMAImageController extends GetxController {
  // List to store the images
  var rmaimages = <File>[].obs;

  // Image picker instance

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Check if the method is available
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print("Picked Image: ${pickedFile.path}");
        rmaimages.add(File(pickedFile.path));
      } else {
        print("No image selected.");
      }
    } on MissingPluginException catch (e) {
      print("Error: ${e.message}");
    }
  }

  void removeImage(int index) {
    rmaimages.removeAt(index);
  }

  @override
  void onClose() {
    rmaimages = <File>[].obs;
    super.onClose();
  }
}
