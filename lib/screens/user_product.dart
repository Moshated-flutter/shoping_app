// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/add_product.dart';
import 'package:shoping_app/screens/app_drawer.dart';
import 'package:shoping_app/widgets/product_list_user.dart';

class UserProductScreen extends StatelessWidget {
  static const routename = '/userproduct';
  Future<void> _refresh(BuildContext ctx) async {
    await Provider.of<Products_provider>(ctx, listen: false)
        .fetchAndSetproduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddProduct.routename);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Your products'),
      ),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return _refresh(context);
                    },
                    child: Consumer<Products_provider>(
                      builder: (context, productData, child) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemBuilder: (context, index) => UserProductList(
                            productData.items[index].id,
                            productData.items[index].title,
                            productData.items[index].imageUrl,
                          ),
                          itemCount: productData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
