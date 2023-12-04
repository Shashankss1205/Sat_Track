import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SingleTask extends StatefulWidget {
  final String title;
  final String text;
  final String img;

  const SingleTask({super.key, required this.title, required this.text, required this.img});

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  @override
  Widget build(BuildContext context) {
    final arguments = {
      'title': widget.title,
      'text': widget.text,
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
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  widget.text,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
