import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:satellite/func/tleToDeg.dart';

import '../UI/infobox.dart';

Future<List<Info>> fetchAndSearchData({required String value}) async {
  final response = await http.get(Uri.parse('https://db.satnogs.org/api/tle/?format=json'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as List; // Parse once

    // Find matching items and create Info objects
    final matchingInfo = jsonData.where((item) => item["sat_id"] == value)
        .map((item) => Info.fromJson(item))
        .toList();
    print(matchingInfo);
    return matchingInfo; // Return as a Future
  } else {
    throw Exception('Failed to fetch products');
  }
}
