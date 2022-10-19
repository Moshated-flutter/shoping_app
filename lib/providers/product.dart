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
  Future<void> toggleFavorites() async {
    final url =
        'https://shopapp-a5aa1-default-rtdb.firebaseio.com/product/$id.json';
    var dummyfav = isFavorite;
    isFavorite = !isFavorite;
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({
        'isfav': isFavorite,
      }),
    );
    if (response.statusCode >= 400) {
      isFavorite = dummyfav;
    }

    notifyListeners();
  }
}
