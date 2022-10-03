import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart.dart';

class CartWidget extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int amount;
  CartWidget(this.id, this.title, this.price, this.amount);

  @override
  Widget build(BuildContext context) {
    final cartInfo = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      child: Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text(
                  '\$${price}',
                  softWrap: true,
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('\$${amount * price}'),
            trailing: Text('x${amount}'),
          ),
        ),
      ),
    );
  }
}
