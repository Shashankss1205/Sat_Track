import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});
  final arguments = Get.arguments as Map<String, dynamic>;
  get dropdownItems => null;

  @override
  Widget build(BuildContext context) {
    final arg1 = arguments['title'] as String;
    final arg2 = arguments['text'] as String;
    final arg3 = arguments['img'] as String;

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
          padding: const EdgeInsets.only(
            left: 20,
          ),
          height: 600,
          width: double.infinity,
          // color: Colors.lightBlue,
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
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(arg3),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
