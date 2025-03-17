import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmergencySettingsController extends GetxController {
  // The storage instance for GetStorage
  final GetStorage box = GetStorage();

  //<--------------> Emergency Contacts <-------------->

  var emergencyContacts = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // Save contacts to GetStorage
  Future<void> saveContacts() async {
    box.write('emergencyContact', emergencyContacts);
    await box.save();
  }

  // Add a new contact
  void addContact(String name, String number) {
    emergencyContacts.add({'name': name, 'number': number});
    saveContacts();
  }

  // Edit an existing contact
  void editContact(int index, String name, String number) {
    emergencyContacts[index] = {'name': name, 'number': number};
    saveContacts();
  }

  // Delete a contact
  void deleteContact(int index) {
    emergencyContacts.removeAt(index);
    saveContacts();
  }

  //<-------------->End Emergency Contacts <-------------->
  //<------------------------------------------------------>
  //<------------------------------------------------------>
  //<--------------> SOS Message <-------------->

  RxString sosMessage = "".obs;
  RxBool shareLocation = false.obs;
  RxBool shareDetails = false.obs;

  // save SOS message
  Future<void> saveSosMessage() async {
    await box.write('sosmessage', sosMessage.value);
    await box.save();
  }

  // Add SOS message value
  Future<void> addSosMessage(String message) async {
    sosMessage.value = message; // Update the reactive value
    await saveSosMessage(); // Save after updating the message
  }

  // save Share Location
  Future<void> saveShareLocation() async {
    await box.write('sharelocation', shareLocation.value);
    await box.save();
  }

  // add share Location
  Future<void> addShareLocation(bool value) async {
    shareLocation.value = value; // Update the reactive value
    await saveShareLocation(); // Save after updating the value
  }

  // save Share Details
  Future<void> saveShareDetails() async {
    await box.write('shareDetails', shareDetails.value);
    await box.save();
  }

  // add share Details
  Future<void> addShareDetails(bool value) async {
    shareDetails.value = value; // Update the reactive value
    await saveShareDetails(); // Save after updating the value
  }

  //<-------------->End SOS Message <-------------->
  //<------------------------------------------------------>
  //<------------------------------------------------------>
  //<--------------> Load Data <-------------->

  // Load Data
  Future<void> loadData() async {
    bool? storedShareLocation = box.read('sharelocation');
    bool? storedShareDetails = box.read('shareDetails');
    String? storedSosMessage = box.read('sosmessage');
    List? storedContacts = box.read('emergencyContact');

    // Update the reactive values if data exists
    if (storedShareLocation != null) {
      shareLocation.value = storedShareLocation;
    }

    if (storedShareDetails != null) {
      shareDetails.value = storedShareDetails;
    }

    if (storedSosMessage != null) {
      sosMessage.value = storedSosMessage;
    }

    if (storedContacts != null) {
      emergencyContacts.value = List<Map<String, String>>.from(
          storedContacts.map((contact) => Map<String, String>.from(contact)));
    }
  }
}
