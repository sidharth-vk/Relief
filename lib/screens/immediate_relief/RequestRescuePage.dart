import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/Immediate_Relief/RequestRescueControllers.dart';
import 'package:relief/controllers/StateCityController.dart';
import 'package:relief/screens/widgets/CustomStateandCitydropdown.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';

// ignore: must_be_immutable
class Requestrescuepage extends StatelessWidget {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _explanationcontroller = TextEditingController();
  final TextEditingController _additional_informationcontroller =
      TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _phone_numbercontroller = TextEditingController();
  final RRCImageController _imageController = Get.put(RRCImageController());
  final StateCityController _stateCityControllerRRC =
      Get.put(StateCityController());
  final UploadRequestRescue uploadRequestRescue =
      Get.put(UploadRequestRescue());

  Requestrescuepage({super.key});

  // Validation function
  bool _validateForm() {
    if (_namecontroller.text.trim().isEmpty) {
      Get.snackbar('Error', 'Name is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_namecontroller.text.trim().length < 2) {
      Get.snackbar('Error', 'Name must be at least 2 characters long',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_explanationcontroller.text.trim().isEmpty) {
      Get.snackbar('Error', 'Situation explanation is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_explanationcontroller.text.trim().length < 10) {
      Get.snackbar('Error', 'Explanation must be at least 10 characters long',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_addresscontroller.text.trim().isEmpty) {
      Get.snackbar('Error', 'Address is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_stateCityControllerRRC.selectedState.value.isEmpty) {
      Get.snackbar('Error', 'Please select a state',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_stateCityControllerRRC.selectedCity.value.isEmpty) {
      Get.snackbar('Error', 'Please select a city',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (_phone_numbercontroller.text.trim().isEmpty) {
      Get.snackbar('Error', 'Phone number is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    // Phone number validation (assuming Indian numbers - 10 digits)
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegex.hasMatch(_phone_numbercontroller.text.trim())) {
      Get.snackbar('Error',
          'Please enter a valid 10-digit phone number starting with 6-9',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        Get.delete<StateCityController>();
        Get.delete<RRCImageController>();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Request Rescue'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _namecontroller,
                  hintText: "Fullname",
                ),
                SizedBox(height: 20),
                Text(
                  "Explain the Situation :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _explanationcontroller,
                  hintText: "Explain the Situation",
                  MaxLines: 5,
                ),
                SizedBox(height: 20),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _imageController.rrcimages.isEmpty
                            ? "Media"
                            : "Media (${_imageController.rrcimages.length})",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xFFDDE8F0),
                        child: IconButton(
                          onPressed: _imageController.pickImage,
                          icon: Icon(Icons.add),
                        ),
                      )
                    ],
                  );
                }),
                SizedBox(height: 10),
                Obx(
                  () {
                    return _imageController.rrcimages.isEmpty
                        ? Center(child: Text("No images selected"))
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: _imageController.rrcimages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _imageController.rrcimages[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 25,
                                    child: GestureDetector(
                                      onTap: () =>
                                          _imageController.removeImage(index),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Additional Information :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _additional_informationcontroller,
                  hintText: "Additional Information",
                  MaxLines: 5,
                ),
                SizedBox(height: 20),
                Text(
                  "Address :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _addresscontroller,
                  hintText: "Address",
                  MaxLines: 3,
                ),
                SizedBox(height: 20),
                StateCityDropdown(),
                SizedBox(height: 20),
                Text(
                  "Phone Number :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _phone_numbercontroller,
                  hintText: "Phone Number",
                  prefix: Text("+91 "),
                  keyboardType: TextInputType.phone, // Added for better UX
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validateForm()) {
                        var name = _namecontroller.text.trim();
                        var es = _explanationcontroller.text.trim();
                        var ai = _additional_informationcontroller.text.trim();
                        var address = _addresscontroller.text.trim();
                        var state = _stateCityControllerRRC.selectedState.value;
                        var city = _stateCityControllerRRC.selectedCity.value;
                        var phone = _phone_numbercontroller.text.trim();

                        uploadRequestRescue.upload(
                            name, es, ai, address, state, city, phone);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xFF98B857))),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
