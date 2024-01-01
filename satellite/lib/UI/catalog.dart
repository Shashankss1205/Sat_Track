import 'package:flutter/material.dart';
import 'package:satellite/UI/tile.dart';

import '../api/api.dart';
import 'SingleTask.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Product> products = []; // Back to using Product class

  @override
  void initState() {
    super.initState();
    fetchProducts().then((fetchedProducts) { // Call fetchProducts again
      setState(() {
        products = fetchedProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return
          SingleTask(
            name: products[index].name,
            sat_id: products[index].satId, // Assuming Product has a status property
            img: products[index].image.isNotEmpty ? "https://db-satnogs.freetls.fastly.net/media/${products[index].image}" :
                  "https://img.freepik.com/free-vector/page-found-concept-illustration_114360-1869.jpg?size=338&ext=jpg&ga=GA1.1.1546980028.1704067200&semt=ais",
          );
      },
    );
  }
}
