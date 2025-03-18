import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/Immediate_Relief/RequestServiceController.dart';
import 'package:relief/controllers/StateCityController.dart';
import 'package:relief/screens/widgets/CustomStateandCitydropdown.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';

// ignore: must_be_immutable
class Requestservicepage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  final RSCImageController _getcontroller = Get.put(RSCImageController());
  final StateCityController _stateCityControllerRRC =
      Get.put(StateCityController());

  Requestservicepage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        Get.delete<StateCityController>();
        Get.delete<RSCImageController>();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Request Service"),
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
                "Select Service :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(185, 244, 243, 243),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      border: Border.all(width: 0.5)),
                  child: DropdownButton<String>(
                    value: _getcontroller.selectedservices.value.isEmpty
                        ? null
                        : _getcontroller.selectedservices.value,
                    hint: Text('Select an Item'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _getcontroller.updateSelectedservices(newValue);
                      }
                    },
                    items: _getcontroller.servicess
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: SizedBox(),
                  ),
                );
              }),
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
                      _getcontroller.rscimages.isEmpty
                          ? "Media"
                          : "Media (${_getcontroller.rscimages.length})",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFDDE8F0),
                      child: IconButton(
                        onPressed: _getcontroller.pickImage,
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
                  return _getcontroller.rscimages.isEmpty
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
                          itemCount: _getcontroller.rscimages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip
                                  .none, // Allow content to overflow for the cross button
                              children: [
                                // Image container
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _getcontroller.rscimages[index],
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
                                    onTap: () => _getcontroller.removeImage(
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
                  onPressed: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
