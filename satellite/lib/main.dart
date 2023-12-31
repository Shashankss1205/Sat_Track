import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:satellite/UI/catalog.dart';
import 'package:satellite/func/blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'UI/infoPage.dart';

// List<String> itemList = [
//   'Item 1',
//   'Item 2',
//   'Item 3',
//   // Add more items as needed
// ];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MyHomePage()), // Define your routes using GetPage
        GetPage(name: '/second', page: () => SecondPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Astro Satellite',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.white,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      // home: const MyHomePage(),
    home: FutureBuilder(
      future: FlutterBluetoothSerial.instance.requestEnable(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            child: const Center(
              child: Icon(
                Icons.bluetooth_disabled,
                size: 200.0,
                color: Colors.blue,
                ),
              ),
            ),
          );
        } else {
        return MyHomePage();
        }
      },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  String? selectedDropdownItem;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  Future<void> _initializeData() async {
    await Permission.bluetoothScan.request().isGranted;
    // You can navigate to another screen or perform other actions after the async operation completes.
  }

  @override
  Widget build(BuildContext context) {
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
          // Bluetooth(),
          // Container(
          //   margin: const EdgeInsets.only(top: 50),
          //   padding: const EdgeInsets.all(5),
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       // Replace 'AnotherPage' with the actual name of your other page
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => Blue()));
          //     },
          //     icon: Icon(Icons.bluetooth),
          //     label: Text('second'),
          //   ),
          // ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter a search term',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[300], // Set the desired background color
              ),
              onPressed: () {
                // Perform submit actions here
                print('Selected Option: $selectedDropdownItem');
                print('Search Text: $searchText');
                // Get.snackbar(
                //   "All fields are mandatory",
                //   "Please fill all the fields",
                //   snackPosition: SnackPosition.TOP,
                //   colorText: Theme.of(context).colorScheme.surface,
                //   backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                //   icon: Icon(
                //     Icons.warning,
                //     size: 30,
                //     color: Theme.of(context).colorScheme.surface,
                //   ),
                // );
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.black),
              ),
            ),
            // const AnimatedStaggeredList(),
            const SizedBox(height: 10),
            const SizedBox(
              height: 671.2727-152,
              child: MyWidget(),
            )
          ],
        ),
      ),
    );
  }
}
