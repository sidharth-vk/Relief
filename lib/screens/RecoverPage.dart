import 'package:flutter/material.dart';
import 'package:relief/screens/apply_for_assistance/DamageAssistance.dart';
import 'package:relief/screens/immediate_relief/RequestMedicalAidPage.dart';
import 'package:relief/screens/immediate_relief/RequestRescuePage.dart';
import 'package:relief/screens/immediate_relief/RequestServicePage.dart';
import 'package:relief/screens/widgets/DisasterReliefBox.dart';

class RecoverPage extends StatelessWidget {
  const RecoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "IMMEDIATE RELIEF",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 100,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
                children: [
                  IconTextContainer(
                      icon: Icons.help,
                      text: 'Request Rescue',
                      ontap: () {
                        print("object");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Requestrescuepage()),
                        );
                      }).build(),
                  IconTextContainer(
                      icon: Icons.medical_services,
                      text: 'Request Medical Aid',
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Requestmedicalaidpage()),
                        );
                      }).build(),
                  IconTextContainer(
                          icon: Icons.local_shipping,
                          text: 'Request Supplies',
                          ontap: () {})
                      .build(),
                  IconTextContainer(
                      icon: Icons.support,
                      text: 'Request Service',
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Requestservicepage()),
                        );
                      }).build(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DisasterReliefBox(title: "Check Request Status", ontap: () {}),
            SizedBox(
              height: 15,
            ),
            Text(
              "APPLY FOR ASSISTANCE",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 100,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
                children: [
                  IconTextContainer(
                      icon: Icons.home_repair_service,
                      text: 'Damage Assistance',
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Damageassistance()),
                        );
                      }).build(),
                  IconTextContainer(
                          icon: Icons.account_balance_wallet,
                          text: 'Financial Assistance',
                          ontap: () {})
                      .build(),
                  IconTextContainer(
                          icon: Icons.gavel,
                          text: 'Legal Assistance',
                          ontap: () {})
                      .build(),
                  IconTextContainer(
                          icon: Icons.house,
                          text: 'Housing Assistance',
                          ontap: () {})
                      .build(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DisasterReliefBox(title: "Check Application Status", ontap: () {}),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: .1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          child: Text(
                            "Volunteer ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Opportunities",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextSpan(
                        text:
                            "\nShare real-time updates to help others stay safe.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DISASTER RELATED FAQS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Read More",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ExpansionTile(
                  title: Text('What is Flutter?'),
                  shape: Border.all(color: Colors.transparent),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('How does Flutter work?'),
                  shape: Border.all(color: Colors.transparent),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Flutter uses a high-performance rendering engine called Skia to draw widgets, and it provides its own set of widgets. It compiles to native code, which gives it great performance.'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('What are the benefits of using Flutter?'),
                  shape: Border.all(color: Colors.transparent),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Flutter allows for fast development, beautiful UIs, and high performance. It provides a rich set of pre-built widgets, and you can use a single codebase for iOS, Android, web, and desktop.'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('What is Dart?'),
                  shape: Border.all(color: Colors.transparent),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Dart is the programming language used to write Flutter apps. It is optimized for building UIs, and it compiles to native code for performance.'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IconTextContainer {
  final IconData icon;
  final String text;
  final VoidCallback ontap;

  IconTextContainer(
      {required this.icon, required this.text, required this.ontap});

  Widget build() {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Icon on the left
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 20,
                color: Color(0xFF578EB6),
              ),
            ),
            // Text on the right
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
