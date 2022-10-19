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
                        : Adding_oreder_buttom(cart: cart)
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

class Adding_oreder_buttom extends StatefulWidget {
  const Adding_oreder_buttom({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;
  @override
  State<Adding_oreder_buttom> createState() => _Adding_oreder_buttomState();
}

class _Adding_oreder_buttomState extends State<Adding_oreder_buttom> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return _isloading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () async {
              setState(() {
                _isloading = true;
              });
              await Provider.of<Orders>(context, listen: false).addorder(
                widget.cart.items.values.toList(),
                widget.cart.totalSum,
              );
              setState(() {
                _isloading = false;
              });

              widget.cart.clearCart();
            },
            child: const Text('place order!'),
          );
  }
}
