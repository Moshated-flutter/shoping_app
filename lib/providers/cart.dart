// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoping_app/models/exception_http.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final double amount;
  CartItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  final String? tokenid;
  final String? userid;
  Cart(this.tokenid, this._items, this.userid);
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
    final urlnew =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/cart/$userid.json?auth=$tokenid';
    if (_items.containsKey(productId)) {
      var findedaddress = _items[productId]!.id;
      final urlUpdate =
          'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/cart/$userid/$findedaddress.json?auth=$tokenid';
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

  void printitems() {
    print(_items);
  }

  void removeitem(String productid) async {
    final url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/cart/$userid/$productid.json?auth=$tokenid';

    CartItem? existingcart = _items[productid];
    _items.removeWhere((key, value) => key == productid);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.addAll({
        productid: CartItem(
            id: existingcart!.id,
            title: existingcart.title,
            amount: existingcart.amount,
            price: existingcart.price)
      });
      notifyListeners();
      throw ExceptionHttp('An error had eccurred');
    }
    existingcart = null;
    _items.remove(productid);
    notifyListeners();
  }

  void clearCart() async {
    Map<String, CartItem>? dummmyitem = _items;
    final url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/cart/$userid.json?auth=$tokenid';
    _items = {};
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items = dummmyitem;
      notifyListeners();
      return;
    }
    dummmyitem = null;
  }

  void clearCartinternals() {
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
    final url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/cart/$userid.json?auth=$tokenid';

    final response = await http.get(Uri.parse(url));
    if (response == null) {
      return;
    }

    if (json.decode(response.body) == null || response.statusCode >= 400) {
      return;
    }
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final Map<String, CartItem> loadedCart = {};
    extractedData.forEach((key, value) {
      var amountvalue = value['amount'];
      double amountchangetoint = amountvalue.toDouble();
      loadedCart.addAll({
        key: CartItem(
          amount: amountchangetoint,
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
