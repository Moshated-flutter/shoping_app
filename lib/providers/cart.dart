import 'package:flutter/material.dart';

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

  void addCart(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                amount: value.amount + 1,
                price: value.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                amount: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeitem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removesingleItem(String singleItemid) {
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
}
