import 'package:flutter/foundation.dart';

class Product_models {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  bool? isFavorite;
  Product_models(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite});
}
