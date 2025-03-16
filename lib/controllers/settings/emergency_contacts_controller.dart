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
    loadContacts();
  }

  Future<void> loadContacts() async {
    // Try to get the data from GetStorage
    List? storedContacts = box.read('emergencyContact');
    if (storedContacts != null) {
      emergencyContacts.value = List<Map<String, String>>.from(
          storedContacts.map((contact) => Map<String, String>.from(contact)));
    }
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

  Future<void> saveSosMessage() async {
    // Save the value of sosmessage (not the RxString itself)
    await box.write('sosmessage', sosMessage.value);
    await box.save();
  }

  // Add SOS message value
  Future<void> addSosMessage(String message) async {
    sosMessage.value = message; // Update the reactive value
    await saveSosMessage(); // Save after updating the message
  }

  // Load SOS message from GetStorage
  Future<void> loadSosMessage() async {
    String? storedMessage = box.read('sosmessage');
    if (storedMessage != null) {
      sosMessage.value = storedMessage; // Update the reactive value
    }
  }
}
