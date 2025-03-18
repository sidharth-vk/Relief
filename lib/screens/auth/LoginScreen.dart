import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:relief/controllers/AuthController.dart';
import 'package:relief/screens/MainPage.dart';
import 'package:relief/screens/auth/RegisterScreen.dart';
import 'package:relief/screens/widgets/CustomTextField.dart';

class Loginscreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  TextEditingController _username = TextEditingController();
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
                CustomTextField(hintText: "Password", controller: _password),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {}, child: Text("Forget Password?"))
                  ],
                ),
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
                                authController.login(
                                  _username.text,
                                  _password.text,
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Color(0xFF98B857))),
                              child: Text(
                                "Log in",
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
                      WidgetSpan(child: Text("Create an Account")),
                      TextSpan(text: "  "),
                      WidgetSpan(
                          child: GestureDetector(
                        onTap: () {
                          Get.to(Registerscreen());
                        },
                        child: Text(
                          "Register Now",
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
