import 'package:flutter/material.dart';
import 'package:shoping_app/screens/ordrer_screen.dart';

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
          )
        ],
      ),
    );
  }
}
