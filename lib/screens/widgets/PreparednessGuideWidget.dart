import 'package:flutter/material.dart';

class PreparednessGuide extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image':
          'https://c.files.bbci.co.uk/A1BA/production/_121120414_thumbnail.jpg',
      'title': 'Surviving an Earthquake: What You Need to Know',
    },
    {
      'image':
          'https://images.yourstory.com/cs/wordpress/2018/08/Untitled-design-17-1.png?mode=crop&crop=faces&ar=2%3A1&format=auto&w=1920&q=75',
      'title': 'How to Prepare for a Power Outage',
    },
    {
      'image':
          'https://sc0.blr1.digitaloceanspaces.com/large/892413-ainqcrafrm-1534673003.jpg',
      'title': 'Building a Disaster Supply Kit',
    },
    {
      'image':
          'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
      'title': 'Preparing Your Home for Natural Disasters',
    },
    {
      'image':
          'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
      'title': 'Creating an Emergency Plan for Your Family',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 250,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 1,
                margin: EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        item['image']!,
                        width: 250,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['title']!,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
