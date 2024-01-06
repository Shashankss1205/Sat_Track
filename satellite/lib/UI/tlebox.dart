import 'package:flutter/material.dart';
import '../api/apiToTle.dart';
import 'package:sgp4_sdp4/sgp4_sdp4.dart';
import '../func/blue.dart';
import 'infobox.dart'; // Assuming fetchAndSearchData is in api.dart

class MyTLEPage extends StatefulWidget {
  final String satId; // Pass the satellite ID for fetching data

  MyTLEPage({Key? key, required this.satId}) : super(key: key);

  @override
  State<MyTLEPage> createState() => _MyTLEPageState();
}

class _MyTLEPageState extends State<MyTLEPage> {
  List<Info> tleData = []; // Change to a list of Info objects
  late Map<String, double> valuesMap;
  late Map<String, double> finalMap;
  @override
  void initState() {
    super.initState();
    fetchAndSearchData(value: widget.satId).then((fetchedData) {
      setState(() {
        tleData = fetchedData;
        valuesMap = read();
        finalMap = getServoAngles(valuesMap['lat']!, valuesMap['lng']!, valuesMap['alt']!);
        print(tleData);
        print(finalMap);
        print(read());
      });
    });
  }
  Map<String, double> read({ double displacement = 3.3 / 24.0 }) {
    final datetime = DateTime.now();
    final TLE tle = TLE(tleData[0].tle0, tleData[0].tle1, tleData[0].tle2);
    final Orbit orbit = Orbit(tle);

    final utcTime = Julian.fromFullDate(datetime.year, datetime.month,
        datetime.day, datetime.hour, datetime.minute)
        .getDate()
        + displacement;

    final Eci eciPos =
    orbit.getPosition((utcTime - orbit.epoch().getDate()) * MIN_PER_DAY);

    final CoordGeo coord = eciPos.toGeo();
    if (coord.lon > PI) {
      coord.lon -= TWOPI;
    }

    return {
      'lat': rad2deg(coord.lat),
      'lng': rad2deg(coord.lon),
      'alt': coord.alt,
      'apogee': orbit.apogee(),
      'perigee': orbit.perigee(),
      'period': orbit.period(),
      'inclination': rad2deg(orbit.inclination())
    };
  }

  Map<String, double> getServoAngles(double latitude, double longitude, double altitude){

    final Site myLocation =
    Site.fromLatLngAlt(latitude, longitude, altitude / 1000.0);

    /// Get the current date and time
    final dateTime = DateTime.now();

    /// Parse the TLE
    final TLE tleSGP4 = TLE(tleData[0].tle0, tleData[0].tle1, tleData[0].tle2 );

    ///Create a orbit object and print if is
    ///SGP4, for "near-Earth" objects, or SDP4 for "deep space" objects.
    final Orbit orbit = Orbit(tleSGP4);

    /// get the utc time in Julian Day
    ///  + 4/24 need it, diferent time zone (Cuba -4 hrs )
    final double utcTime = Julian.fromFullDate(dateTime.year, dateTime.month,
        dateTime.day, dateTime.hour, dateTime.minute)
        .getDate() +
        3.3 / 24.0;

    final Eci eciPos =
    orbit.getPosition((utcTime - orbit.epoch().getDate()) * MIN_PER_DAY);


    CoordTopo topo = myLocation.getLookAngle(eciPos);

    return {
      'az': rad2deg(topo.az),
      'el': rad2deg(topo.el)
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 400,
      child: SingleChildScrollView( // Prevent overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (tleData.isNotEmpty) ...[
              RichText(
                text: TextSpan(
                  text: "TLE0: ",
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                  children: [
                    TextSpan(
                      text: "${tleData[0].tle0}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: "TLE1: ",
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                  children: [
                    TextSpan(
                      text: "${tleData[0].tle1}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: "TLE2: ",
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                  children: [
                    TextSpan(
                      text: "${tleData[0].tle2}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: "TLE Source: ",
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                  children: [
                    TextSpan(
                      text: "${tleData[0].tleSource}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: "NORAD Cat ID: ",
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                  children: [
                    TextSpan(
                      text: "${tleData[0].noradCatId}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: "Updated: ",
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                  children: [
                    TextSpan(
                      text: "${tleData[0].updated}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(5),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Replace 'AnotherPage' with the actual name of your other page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Blue(az: finalMap['az'],el: finalMap['el'] )));
                  },
                  icon: Icon(Icons.bluetooth),
                  label: Text('Press to point'),
                ),
              ),
            ] else ...[
              SizedBox(
                height: 300,
                child: Transform.scale(
                  scale: 5,
                  child: const Center(
                    child:
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 2,
                      )
                  ),
                ),
              ),
            ],

          ],
        ),
      ),
    );
  }
}