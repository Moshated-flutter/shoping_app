import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/widgets/product_item.dart';

import '../providers/product_providers.dart';

class ProductGrid extends StatelessWidget {
  final bool favoriteFillter;
  ProductGrid(this.favoriteFillter);

  @override
  Widget build(BuildContext context) {
    final loadedProductsData = Provider.of<Products_provider>(context);
    final loadedProducts = favoriteFillter
        ? loadedProductsData.favItems
        : loadedProductsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: ProductItem(),
        );
      },
      itemCount: loadedProducts.length,
    );
  }
}
