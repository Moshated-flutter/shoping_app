import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/edit_screen.dart';

class UserProductList extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  var confimation = false;
  UserProductList(this.id, this.title, this.imageUrl);

  Future deleteform(BuildContext context1) {
    return showDialog(
      context: context1,
      builder: (cont) {
        return AlertDialog(
          title: Text('Do you want to remove the item ?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                confimation = true;
                Navigator.of(cont).pop();
              },
              child: Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                confimation = false;
                Navigator.of(cont).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit_rounded),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                deleteform(context);
                if (confimation) {
                  Provider.of<Products_provider>(context, listen: false)
                      .deleteProduct(id);
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
