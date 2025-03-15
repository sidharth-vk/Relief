import 'package:get/get.dart';
import 'package:relief/data/StateandCity.dart';

class StateCityController extends GetxController {
  RxList<String> states = statesList.obs;
  RxMap<String, List<String>> cities = citiesMap.obs;

  RxString selectedState = ''.obs;
  RxString selectedCity = ''.obs;

  void setState(String state) {
    selectedState.value = state;
    selectedCity.value = '';
  }

  // Set selected city
  void setCity(String city) {
    selectedCity.value = city;
  }

  @override
  void onClose() {
    selectedState.value = '';
    selectedCity.value = '';
    super.onClose();
  }
}
