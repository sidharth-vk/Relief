import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart'
    as location; // Alias for location package
import 'package:geocoding/geocoding.dart'
    as geocoding; // Alias for geocoding package

class LocationController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString address = ''.obs;
  RxString city = ''.obs;
  RxString state = ''.obs;

  final GetStorage _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadLocation();
  }

  // Method to load location from GetStorage
  void loadLocation() {
    double? storedLatitude = _box.read<double>('latitude');
    double? storedLongitude = _box.read<double>('longitude');

    if (storedLatitude != null && storedLongitude != null) {
      latitude.value = storedLatitude;
      longitude.value = storedLongitude;
      getAddressFromCoordinates(latitude.value, longitude.value);
    } else {
      getCurrentLocation();
    }
  }

  // Method to fetch the current location
  Future<void> getCurrentLocation() async {
    location.Location locationService = location.Location();

    bool _serviceEnabled;
    location.PermissionStatus _permissionGranted;

    _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == location.PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != location.PermissionStatus.granted) {
        return;
      }
    }

    location.LocationData _locationData = await locationService.getLocation();

    latitude.value = _locationData.latitude ?? 0.0;
    longitude.value = _locationData.longitude ?? 0.0;

    _box.write('latitude', latitude.value);
    _box.write('longitude', longitude.value);

    getAddressFromCoordinates(latitude.value, longitude.value);
  }

  // Method to get address, city, and state from latitude and longitude
  Future<void> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark =
            placemarks.length > 1 ? placemarks[1] : placemarks[0];

        address.value = placemark.street ?? 'No address available';
        city.value = placemark.locality ?? 'No city available';
        state.value = placemark.administrativeArea ?? 'No state available';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }
}
