import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class DamageAssistanceController extends GetxController {
  // List to store the images
  var daimage = <File>[].obs;
  var daIDimage = <File>[].obs;
  var selectedtypeofdamage = ''.obs;
  var files = Rx<List<FileInfo>>([]);

  final List<String> type0fdamage = [
    "Structural Damage",
    "Water Damage",
    "Fire Damage",
    "Electrical Damage",
    "Wind Damage",
    "Flood Damage",
    "Landslide or Earthquake Damage",
    "Vehicular Damage",
    "Damage to Personal Belongings",
    "Crop or Agricultural Damage",
    "Infrastructure Damage",
    "Medical/Health Damage",
    "Psychological Damage",
    "Other Damage"
  ];

  Future<void> pickIDImage() async {
    final ImagePicker _pickerID = ImagePicker();

    // Check if the method is available
    try {
      final XFile? pickedIDFile =
          await _pickerID.pickImage(source: ImageSource.gallery);
      if (pickedIDFile != null) {
        print("Picked Image: ${pickedIDFile.path}");
        daIDimage.add(File(pickedIDFile.path));
      } else {
        print("No image selected.");
      }
    } on MissingPluginException catch (e) {
      print("Error: ${e.message}");
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Check if the method is available
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print("Picked Image: ${pickedFile.path}");
        daimage.add(File(pickedFile.path));
      } else {
        print("No image selected.");
      }
    } on MissingPluginException catch (e) {
      print("Error: ${e.message}");
    }
  }

// Method to pick multiple files
  Future<void> pickFiles() async {
    // Specify allowed file extensions (custom filter)
    List<String> allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'docx'];

    // Open the file picker with the allowed extensions and FileType.custom
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Use FileType.custom
      allowedExtensions: allowedExtensions, // Restrict to these extensions
    );

    if (result != null && result.files.isNotEmpty) {
      // Add selected files to the files list
      for (var platformFile in result.files) {
        // Create FileInfo for each selected file
        FileInfo fileInfo = FileInfo(
          name: platformFile.name,
          size: platformFile.size,
          path: platformFile.path!,
        );
        files.value.add(fileInfo); // Add file to the list
      }
      files.refresh(); // Refresh Rx to update UI
    }
  }

  void removemediaImage(int index) {
    daimage.removeAt(index);
  }

  void removeIDImage(int index) {
    daIDimage.removeAt(index);
  }

  void updateSelectedtypeofdamage(String value) {
    selectedtypeofdamage.value = value;
  }

  // Method to remove a file from the list by index
  void removeFile(int index) {
    files.value.removeAt(index); // Remove the file at the given index
    files.refresh(); // Refresh the Rx variable to update the UI
  }

  @override
  void onClose() {
    daimage = <File>[].obs;
    selectedtypeofdamage = ''.obs;
    files = Rx<List<FileInfo>>([]);
    daIDimage = <File>[].obs;
    super.onClose();
  }
}

class FileInfo {
  final String name;
  final int size;
  final String path;

  FileInfo({required this.name, required this.size, required this.path});
}
