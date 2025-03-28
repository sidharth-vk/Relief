import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/AuthController.dart';
import 'package:relief/screens/MainPage.dart';
import 'package:relief/screens/auth/LoginScreen.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';

class Registerscreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Login to Get Started",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(hintText: "Username", controller: _username),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(hintText: "Email", controller: _email),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(hintText: "Password", controller: _password),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: 150,
                    child: Obx(
                      () => authController.isLoading.value
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                authController.register(
                                  _username.text,
                                  _password.text,
                                  _email.text,
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Color(0xFF98B857))),
                              child: Text(
                                "Register Now ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    )),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(child: Text("Already have an account")),
                      TextSpan(text: "  "),
                      WidgetSpan(
                          child: GestureDetector(
                        onTap: () {
                          Get.offAll(Loginscreen());
                        },
                        child: Text(
                          "Login Now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
