import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SingleTask extends StatefulWidget {
  final String name;
  final String sat_id;
  final String img;

  const SingleTask({super.key,
    required this.name,
    required this.sat_id,
    required this.img,
  });

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  @override
  Widget build(BuildContext context) {
    final arguments = {
      'name': widget.name,
      'text': widget.sat_id,
      'img': widget.img,
    };
    return GestureDetector(
      onTap: () {
        Get.toNamed('/second', arguments: arguments);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(
          left: 20,
        ),
        height: 100,
        width: double.infinity,
        // color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10,top: 10),
                  width: 230,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 250), // Example max width
                    child:
                    Text(
                      widget.name,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                      overflow: TextOverflow.ellipsis, // Optional for text truncation
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250), // Example max width
                  child:
                  Text(
                    widget.sat_id,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    overflow: TextOverflow.ellipsis, // Optional for text truncation
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.img, // Replace with your image URL
                width: 70, // Optional: Set the width
                height: 70, // Optional: Set the height
                fit: BoxFit.cover, // Optional: Adjust how the image fits within the widget
                loadingBuilder: (context, child, loadingProgress) { // Optional: Show a loading indicator
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) { // Optional: Handle loading errors
                  return const Text('Error loading image');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
