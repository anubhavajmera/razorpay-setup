import 'package:flutter/material.dart';
import 'package:payment_app/my_payment_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyPaymentPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
