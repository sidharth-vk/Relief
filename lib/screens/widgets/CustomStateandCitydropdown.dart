import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/StateCityController.dart';

class StateCityDropdown extends StatelessWidget {
  final StateCityController controller = Get.put(StateCityController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Color.fromARGB(185, 244, 243, 243),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(width: 0.5),
          ),
          child: Obx(() {
            return DropdownButton<String>(
              hint: Text('Select State'),
              value: controller.selectedState.value.isEmpty
                  ? null
                  : controller.selectedState.value,
              onChanged: (String? newState) {
                if (newState != null) {
                  controller.setState(newState);
                }
              },
              items: controller.states
                  .map((state) => DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      ))
                  .toList(),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              underline: SizedBox(), // Removes underline from the dropdown
            );
          }),
        ),
        SizedBox(height: 20),

        // City Dropdown (based on selected state)
        Obx(() {
          if (controller.selectedState.value.isEmpty) {
            return SizedBox(); // Hide the city dropdown if no state is selected
          }

          List<String> cityList =
              controller.cities[controller.selectedState.value] ?? [];

          return Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Color.fromARGB(185, 244, 243, 243),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(width: 0.5)),
            child: DropdownButton<String>(
              hint: Text('Select City'),
              value: controller.selectedCity.value.isEmpty
                  ? null
                  : controller.selectedCity.value,
              onChanged: (String? newCity) {
                if (newCity != null) {
                  controller.setCity(newCity);
                }
              },
              items: cityList
                  .map((city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              underline: SizedBox(), // Removes underline from the dropdown
            ),
          );
        }),
      ],
    );
  }
}
