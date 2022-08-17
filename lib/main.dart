import 'package:flutter/material.dart';
import 'package:my_habit/home_page.dart';
import 'package:my_habit/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			home: RootPage(),	
				);
  }
}
