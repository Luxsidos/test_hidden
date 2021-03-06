import 'package:flutter/material.dart';
import 'package:test_for_hidden/presentation/home_page.dart';
import 'package:test_for_hidden/presentation/multi_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiImagePage(),
    );
  }
}
