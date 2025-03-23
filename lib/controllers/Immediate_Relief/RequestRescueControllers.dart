import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relief/controllers/Immediate_Relief/RequestSuccessPage.dart';
import 'package:relief/controllers/StateCityController.dart';
import 'package:relief/services/immediate_relief/request_rescue_service.dart';

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

class UploadRequestRescue extends GetxController {
  final RRCImageController rrcImageController = Get.put(RRCImageController());
  final RequestRescueService requestRescueService = RequestRescueService();

  Future<void> upload(
    String name,
    String explainSituation,
    String additionalInformation,
    String address,
    String state,
    String city,
    String phoneNumber,
  ) async {
    try {
      var result = await requestRescueService.uploadData(
        name,
        explainSituation,
        additionalInformation,
        address,
        state,
        city,
        phoneNumber,
        rrcImageController.rrcimages, // Assuming this is a List<File>
      );

      print("Result: $result");

      // Check if the response indicates success
      if (result != null &&
          result.containsKey('success') &&
          result['success'] == "Data successfully registered") {
        // Navigate to the success page
        Get.to(() => Requestsuccesspage());
      } else {
        // Show error snackbar if result indicates an error or is unexpected
        String errorMessage = "Failed to upload data";
        if (result != null &&
            result.containsKey('error') &&
            result['message'] != null) {
          errorMessage = result['message'];
        }
        Get.snackbar(
          "Error",
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle unexpected exceptions
      print("Exception: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }
}
