// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart.dart';

class CartWidget extends StatelessWidget {
  final String id;
  final String productid;
  final String title;
  final double price;
  final double amount;
  const CartWidget(this.id, this.productid, this.title, this.price, this.amount,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final cartInfo = Provider.of<Cart>(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeitem(productid);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (cont) {
            return AlertDialog(
              title: const Text('Do you want to remove the item ?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(cont).pop(true),
                  child: const Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
      },
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.all(20),
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 15,
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text(
                  '\$$price',
                  softWrap: true,
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('\$${amount * price}'),
            trailing: Text('x$amount'),
          ),
        ),
      ),
    );
  }
}
