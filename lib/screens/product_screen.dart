// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/providers/product_providers.dart';

import 'package:shoping_app/screens/app_drawer.dart';
import 'package:shoping_app/screens/cart_screen.dart';
import 'package:shoping_app/widgets/203%20badge.dart';
import 'package:shoping_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var favoriteFillter = false;
  var _init = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Cart>(context).fetchAndSetCart();
      Provider.of<Products_provider>(context)
          .fetchAndSetproduct()
          .then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Shop'), actions: [
        PopupMenuButton(
          onSelected: (value) {
            setState(() {
              if (value == 0) {
                favoriteFillter = false;
              }
              if (value == 1) {
                favoriteFillter = true;
              }
            });
          },
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: Text('show all'),
              value: 0,
            ),
            const PopupMenuItem(
              child: Text('only favorites'),
              value: 1,
            ),
          ],
        ),
        Consumer<Cart>(
          builder: (context, cartData, child) => Badge(
            // ignore: sort_child_properties_last
            child: IconButton(
              icon: const Icon(Icons.shopping_basket),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
            value: cartData.itemCount.toString(),
          ),
        ),
      ]),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 700,
            child: _isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ProductGrid(favoriteFillter),
          ),
        ],
      ),
    );
  }
}
