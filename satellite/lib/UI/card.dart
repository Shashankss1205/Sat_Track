import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Tile extends StatelessWidget {
  final String name;
  final String status;
  final String image;

  const Tile({
    required this.name,
    required this.status,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display image if available
            image.isNotEmpty
                ? Image.network(image, width: 100, height: 100)
                : SizedBox(height: 100),
            const SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(status),
          ],
        ),
      ),
    );
  }
}
