import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherController extends GetxController {
  // Observable variables to store data
  var temperature = 0.0.obs;
  var humidity = 0.obs;
  var weatherDescription = ''.obs;
  var weatherType = ''.obs;
  var weatherIcon = ''.obs; // Store the weather icon code
  var isLoading = true.obs;

  final String apiKey =
      '2915733c91f170822cebf2b058dc97db'; // Replace with your actual OpenWeatherMap API key

  // Function to fetch weather data using latitude and longitude
  Future<void> fetchWeather(double latitude, double longitude) async {
    // Set loading state to true
    isLoading(true);

    try {
      // OpenWeatherMap API URL (latitude and longitude)
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

      // Fetch the weather data
      var response = await http.get(url);

      // Check if request was successful
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Parse the necessary data from the response
        temperature.value = data['main']['temp'].toDouble();
        humidity.value = data['main']['humidity'];
        weatherDescription.value = data['weather'][0]['description'];
        weatherType.value = data['weather'][0]['main'];
        weatherIcon.value =
            data['weather'][0]['icon']; // Get the weather icon code
      } else {
        // Handle error if status code is not 200
        print('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      // Set loading state to false
      isLoading(false);
    }
  }
}
