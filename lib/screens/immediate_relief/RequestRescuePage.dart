import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/RequestRescueControllers.dart';
import 'package:relief/controllers/StateCityController.dart';
import 'package:relief/screens/widgets/CustomStateandCitydropdown.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';

class Requestrescuepage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  final RRCImageController _imageController = Get.put(RRCImageController());
  final StateCityController _stateCityControllerRRC =
      Get.put(StateCityController());

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
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _controller,
                  hintText: "Fullname",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Explain the Situation :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _controller,
                  hintText: "Explain the Situation",
                  MaxLines: 5,
                ),
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () {
                    return _imageController.rrcimages.isEmpty
                        ? Center(child: Text("No images selected"))
                        : GridView.builder(
                            shrinkWrap:
                                true, // Use shrinkWrap to prevent overflow
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: _imageController.rrcimages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                clipBehavior: Clip
                                    .none, // Allow content to overflow for the cross button
                                children: [
                                  // Image container
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _imageController.rrcimages[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Cross button to remove the image
                                  Positioned(
                                    top: 5,
                                    right: 25,
                                    child: GestureDetector(
                                      onTap: () => _imageController.removeImage(
                                          index), // Remove image when clicked
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Additinal Information :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _controller,
                  hintText: "Additional Information",
                  MaxLines: 5,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Address :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _controller,
                  hintText: "Address",
                  MaxLines: 3,
                ),
                SizedBox(
                  height: 20,
                ),
                StateCityDropdown(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _controller,
                  hintText: "Phone Number",
                  prefix: Text("+91 "),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print(
                          'State: ${_stateCityControllerRRC.selectedState.value}');
                      print(
                          'City: ${_stateCityControllerRRC.selectedCity.value}');

                      print(_imageController.rrcimages);
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
