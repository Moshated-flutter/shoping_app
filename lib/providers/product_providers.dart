// ignore_for_file: camel_case_types, prefer_final_fields, use_rethrow_when_possible

import 'package:flutter/material.dart';
import 'package:shoping_app/models/exception_http.dart';
import 'package:shoping_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products_provider with ChangeNotifier {
  List<Product_models> _items = [
    // Product_models(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product_models(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product_models(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product_models(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  var favoritesFiltter = false;
  List<Product_models> get favItems {
    return items.where((element) => element.isFavorite).toList();
  }

  List<Product_models> get items {
    return [..._items];
  }

  Future<void> addproduct(Product_models product) async {
    const url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/product.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isfav': product.isFavorite
          }));

      final newproduct = Product_models(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newproduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void updateProduct(String id, Product_models newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/product/$id.json';
      http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'price': newProduct.price.toDouble(),
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  Product_models findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/product/$id.json';
    var existingindex = _items.indexWhere((element) => element.id == id);
    Product_models? existingproduct = _items[existingindex];
    _items.removeAt(existingindex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingindex, existingproduct);
      notifyListeners();
      throw ExceptionHttp('An error had eccurred');
    }
    existingproduct = null;
  }

  Future<void> fetchAndSetproduct() async {
    const url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/product.json';

    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product_models> loadedProduct = [];
    extractedData.forEach((key, value) {
      loadedProduct.add(
        Product_models(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: value['isfav'],
        ),
      );
    });
    _items = loadedProduct;
    notifyListeners();
  }
}
