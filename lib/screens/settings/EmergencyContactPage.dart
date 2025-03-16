import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/settings/emergency_contacts_controller.dart';

class EmergencyContactsPage extends StatelessWidget {
  final EmergencySettingsController controller =
      Get.put(EmergencySettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () {
                return Text(
                  controller.emergencyContacts.length.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                );
              },
            ),
          )
        ],
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.emergencyContacts.length,
            itemBuilder: (context, index) {
              var contact = controller.emergencyContacts[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0), // Add padding for better spacing
                // tileColor: Colors
                //     .blueGrey.shade50, // Background color for the list tile
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
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
                title: Text(
                  contact['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  contact['number']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deleteContact(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Add Contact Dialog
  void _showAddDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final _formKey = GlobalKey<FormState>(); // Key for form validation

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Emergency Contact"),
          content: SizedBox(
            width: double.minPositive, // Makes the dialog smaller
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensures the dialog size is compact
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mobile number is required';
                      }
                      // Simple regex to check phone number format
                      String pattern = r'^[0-9]{10}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // If form is valid, add the contact
                  controller.addContact(
                      nameController.text, numberController.text);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Edit Contact Dialog
  void _showEditDialog(BuildContext context, int index) {
    final TextEditingController nameController = TextEditingController(
        text: controller.emergencyContacts[index]['name']);
    final TextEditingController numberController = TextEditingController(
        text: controller.emergencyContacts[index]['number']);
    final _formKey = GlobalKey<FormState>(); // Key for form validation

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Emergency Contact"),
          content: Container(
            width: double.minPositive, // Makes the dialog smaller
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensures the dialog size is compact
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mobile number is required';
                      }
                      // Simple regex to check phone number format
                      String pattern = r'^[0-9]{10}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // If form is valid, update the contact
                  controller.editContact(
                      index, nameController.text, numberController.text);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
