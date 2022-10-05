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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                chosenProduc.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Text(
                '\$${chosenProduc.price}',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Text(chosenProduc.description),
            )
          ],
        ),
      ),
    );
  }
}
