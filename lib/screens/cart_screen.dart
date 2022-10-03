import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Item'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Total:',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Chip(
                      label: Text('\$ ${cart.totalSum}'),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    cart.totalSum == 0
                        ? SizedBox()
                        : TextButton(
                            onPressed: () {},
                            child: Text('place order!'),
                          )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartWidget(
                cart.items.values.toList()[index].id,
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
