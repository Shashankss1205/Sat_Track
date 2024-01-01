import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satellite/UI/tlebox.dart';
import 'package:satellite/api/apiToTle.dart';

import 'package:satellite/func/tleToDeg.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});
  final arguments = Get.arguments as Map<String, dynamic>;
  get dropdownItems => null;
  @override
  Widget build(BuildContext context) {
    final arg1 = arguments['name'] as String;
    final arg2 = arguments['text'] as String;
    final arg3 = arguments['img'] as String;
    // final arg4 = fetchAndSearchData(value: arg2);
    // print(arg4);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Satellite Config',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        )),
        actions: [
          PopupMenuButton<String>(
            onSelected: (newValue) {
              setState(() {
                var selectedDropdownItem = newValue;
              });
            },
            itemBuilder: (BuildContext context) {
              return dropdownItems.map((item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            // height: 1000,
            width: double.infinity,
            // color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        arg1,
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        arg2,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  MyTLEPage(satId: arg2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      arg3, // Replace with your image URL
                      width: 300, // Optional: Set the width
                      height: 300, // Optional: Set the height
                      fit: BoxFit.cover, // Optional: Adjust how the image fits within the widget
                      loadingBuilder: (context, child, loadingProgress) { // Optional: Show a loading indicator
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) { // Optional: Handle loading errors
                        return Text('Error loading image');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
