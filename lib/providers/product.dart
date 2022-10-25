// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product_models with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavorite;
  Product_models({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  Future<void> toggleFavorites(String userid, String token) async {
    final url =
        'https://shopapp-a5aa1-default-rtdb.firebaseio.com/product/userfavorites/$userid/$id.json?auth=$token';
    var dummyfav = isFavorite;
    isFavorite = !isFavorite;
    final response = await http.put(
      Uri.parse(url),
      body: json.encode(isFavorite),
    );
    if (response.statusCode >= 400) {
      isFavorite = dummyfav;
    }

    notifyListeners();
  }
}
