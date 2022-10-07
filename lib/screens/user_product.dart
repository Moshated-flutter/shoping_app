import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/add_product.dart';
import 'package:shoping_app/screens/app_drawer.dart';
import 'package:shoping_app/widgets/product_list_user.dart';

class UserProductScreen extends StatelessWidget {
  static const routename = '/userproduct';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products_provider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddProduct.routename);
            },
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Your products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) => UserProductList(
            productData.items[index].title,
            productData.items[index].imageUrl,
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}