// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/orders_providers.dart';
import 'package:shoping_app/screens/app_drawer.dart';
import 'package:shoping_app/widgets/order_items.dart';

class OrderScreen extends StatelessWidget {
  static const routename = '/orederscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false)
              .fetchAndSettheOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occurred!'),
              );
            }

            return Consumer<Orders>(
              builder: (context, value, child) => ListView.builder(
                itemBuilder: (ctx, index) => Orderwidget(
                  value.orders[index],
                ),
                itemCount: value.orders.length,
              ),
            );
          }),
    );
  }
}
