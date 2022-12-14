import 'package:get/get.dart';
import 'package:my_habit/controllers/datecontroller.dart';
import 'package:my_habit/controllers/habits_logic_controller.dart';
import 'package:my_habit/widget/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPreferences extends GetxController{

  final dateController = Get.find<DateController>();
	final hlc = Get.find<HabitsLogicController>();


  final box = Boxes.getHabit();
	int currentStreaksHabits = 0;
	int longestStreaksHabits = 0;
	int totalPerfectDay = 0;
	int dayOff = 0;

	void clearData(){
		currentStreaksHabits = 0;
		longestStreaksHabits = 0;
		totalPerfectDay = 0;
		update();

	}

	void setData() async {
		final pref = await SharedPreferences.getInstance();
		final int? day = pref.getInt("day");
		final int? csh = pref.getInt("currentStreaksHabits");
		final int? lsh = pref.getInt("longestStreaksHabits");
		final int? tpd = pref.getInt("totalPerfectDay");
		final int? dayNotComplete = pref.getInt("dayOff");

		if (day != null) {
			if(csh != null) currentStreaksHabits = csh;
			

			if(lsh != null) longestStreaksHabits = lsh;
			

			if(tpd != null) totalPerfectDay = tpd;
			
			if(dayNotComplete != null) dayOff = dayNotComplete;
			

			if (day != dateController.dateToday.day) {
				box.toMap().forEach((key, value) {
          if (value.currentGoals == value.goals) {
            value.currentStreaks += 1;
						if (value.currentStreaks > value.longestStreaks){
							value.longestStreaks += 1;
						}
          } else if (value.currentGoals < value.goals || value.currentGoals == 0) {
            value.currentStreaks = 0;
          }
          value.currentGoals = 0;
          value.status = "active";
          value.save();
        },
      );

				DateTime time = DateTime.now().subtract(Duration(days: 1));
				double checkValue = hlc.getFinalAverageHabitDay(time.day, time.month, time.year);
				if (checkValue != 100.0){
					currentStreaksHabits = 0;
					dayOff += 1;
				}else{
					currentStreaksHabits += 1;
					totalPerfectDay += 1;
					if (currentStreaksHabits > longestStreaksHabits){
						longestStreaksHabits += 1;
					}
				}
			}
		}
		update();
	}


	void saveData() async {
		final pref = await SharedPreferences.getInstance();
		pref.setInt("currentStreaksHabits", currentStreaksHabits);
		pref.setInt("longestStreaksHabits", longestStreaksHabits);
		pref.setInt("totalPerfectDay", totalPerfectDay);
		pref.setInt("dayOff", dayOff);
		pref.setInt("day", dateController.dateToday.day);
	}

	@override
	  void onInit() {
	    super.onInit();
			setData();
			saveData();
	  }
}
