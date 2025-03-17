import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relief/screens/AlertPage.dart';
import 'package:relief/screens/HomePage.dart';
import 'package:relief/screens/ProfilePage.dart';
import 'package:relief/screens/RecoverPage.dart';
import 'package:relief/screens/SOS/sos_sender_page.dart';
import 'package:relief/screens/SettingPage.dart';

class BottomNavBarController extends GetxController {
  var currentIndex = 0.obs; // Observable variable for current index
}

class MainPage extends StatelessWidget {
  final BottomNavBarController _controller = Get.put(BottomNavBarController());

  // List of icons for the bottom navigation bar
  final List<IconData> iconList = [
    Icons.home,
    Icons.checklist,
    Icons.crisis_alert,
    Icons.local_hospital,
  ];
  final List<String> iconLabelList = ["Home", "Prepare", "Alerts", "Recover"];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0)), // Rounded corners
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 250, // Adjust height for the bottom sheet
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.blue),
                title: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  print('Profile selected');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profilepage()),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.blue),
                title: Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settingpage()),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Handle logout tap
                  print('Logout selected');
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DisasterNet",
          style: GoogleFonts.handlee(
              textStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {
              _showBottomSheet(context); // Show BottomSheet when clicked
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(
        () {
          switch (_controller.currentIndex.value) {
            case 0:
              return HomePage();
            case 1:
              return Center(child: Text('Search Screen'));
            case 2:
              return AlertPage();
            case 3:
              return RecoverPage();
            default:
              return Center(child: Text('Home Screen'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => TimerPage()));
        },
        child: Text(
          "SOS",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () {
          return AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconList[index],
                    size: 25,
                    color: isActive ? Color(0xFF578EB6) : Color(0xFFB4CDE0),
                  ),
                  Text(
                    iconLabelList[index],
                    style: TextStyle(
                      color: isActive ? Color(0xFF578EB6) : Color(0xFFB4CDE0),
                      fontSize: 13,
                    ),
                  ),
                ],
              );
            },
            activeIndex: _controller.currentIndex.value,
            gapLocation: GapLocation.center,
            onTap: (index) {
              _controller.currentIndex.value = index;
            },
            backgroundColor: Color(0xFFF2FAFF),
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
          );
        },
      ),
    );
  }
}
