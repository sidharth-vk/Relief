import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final box = GetStorage();

  var isFirstTimeUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    isFirstTimeUser.value = box.read('isFirstTimeUser') ?? true;
  }

  void completeOnboarding() {
    isFirstTimeUser.value = false;
    box.write('isFirstTimeUser', false);
  }
}
