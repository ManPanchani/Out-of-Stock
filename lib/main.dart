import 'package:flutter/material.dart';
import 'package:viva_app/screens/cart_page.dart';
import 'package:viva_app/screens/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) =>  const HomePage(),
        'CartPage': (context) =>  const CartPage(),
      },
    ),
  );
}
