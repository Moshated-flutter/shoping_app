// ignore_for_file: prefer_final_fields

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
    const url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/order.json';
    final datetime = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'totalamount': total,
          'datetime': datetime.toIso8601String(),
          'cartProdut': cartproduct
              .map((e) => {
                    'cartid': e.id,
                    'carttitle': e.title,
                    'cartprice': e.price,
                    'cartamount': e.amount,
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
    const url =
        'https://shoping-4ff2a-default-rtdb.europe-west1.firebasedatabase.app/order.json';
    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
  }
}
