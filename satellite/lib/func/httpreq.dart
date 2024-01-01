import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getSatelliteInfo() async {
  final url = Uri.parse('http://192.168.1.5:5000/satellite-info');
  final body = {
    "line1": "1 25544U 98067A   21230.44711458  .00002106  00000+0  49681-4 0  9990",
    "line2": "2 25544  51.6444  19.3613 0004256  15.8430 344.5364 15.50197142280143",
    "latitude": "28.9",
    "longitude": "76.56667",
    "elevation": "76.56667",
    "dateTime": "2023-08-20-18-31-00",
  };

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final azimuth = data['azimuth_deg'] as double;
    final elevation = data['elevation_deg'] as double;
    print('Azimuth: $azimuth, Elevation: $elevation');
  } else {
    print('Failed to get satellite info');
  }
}