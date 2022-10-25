// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/auth_provider.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/providers/product.dart';
import 'package:shoping_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chossenproducts = Provider.of<Product_models>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authdata = Provider.of<AuthProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        // ignore: sort_child_properties_last
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetails.routeName,
              arguments: chossenproducts.id,
            );
          },
          child: Image.network(
            chossenproducts.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          title: FittedBox(
            child: Text(
              chossenproducts.title,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: Icon(chossenproducts.isFavorite == true
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              chossenproducts.toggleFavorites(
                  authdata.userid!, authdata.token!);
            },
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addCart(
                chossenproducts.id,
                chossenproducts.price,
                chossenproducts.title,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('added to the cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo!',
                    onPressed: () {
                      cart.removesingleItem(chossenproducts.id);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
    );
  }
}
