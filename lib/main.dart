// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shoping_app/providers/auth_provider.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/providers/orders_providers.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/add_product.dart';
import 'package:shoping_app/screens/auth_screen.dart';
import 'package:shoping_app/screens/cart_screen.dart';
import 'package:shoping_app/screens/edit_screen.dart';
import 'package:shoping_app/screens/loading_screen.dart';
import 'package:shoping_app/screens/ordrer_screen.dart';
import 'package:shoping_app/screens/product_details_screen.dart';
import 'package:shoping_app/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/screens/user_product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Cart>(
          create: (context) => Cart(
              Provider.of<AuthProvider>(context, listen: false).token,
              {},
              Provider.of<AuthProvider>(context, listen: false).userid),
          update: (context, value, previous) =>
              Cart(value.token, previous!.items, value.userid),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Orders>(
          create: (context) => Orders(
              Provider.of<AuthProvider>(context, listen: false).token,
              [],
              Provider.of<AuthProvider>(context, listen: false).userid),
          update: (context, value, previous) =>
              Orders(value.token, previous!.orders, value.userid),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Products_provider>(
          create: (context) => Products_provider(
            Provider.of<AuthProvider>(context, listen: false).token,
            [],
            Provider.of<AuthProvider>(context, listen: false).token,
          ),
          update: (context, value, previous) => Products_provider(
            value.token,
            previous!.items,
            value.userid,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.lime,
            textTheme: GoogleFonts.latoTextTheme(Theme.of(ctx).textTheme),
          ),
          home: auth.isauth
              ? ProductScreen()
              : FutureBuilder(
                  future: auth.tryautologin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetails.routeName: (ctx) => ProductDetails(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routename: (ctx) => OrderScreen(),
            UserProductScreen.routename: (ctx) => UserProductScreen(),
            AddProduct.routename: (ctx) => AddProduct(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductScreen();
  }
}
