import 'dart:convert';
import 'package:http/http.dart' as http;
import '../UI/tile.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://db.satnogs.org/api/satellites/?format=json'));

  if (response.statusCode == 200) {
    List<dynamic> productsJson = jsonDecode(response.body);
    return productsJson.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch products');
  }
}
