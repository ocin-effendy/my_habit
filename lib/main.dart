import 'package:flutter/material.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/root.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataHabitsProvider>(
			create: (context) => DataHabitsProvider(),
      child: const MaterialApp(
			debugShowCheckedModeBanner: false,
			home: RootPage(),	
		),
    );
  }
}
