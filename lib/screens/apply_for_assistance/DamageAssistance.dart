import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/Apply_for_Assistance/DamageAssistanceController.dart';
import 'package:relief/controllers/StateCityController.dart';
import 'package:relief/screens/widgets/CustomStateandCitydropdown.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';
import 'package:relief/screens/widgets/FileItemWidget.dart';

class Damageassistance extends StatelessWidget {
  TextEditingController _controllertext = TextEditingController();
  final DamageAssistanceController _controller =
      Get.put(DamageAssistanceController());
  final StateCityController _stateCitycontroller =
      Get.put(StateCityController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        Get.delete<DamageAssistanceController>();
        Get.delete<StateCityController>();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Damage Assistance"),
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
                controller: _controllertext,
                hintText: "Fullname",
              ),
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
                controller: _controllertext,
                hintText: "Phone Number",
                prefix: Text("+91 "),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _controllertext,
                hintText: "Email Address",
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _controller.daIDimage.isEmpty
                          ? "Valid ID Proof"
                          : "Valid ID Proof (${_controller.daIDimage.length})",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFDDE8F0),
                      child: IconButton(
                        onPressed: _controller.pickIDImage,
                        icon: Icon(Icons.add),
                      ),
                    )
                  ],
                );
              }),
              Text(
                  "Please upload a Valid ID such as Aadhaar card, Pan Card, Passport, Voter ID or Driving License for verification."),
              SizedBox(
                height: 20,
              ),
              Obx(
                () {
                  return _controller.daIDimage.isEmpty
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
                          itemCount: _controller.daIDimage.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip
                                  .none, // Allow content to overflow for the cross button
                              children: [
                                // Image container
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _controller.daIDimage[index],
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
                                    onTap: () => _controller.removeIDImage(
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
                "Type of Damage :",
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
                    value: _controller.selectedtypeofdamage.value.isEmpty
                        ? null
                        : _controller.selectedtypeofdamage.value,
                    hint: Text('Select an Item'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _controller.updateSelectedtypeofdamage(newValue);
                      }
                    },
                    items: _controller.type0fdamage
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
                "Damage Description :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _controllertext,
                hintText: "Damage Discription",
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
                      _controller.files.value.isEmpty
                          ? "Insuarance Documents"
                          : "Insuarance Documents (${_controller.files.value.length})",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFDDE8F0),
                      child: IconButton(
                        onPressed: _controller.pickFiles,
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
                  if (_controller.files.value.isEmpty) {
                    return Text('No files selected');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.files.value.length,
                    itemBuilder: (context, index) {
                      final file = _controller.files.value[index];
                      return FileItem(file: file, index: index);
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _controller.daimage.isEmpty
                          ? "Media"
                          : "Media (${_controller.daimage.length})",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFDDE8F0),
                      child: IconButton(
                        onPressed: _controller.pickImage,
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
                  return _controller.daimage.isEmpty
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
                          itemCount: _controller.daimage.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip
                                  .none, // Allow content to overflow for the cross button
                              children: [
                                // Image container
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _controller.daimage[index],
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
                                    onTap: () => _controller.removemediaImage(
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
                "Additional Information :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _controllertext,
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
                controller: _controllertext,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
