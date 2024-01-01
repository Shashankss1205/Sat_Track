import 'package:flutter/material.dart';
import '../Models/tle_model.dart'; // Replace with the actual path


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Map<String, double>> fetchData() async {
    // Replace with your actual TLE data or fetch it from an API
    final TLEModel tleData = TLEModel(
      line0: 'Your line0',
      line1: 'Your line1',
      line2: 'Your line2',
      satelliteId: 'Your Satellite ID',
      noradId: 12345,
      updated: 'Your updated date',
    );

    return tleData.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TLE Data Example'),
      ),
      body: FutureBuilder<Map<String, double>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            final data = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Latitude: ${data['lat']}'),
                Text('Longitude: ${data['lng']}'),
                Text('Altitude: ${data['alt']}'),
                Text('Apogee: ${data['apogee']}'),
                Text('Perigee: ${data['perigee']}'),
                Text('Period: ${data['period']}'),
                Text('Inclination: ${data['inclination']}'),
                // Add more widgets for az and el if needed
              ],
            );
          }
        },
      ),
    );
  }
}
