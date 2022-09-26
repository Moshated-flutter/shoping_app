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
      appBar: AppBar(
        title: Text(chosenProduc.title),
      ),
      body: Container(),
    );
  }
}
