import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/product.dart';
import 'package:shoping_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final chossenproducts = Provider.of<Product_models>(context);
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
            fit: BoxFit.fill,
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
              chossenproducts.toggleFavorites();
            },
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
    );
  }
}
