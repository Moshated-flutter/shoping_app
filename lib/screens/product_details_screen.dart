// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/product_providers.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context)?.settings.arguments as String;
    final chosenProduc = Provider.of<Products_provider>(context)
        .items
        .firstWhere((element) => element.id == productid);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            // title: Text(chosenProduc.title),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Card(
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: 220,
                  child: Text(
                    chosenProduc.title,
                  ),
                ),
              ),
              background: Hero(
                tag: chosenProduc.id,
                child: Image.network(
                  chosenProduc.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Card(
                    child: Text(
                      '\$${chosenProduc.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Card(
                    child: Text(chosenProduc.description),
                  ),
                ),
                const SizedBox(
                  height: 800,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
