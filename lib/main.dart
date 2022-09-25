import 'package:flutter/material.dart';
import 'package:shoping_app/models/product.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/product_details_screen.dart';
import 'package:shoping_app/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products_provider(),
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
          ProductDetails.routeName: (context) {
            return ProductDetails();
          }
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
