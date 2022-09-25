import 'package:flutter/material.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProducts_data = Provider.of<Products_provider>(context);
    final loadedProducts = loadedProducts_data.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            height: 500,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductItem(
                  loadedProducts[index].id,
                  loadedProducts[index].title,
                  loadedProducts[index].imageUrl,
                );
              },
              itemCount: loadedProducts.length,
            ),
          ),
        ],
      ),
    );
  }
}
