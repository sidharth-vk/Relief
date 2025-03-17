import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RSCImageController extends GetxController {
  // List to store the images
  var rscimages = <File>[].obs;
  var selectedservices = ''.obs;

  final List<String> servicess = [
    "Search and Rescue Operations",
    "Medical Assistance and First Aid",
    "Emergency Shelter and Housing",
    "Food and Water Distribution",
    "Psychological and Trauma Support",
    "Financial Assistance and Emergency Relief Funds",
    "Debris Removal and Cleanup",
    "Restoration of Essential Services (electricity, water, communications)",
    "Rebuilding and Repair Services (homes, infrastructure)",
    "Transportation Assistance for Evacuation or Relief",
    "Family Reunification Services",
    "Animal Rescue and Pet Care",
    "Legal Assistance for Claiming Insurance and Relief Aid",
    "Disaster-Related Information Dissemination (hotlines, apps, etc.)",
    "Temporary Employment and Livelihood Support"
  ];
  void updateSelectedservices(String value) {
    selectedservices.value = value;
  }

  // Image picker instance

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Check if the method is available
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print("Picked Image: ${pickedFile.path}");
        rscimages.add(File(pickedFile.path));
      } else {
        print("No image selected.");
      }
    } on MissingPluginException catch (e) {
      print("Error: ${e.message}");
    }
  }

  void removeImage(int index) {
    rscimages.removeAt(index);
  }

  @override
  void onClose() {
    rscimages = <File>[].obs;
    selectedservices = ''.obs;

    super.onClose();
  }
}
