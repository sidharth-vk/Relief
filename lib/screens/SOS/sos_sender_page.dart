import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/LocationController.dart';
import 'package:relief/controllers/settings/emergency_contacts_controller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:action_slider/action_slider.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

final EmergencySettingsController controller =
    Get.put(EmergencySettingsController());
final LocationController locationcontroller = Get.put(LocationController());

class _TimerPageState extends State<TimerPage> {
  // Emergency contacts list
  var emergencyContacts = controller.emergencyContacts;

  // Send the SMS with custom message and location
  Future<void> sendSMSmessage() async {
    // Assume we have a way to get the current location
    String locationMessage =
        "My location: Lat: ${locationcontroller.latitude.value}, Long: ${locationcontroller.longitude.value}";
    String customMessage =
        "Emergency! Please help. \n\n $locationMessage \n\n My Current Address : ${locationcontroller.address.value}, ${locationcontroller.city.value}, ${locationcontroller.city.value}, ${locationcontroller.state.value} \n\n Google Map Link: https://www.google.com/maps?q=${locationcontroller.latitude.value},${locationcontroller.longitude.value} \n\n Message: ${controller.sosMessage.value}";

    // Prepare the list of recipients (emergency contacts)
    List<String> recipients =
        emergencyContacts.map((contact) => contact['number']!).toList();

    if (emergencyContacts.isEmpty) {
      Get.snackbar(
          "No Emergency Number", "Please create an emergency number list");
      return;
    }

    try {
      // Use flutter_sms to send SMS (opens the default SMS app)
      await sendSMS(
        message: customMessage,
        recipients: recipients,
        sendDirect: true, // Send directly without opening SMS app
      );
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar('Alert Sent', 'SOS message sent to emergency contacts',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20));
    } catch (e) {
      print('Failed to send SMS: $e');

      Get.snackbar('Error', 'Failed to send SMS: $e');
    }
  }

  // Function called when the action slider reaches its end
  void onSlideEnd() {
    sendSMSmessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How Emergency Service Work",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.location_on),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Location Sharing",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.phone),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Alert Emergency Contacts",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Slide to Activate Emergency Services',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionSlider.custom(
                    toggleMargin: EdgeInsets.zero,
                    width: 300.0,

                    toggleWidth: 70.0,
                    height: 70.0,
                    sliderBehavior: SliderBehavior.stretch,

                    backgroundColor:
                        Colors.white, // Set background color to red
                    foregroundChild: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors
                              .red, // Toggle in white to contrast with red background
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: Center(
                            child: Text(
                          "SOS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )), // SOS Icon (warning)
                      ),
                    ),
                    foregroundBuilder: (context, state, child) => child!,
                    backgroundChild: Center(
                      child: Text(
                        'Emergency Services',
                      ),
                    ),

                    backgroundBuilder: (context, state, child) => ClipRect(
                      child: OverflowBox(
                        maxWidth: state.standardSize.width,
                        maxHeight: state.toggleSize.height,
                        minWidth: state.standardSize.width,
                        minHeight: state.toggleSize.height,
                        child: child!,
                      ),
                    ),
                    backgroundBorderRadius: BorderRadius.circular(40.0),
                    action: (controller) async {
                      controller.loading(); // Starts loading animation
                      await Future.delayed(const Duration(seconds: 1));
                      onSlideEnd(); // Success animation when SOS action is complete
                      await Future.delayed(const Duration(seconds: 1));
                      controller.reset(); // Resets the slider
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
