// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartItem {
  final String id;
  final String title;
  final double price;
  final int amount;
  CartItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalSum {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.amount * value.price;
    });
    return total;
  }

  void addCart(String productId, double price, String title) async {
    const urlnew =
        'https://shopapp-a5aa1-default-rtdb.firebaseio.com/cart.json';
    if (_items.containsKey(productId)) {
      var findedaddress = _items[productId]!.id;
      final urlUpdate =
          'https://shopapp-a5aa1-default-rtdb.firebaseio.com/cart/$findedaddress.json';
      _items.update(
        productId,
        (value) {
          http.patch(
            Uri.parse(
              urlUpdate,
            ),
            body: json.encode({
              'title': value.title,
              'price': value.price,
              'amount': value.amount + 1,
            }),
          );
          return CartItem(
            id: value.id,
            title: value.title,
            amount: value.amount + 1,
            price: value.price,
          );
        },
      );
    } else {
      final responseCart = await http.post(
        Uri.parse(urlnew),
        body: json.encode({
          'idProduct': productId,
          'title': title,
          'price': price,
          'amount': 1,
        }),
      );
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: json.decode(responseCart.body)['name'],
                title: title,
                amount: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeitem(String productid) async {
    _items.remove(productid);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removesingleItem(String singleItemid) async {
    if (!_items.containsKey(singleItemid)) {
      return;
    }
    if (_items[singleItemid]!.amount > 1) {
      _items.update(
          singleItemid,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                amount: value.amount - 1,
                price: value.price,
              ));
    } else {
      _items.remove(singleItemid);
    }
    notifyListeners();
  }

  Future<void> fetchAndSetCart() async {
    const url = 'https://shopapp-a5aa1-default-rtdb.firebaseio.com/cart.json';

    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final Map<String, CartItem> loadedCart = {};
    extractedData.forEach((key, value) {
      loadedCart.addAll({
        key: CartItem(
          amount: value['amount'],
          price: value['price'],
          id: value['idProduct'],
          title: value['title'],
        )
      });
    });
    _items = loadedCart;
    notifyListeners();
  }
}
