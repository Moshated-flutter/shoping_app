import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoping_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  ProductItem(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ProductDetails(title);
              },
            ));
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          title: FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
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
