import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_habit/controllers/datecontroller.dart';
import 'package:my_habit/controllers/habits_logic_controller.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/root.dart';
import 'package:my_habit/widget/boxes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initalize hive
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('habit');

  final dateController = Get.put(DateController());
	final hlc = Get.put(HabitsLogicController());
	int currentStreaksHabits = 0;
	int longestStreaksHabits = 0;

  // initalize sharedpreferences
  final box = Boxes.getHabit();
  final pref = await SharedPreferences.getInstance();
  final int? day = pref.getInt("day");
  final int? csh = pref.getInt("currentStreakshabits");
  final int? lsh = pref.getInt("longestStreakshabits");
//	final int? month = pref.getInt("month");
//	final int? year = pref.getInt("year");
  if (day != null) {
    if (day != dateController.dateToday.day) {
      box.toMap().forEach(
        (key, value) {
          if (value.currentGoals == value.goals) {
            value.currentStreaks += 1;
            value.longestStreaks += 1;
          } else if (value.currentGoals < value.goals || value.currentGoals == 0) {
            value.currentStreaks = 0;
          }
          print("masuk ke map");
          value.currentGoals = 0;
          value.status = "active";
          value.save();
        },
      );
    }
  }
  pref.setInt("day", dateController.dateToday.day);
//	pref.setInt("month", dateController.dateToday.month);
//	pref.setInt("year", dateController.dateToday.year);


	print("============ MASUK PERTAMA KALI APLIKASI =================");
	//DateTime time = DateTime.now().subtract(Duration(days: 1));
		//	double checkValue = hlc.getAverageHabitDay(time.day, time.month, time.year) / hlc.getHabitOnTheDay(time.day, time.month, time.year) * 100;
	//		print("ini checkValue : ${checkValue}");

	if (day != null){
		if(csh != null){
			currentStreaksHabits = csh;
			print("masuk ke csh");
		}
		if(lsh != null){
			longestStreaksHabits = lsh;
		}

		if(day != dateController.dateToday.day){
			DateTime time = DateTime.now().subtract(Duration(days: 1));
			double checkValue = hlc.getAverageHabitDay(time.day, time.month, time.year) / hlc.getHabitOnTheDay(time.day, time.month, time.year) * 100;
			if (checkValue != 100.0){
				currentStreaksHabits = 0;
			}else{
				currentStreaksHabits += 1;
				longestStreaksHabits += 1;
			}
		}
	}

	pref.setInt("currentStreaksHabits", currentStreaksHabits);
	pref.setInt("longestStreaksHabits", longestStreaksHabits);

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
