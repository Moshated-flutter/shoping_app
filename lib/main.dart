// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shoping_app/providers/cart.dart';
import 'package:shoping_app/providers/orders_providers.dart';

import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/add_product.dart';
import 'package:shoping_app/screens/cart_screen.dart';
import 'package:shoping_app/screens/edit_screen.dart';
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
          create: (ctx) => Products_provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lime,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        ),
        home: MyHomePage(),
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routename: (context) => OrderScreen(),
          UserProductScreen.routename: (context) => UserProductScreen(),
          AddProduct.routename: (context) => AddProduct(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
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
