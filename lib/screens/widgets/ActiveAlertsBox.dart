import 'package:flutter/material.dart';

class AlertContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String location;
  final Color borderColor; // Border color (changing)
  final Color badgeColor; // Badge color (changing)

  // Constructor to pass data
  const AlertContainer({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.location,
    required this.borderColor,
    required this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Makes it fill the width of its parent
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor), // Border color
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Column for the alert content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 2),
              Text(
                location,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          // Positioned "Alert" badge on the top-right corner
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor, // Badge background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'ALERT',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
