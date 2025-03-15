import 'package:flutter/material.dart';
import 'package:relief/screens/widgets/ActiveAlertsBox.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(185, 244, 243, 243), // Background color
                borderRadius:
                    BorderRadius.circular(25.0), // Circular border radius
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search location, disaster names, dates.....',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  border: InputBorder.none, // Remove the border
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "ACTIVE ALERTS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            AlertContainer(
              title: "Heavy Rainfall Warning",
              subTitle: "Flash Flood Risk",
              location: "Calicut, Kerala",
              borderColor: Colors.red, // Change the border color
              badgeColor: Colors.red, // Change the badge color
            ),
            SizedBox(
              height: 10,
            ),
            AlertContainer(
              title: "Heavy Rainfall Warning",
              subTitle: "Flash Flood Risk",
              location: "Calicut, Kerala",
              borderColor: Colors.red, // Change the border color
              badgeColor: Colors.red, // Change the badge color
            ),
            SizedBox(
              height: 10,
            ),
            AlertContainer(
              title: "Heavy Rainfall Warning",
              subTitle: "Flash Flood Risk",
              location: "Calicut, Kerala",
              borderColor: Colors.red, // Change the border color
              badgeColor: Colors.red, // Change the badge color
            ),
            SizedBox(
              height: 10,
            ),
            AlertContainer(
              title: "Heavy Rainfall Warning",
              subTitle: "Flash Flood Risk",
              location: "Calicut, Kerala",
              borderColor: Colors.red, // Change the border color
              badgeColor: Colors.red, // Change the badge color
            ),
          ],
        ),
      ),
    );
  }
}
