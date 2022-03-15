import 'package:flutter/material.dart';
import 'page/index.dart';
import '';
void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestion Boutique 2.0.0",
      home: Boutique(),
      debugShowCheckedModeBanner: false,
    );
  }
}
