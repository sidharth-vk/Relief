import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/AuthController.dart';
import 'package:relief/controllers/Weather_and_Location/LocationController.dart';
import 'package:relief/controllers/Weather_and_Location/weatherController.dart';
import 'package:relief/screens/widgets/ActiveAlertsBox.dart';
import 'package:relief/screens/widgets/DisasterReliefBox.dart';
import 'package:relief/screens/widgets/PreparednessGuideWidget.dart';
import 'package:relief/screens/widgets/Weather.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final WeatherController weathercontroller = Get.put(WeatherController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(authController.userName.value[0]
                        .toString()
                        .toUpperCase()),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ${authController.userName.value}!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () {
                          return locationController.latitude.value == 0.0
                              ? Shimmer.fromColors(
                                  child: Text("Loading"),
                                  baseColor: Colors.black,
                                  highlightColor: Colors.white10)
                              : RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                          Icons.location_on,
                                          size: 15,
                                          color: Colors.green,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${locationController.city.value}, ${locationController.state.value}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
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
                title: "EarthQuick Warning",
                subTitle: "Earthquick Risk",
                location: "Calicut, Kerala",
                borderColor: Colors.orange, // Change the border color
                badgeColor: Colors.orange, // Change the badge color
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // WeatherWidget with equal width
                  Obx(() {
                    return Expanded(
                      child: WeatherWidget(
                        weatherType: weathercontroller.weatherType.value,
                        temperature: weathercontroller.temperature.value,
                        location: locationController.city.value,
                      ),
                    );
                  }),
                  SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: .1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Do you have an\n",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 19)),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    print("tapped");
                                  },
                                  child: Text(
                                    "Emergency Plan?",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "Safety First, Plan Ahead",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
                              "Spot something critical? ",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            "Report it Here",
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
                height: 20,
              ),
              Text(
                "DISASTER RELIEF",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              DisasterReliefBox(
                title: "Find an Emergency Center",
                ontap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              DisasterReliefBox(
                title: "Immediate Relief",
                ontap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              DisasterReliefBox(
                ontap: () {},
                title: "Apply for Assistance",
              ),
              SizedBox(
                height: 10,
              ),
              DisasterReliefBox(
                ontap: () {},
                title: "Disaster Related FAQs",
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PREPAREDNESS GUIDE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Read More",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              PreparednessGuide(),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "RELATED NEWS",
              //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              //     ),
              //     TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         "Read More",
              //         style:
              //             TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
