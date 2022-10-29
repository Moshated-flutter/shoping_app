import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/auth_provider.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/screens/ordrer_screen.dart';
import 'package:shoping_app/screens/user_product.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Get all you want here.'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Your Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routename);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Manage Your Products'),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductScreen.routename);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Cart>(context, listen: false).clearCartinternals();
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
