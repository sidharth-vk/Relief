import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:relief/screens/MainPage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Carousel Controller
  CarouselSliderController controller = CarouselSliderController();

  // List of images to display in the background carousel
  List<String> imageUrls = [
    'https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=',
    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg',
  ];

  // List of text items to display in the text carousel
  List<String> textItems = [
    'Real-Time Disaster Alerts',
    'Connect with Relief Efforts',
    'Instant Spot Alerts',
  ];

  List<String> textdesc = [
    'Stay up-to-date with live alerts for natural disasters in your area. Receive instant notifications about imminent threats, so you can act fast and stay safe.',
    'Access vital resources and connect with local disaster relief teams. Quickly find shelters, medical support, and emergency services to assist you in times of crisis.',
    'Send and receive real-time spot alerts from affected areas. Help others by sharing disaster information, and collaborate with the community to ensure everyones safety.'
  ];

  int _currentImageIndex = 0;
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onTextCarouselChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentTextIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image carousel
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            carouselController: controller,
            itemBuilder: (context, index, realIndex) {
              return Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              );
            },
            options: CarouselOptions(
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              height: MediaQuery.of(context).size.height,
              onPageChanged: (index, reason) {
                // Sync the text carousel with the image carousel when the page changes
                controller.jumpToPage(index);
              },
            ),
          ),

          // Bottom section with 1/3 of screen height
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30), // Add border radius here
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text carousel, synced with image carousel
                  Expanded(
                    child: CarouselSlider(
                      carouselController: controller,
                      items: textItems
                          .asMap()
                          .map((index, text) {
                            return MapEntry(
                              index,
                              Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      text,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      textdesc[index],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                          .values
                          .toList(),
                      options: CarouselOptions(
                        height: 250, // Adjusted height for better fit
                        viewportFraction: 1.0,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        onPageChanged: _onTextCarouselChanged,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Dots indicator for the text carousel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      textItems.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: _currentTextIndex == index ? 12 : 8,
                        height: _currentTextIndex == index ? 12 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentTextIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  // Get Started button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action on Get Started button click
                          Get.to(MainPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF98B857),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
