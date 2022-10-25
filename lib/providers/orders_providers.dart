// ignore_for_file: prefer_final_fields, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItems({
    required this.id,
    required this.amount,
    required this.dateTime,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];
  List<OrderItems> get orders {
    return [..._orders];
  }

  final String tokeid;
  Orders(this.tokeid, this._orders);

  Future<void> addorder(List<CartItem> cartproduct, double total) async {
    // var dummycart = cartproduct
    //     .map((e) => {
    //           'cartid': e.id,
    //           'carttitle': e.title,
    //           'cartprice': e.price,
    //           'cartamount': e.amount,
    //         })
    //     .toList();
    // print(dummycart);
    final url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/order.json?auth=$tokeid';
    final datetime = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'totalamount': total.toDouble(),
          'datetime': datetime.toIso8601String(),
          'cartProdut': cartproduct
              .map((e) => {
                    'cartid': e.id,
                    'carttitle': e.title,
                    'cartprice': e.price.toDouble(),
                    'cartamount': e.amount.toDouble(),
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItems(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: datetime,
        products: cartproduct,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSettheOrders() async {
    final url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/order.json?auth=$tokeid';
    final response = await http.get(Uri.parse(url));
    if (json.decode(response.body) == null) {
      return;
    }

    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final List<OrderItems> loadedOrder = [];
    extractedData.forEach((key, value) {
      loadedOrder.add(
        OrderItems(
          id: key,
          amount: value['totalamount'],
          dateTime: DateTime.parse(value['datetime']),
          products: (value['cartProdut'] as List<dynamic>)
              .map(
                (e) => CartItem(
                  id: e['cartid'],
                  title: e['carttitle'],
                  amount: e['cartamount'],
                  price: e['cartamount'],
                ),
              )
              .toList(),
        ),
      );
      _orders = loadedOrder;
      notifyListeners();
    });
  }
}
