import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/settings/emergency_contacts_controller.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';

class Emergencysosmessagepage extends StatelessWidget {
  final EmergencySettingsController controller =
      Get.put(EmergencySettingsController());
  final TextEditingController _msgcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _msgcontroller.text = controller.sosMessage.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS Message Settings"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch to enable/disable location sharing
            Obx(
              () {
                return SwitchListTile(
                  title: const Text("Share Live Location"),
                  value: controller.shareLocation.value,
                  onChanged: (value) {
                    controller.addShareLocation(value);
                  },
                  activeColor: Colors.green,
                  subtitle: const Text("Enable location sharing in SOS."),
                );
              },
            ),
            // Switch to enable/disable sharing details (contact, message)
            Obx(
              () {
                return SwitchListTile(
                  title: const Text("Share Medical Details"),
                  value: controller.shareDetails.value,
                  onChanged: (value) {
                    controller.addShareDetails(value);
                  },
                  activeColor: Colors.green,
                  subtitle:
                      const Text("Enable sharing Contact and Medical details."),
                );
              },
            ),
            // SOS Message Text Field
            Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CustomTextField(
                  hintText: "Enter SOS Message",
                  controller: _msgcontroller,
                  MaxLines: 3,
                )),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFF98B857))),
                  onPressed: () {
                    controller.addSosMessage(_msgcontroller.text);
                  },
                  child: const Text(
                    "Save SOS Settings",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display all the contacts
            Text(
              "Emergency Contacts:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.emergencyContacts.length,
                itemBuilder: (context, index) {
                  var contact = controller.emergencyContacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        contact['name']![0]
                            .toUpperCase(), // First letter of the contact's name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(contact['name']!),
                    subtitle: Text(contact['number']!),
                    trailing: Icon(Icons.phone),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
