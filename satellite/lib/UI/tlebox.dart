import 'package:flutter/material.dart';
import '../api/apiToTle.dart';
import 'infobox.dart'; // Assuming fetchAndSearchData is in api.dart

class MyTLEPage extends StatefulWidget {
  final String satId; // Pass the satellite ID for fetching data

  MyTLEPage({Key? key, required this.satId}) : super(key: key);

  @override
  State<MyTLEPage> createState() => _MyTLEPageState();
}

class _MyTLEPageState extends State<MyTLEPage> {
  List<Info> tleData = []; // Change to a list of Info objects

  @override
  void initState() {
    super.initState();
    fetchAndSearchData(value: widget.satId).then((fetchedData) {
      setState(() {
        tleData = fetchedData;
        print(tleData);
      });
    });
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