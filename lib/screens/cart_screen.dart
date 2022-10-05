import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/providers/orders_providers.dart';
import 'package:shoping_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Item'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Total:',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Chip(
                      label: Text('\$ ${cart.totalSum.toStringAsFixed(2)}'),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    cart.totalSum == 0
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              Provider.of<Orders>(context, listen: false)
                                  .addorder(
                                cart.items.values.toList(),
                                cart.totalSum,
                              );
                              cart.clearCart();
                            },
                            child: const Text('place order!'),
                          )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartWidget(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].title,
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].amount,
              ),
              itemCount: cart.itemCount,
            ),
          )
        ],
      ),
    );
  }
}
