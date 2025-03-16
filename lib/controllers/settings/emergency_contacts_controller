import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmergencyContactsController extends GetxController {
  // The storage instance for GetStorage
  final GetStorage box = GetStorage();
  var contacts = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  // Load contacts from GetStorage
  Future<void> loadContacts() async {
    // Try to get the data from GetStorage
    List? storedContacts = box.read('contacts');
    if (storedContacts != null) {
      contacts.value = List<Map<String, String>>.from(storedContacts);
    }
  }

  // Save contacts to GetStorage
  Future<void> saveContacts() async {
    box.write('contacts', contacts);
  }

  // Add a new contact
  void addContact(String name, String number) {
    contacts.add({'name': name, 'number': number});
    saveContacts();
  }

  // Edit an existing contact
  void editContact(int index, String name, String number) {
    contacts[index] = {'name': name, 'number': number};
    saveContacts();
  }

  // Delete a contact
  void deleteContact(int index) {
    contacts.removeAt(index);
    saveContacts();
  }
}
