import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:relief/controllers/Immediate_Relief/RequestRescueControllers.dart';
import 'package:relief/controllers/StateCityController.dart';
import 'package:relief/screens/MainPage.dart';

class Requestsuccesspage extends StatelessWidget {
  const Requestsuccesspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Successfully Added",
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(MainPage());
                },
                child: Text("Go to Home"))
          ],
        ),
      ),
    );
  }
}
