import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/weatherController.dart';

class WeatherWidget extends StatelessWidget {
  final String weatherType;
  final double temperature;
  final String location;

  WeatherWidget({
    required this.weatherType,
    required this.temperature,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    WeatherController weathercontroller = Get.put(WeatherController());
    String iconUrl =
        'https://openweathermap.org/img/wn/${weathercontroller.weatherIcon.value}.png';
    // Set the background color based on weather condition
    Color fontcolor;
    String backgroundimage;
    AnimatedIconData weatherIcon;
    String conditionText;

    switch (weatherType.toLowerCase()) {
      case 'clear':
        backgroundimage = "assets/weather/clear_sky.jpg";
        fontcolor = Colors.white;
        weatherIcon = AnimatedIcons.ellipsis_search; // Animated sunny icon
        conditionText = "Clear Sky";
        break;
      case 'clouds':
        fontcolor = Colors.white;
        backgroundimage = "assets/weather/cloudy.jpg";
        weatherIcon = AnimatedIcons.arrow_menu; // Animated cloud icon
        conditionText = "Cloudy";
        break;
      case 'rain':
        fontcolor = Colors.white;
        backgroundimage = "assets/weather/rainy.jpg";
        weatherIcon = AnimatedIcons.close_menu; // Animated rain icon
        conditionText = "Rainy";
        break;
      case 'thunderstorm':
        fontcolor = Colors.white;
        backgroundimage = "assets/weather/thunderstorm.jpg";
        weatherIcon = AnimatedIcons.list_view; // Animated thunderstorm icon
        conditionText = "Thunderstorm";
        break;

      case 'snow':
        fontcolor = Colors.white;
        backgroundimage = "assets/weather/snow.jpg";
        weatherIcon = AnimatedIcons.play_pause; // Animated snow icon
        conditionText = "Snow";
        break;
      case 'atmosphere':
        fontcolor = Colors.white;
        backgroundimage = "assets/weather/foggy.jpg";
        weatherIcon = AnimatedIcons.menu_close; // Animated fog icon
        conditionText = "Foggy";
        break;
      default:
        backgroundimage = "assets/weather/clear_sky.jpg";
        fontcolor = Colors.white;
        weatherIcon =
            AnimatedIcons.ellipsis_search; // Default animated error icon
        conditionText = "Unknown";
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundimage), fit: BoxFit.cover),
        // color: fontcolor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4), // Dark overlay with opacity
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Temperature & Location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temperature.toStringAsFixed(1)}°C',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: fontcolor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: fontcolor,
                    ),
                  ),
                ],
              ),
              // Right side - Weather Icon & Condition Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 27,
                    width: 30,
                    child: Image.network(
                      iconUrl,
                      fit: BoxFit.none,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    conditionText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: fontcolor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
