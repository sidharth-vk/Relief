import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/Apply_for_Assistance/DamageAssistanceController.dart';

class FileItem extends StatelessWidget {
  final FileInfo file;
  final int index;

  FileItem({required this.file, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Badge for PDF files
          if (file.name.endsWith('.pdf'))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade100, // Blue background for PDF
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf,
                      color: Colors.blue, size: 18), // PDF Icon
                  SizedBox(width: 6),
                  Text(
                    'PDF',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),

          if (file.name.endsWith('.jpg'))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100, // Green background for JPG
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.image,
                      color: Colors.green, size: 18), // Image Icon
                  SizedBox(width: 6),
                  Text(
                    'JPG',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),

          if (file.name.endsWith('.png'))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade100, // Orange background for PNG
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.image,
                      color: Colors.orange, size: 18), // Image Icon
                  SizedBox(width: 6),
                  Text(
                    'PNG',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),

          if (file.name.endsWith('.jpeg'))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.purple.shade100, // Purple background for JPEG
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.image,
                      color: Colors.purple, size: 18), // Image Icon
                  SizedBox(width: 6),
                  Text(
                    'JPEG',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ],
              ),
            ),

          if (file.name.endsWith('.docx'))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color:
                    Colors.orange.shade50, // Light orange background for DOCX
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.description,
                      color: Colors.orange, size: 18), // DOCX Icon
                  SizedBox(width: 6),
                  Text(
                    'DOCX',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),

          SizedBox(width: 10),
          // File name in the middle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text('${(file.size / 1024).toStringAsFixed(2)} KB'),
              ],
            ),
          ),
          // Remove Button
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              Get.find<DamageAssistanceController>().removeFile(index);
            },
          ),
        ],
      ),
    );
  }
}
