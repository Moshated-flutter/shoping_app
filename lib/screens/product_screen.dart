import 'package:flutter/material.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/widgets/product_grid.dart';
import 'package:shoping_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  var favoriteFillter = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Shop'), actions: [
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
          icon: Icon(Icons.more_vert),
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
        )
      ]),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            height: 500,
            child: ProductGrid(favoriteFillter),
          ),
        ],
      ),
    );
  }
}
