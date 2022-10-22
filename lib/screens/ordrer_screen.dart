// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/orders_providers.dart';
import 'package:shoping_app/screens/app_drawer.dart';
import 'package:shoping_app/widgets/order_items.dart';

class OrderScreen extends StatefulWidget {
  static const routename = '/orederscreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _init = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_init) {
      _init = false;
      setState(() {
        _isloading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .fetchAndSettheOrders()
          .then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  Orderwidget(orderData.orders[index]),
              itemCount: orderData.orders.length,
            ),
    );
  }
}
