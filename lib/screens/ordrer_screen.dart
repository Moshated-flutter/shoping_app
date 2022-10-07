import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/orders_providers.dart';
import 'package:shoping_app/screens/app_drawer.dart';
import 'package:shoping_app/widgets/order_items.dart';

class OrderScreen extends StatelessWidget {
  static const routename = '/orederscreen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => Orderwidget(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
