import 'package:flutter/material.dart';
import 'package:relief/screens/settings/EmergencyContactPage.dart';
import 'package:relief/screens/settings/EmergencySOSMessagePage.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // General Settings Section
              const Text(
                "General Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text("Theme"),
                subtitle: const Text("Light / Dark Mode"),
                // trailing: Switch(
                //   value: _isDarkMode,
                //   onChanged: (value) {
                //     _toggleTheme(value);
                //   },
                // ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Language"),
                subtitle: const Text("Select app language"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to language settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text("Notifications"),
                subtitle: const Text("Enable/Disable notifications"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to notification settings
                },
              ),
              const SizedBox(height: 20),

              // Profile Settings Section
              const Text(
                "Profile Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Edit Profile"),
                trailing: const Icon(Icons.arrow_forward_ios),
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => DNProfilePage()));
                // },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Change Password"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to change password
                },
              ),
              ListTile(
                leading: const Icon(Icons.devices),
                title: const Text("Linked Devices"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to linked devices
                },
              ),
              const SizedBox(height: 20),

              // Alert Preferences Section
              const Text(
                "Alert Preferences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.warning),
                title: const Text("Alert Types"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to alert types
                },
              ),
              ListTile(
                leading: const Icon(Icons.priority_high),
                title: const Text("Severity Levels"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to severity levels
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text("Alert Frequency"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to alert frequency
                },
              ),
              const SizedBox(height: 20),

              // Emergency Settings Section
              const Text(
                "Emergency Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.contact_phone),
                title: const Text("Emergency Contacts"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyContactsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text("SOS Message"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Emergencysosmessagepage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Auto-Send Location"),
                trailing: const Icon(Icons.arrow_forward_ios),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const DNAutoSendLocationPage(),
                //     ),
                //   );
                // },
              ),
              const SizedBox(height: 20),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(214, 244, 67, 54),
                  ),
                  onPressed: () {
                    // _logout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
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
