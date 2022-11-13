import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_habit/controllers/data_sharedpreferences.dart';
import 'package:my_habit/controllers/datecontroller.dart';
import 'package:my_habit/controllers/habits_logic_controller.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/root.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initalize hive
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('habit');

  final dateController = Get.put(DateController());
	final hlc = Get.put(HabitsLogicController());
	final dataSP = Get.put(DataSharedPreferences());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataHabitsProvider>(
      create: (context) => DataHabitsProvider(),
      child: GetMaterialApp(
        theme: buildTheme(),
        debugShowCheckedModeBanner: false,
        home: RootPage(),
      ),
    );
  }
}
