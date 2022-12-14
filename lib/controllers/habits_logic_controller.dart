import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_habit/controllers/data_sharedpreferences.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/widget/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsLogicController extends GetxController {
  final box = Boxes.getHabit();
	
	// ================== Achievement Habit Page =======================
	// return value average per habit
  double getAverageHabit(Habit habit) {
    double result = 0.0;
    int dayOff = 0;
    int lengthDay = 1;
    if (habit.completeDay.isNotEmpty) {
      for (int i = 0; i < habit.completeDay.length; i++) {
        if (habit.completeDay[i]['finishGoals'] == 0 && habit.completeDay.length > 1) {
          dayOff += 1;
        } else {
          double average = habit.completeDay[i]['finishGoals'] / habit.completeDay[i]['goals'];
          result += average;
        }
      }
      lengthDay = habit.completeDay.length - dayOff;
    }
    return double.parse((result / lengthDay).toStringAsFixed(2));
  }

	// return value average all habit
  double getAverageAllHabit() {
    double result = 0.0;
    int oneTaskHabit = 0;
    int boxLength = box.length;
    box.toMap().forEach((key, value) {
      if (value.type == 'reguler') {
        double count = getAverageHabit(value);
        if (boxLength > 1 && count == 0.0) {
          boxLength -= 1;
        }
        result += count;
      } else {
        oneTaskHabit += 1;
      }
    });
		double averageAllHabit = double.parse((result / (boxLength - oneTaskHabit)).toStringAsFixed(2));
    return box.isEmpty ? 0.0 : averageAllHabit.isNaN ?  0.0 : averageAllHabit;
  }

  double getCompleteDay(Habit habit, int date, int month, int year) {
    double result = 0.0;
		if(habit.completeDay.isNotEmpty){
			for (int i = 0; i < habit.completeDay.length; i++) {
				if (habit.completeDay[i]['day'] == date && habit.completeDay[i]['month'] == month && habit.completeDay[i]['year'] == year) {
        result = habit.completeDay[i]['finishGoals'] / habit.completeDay[i]['goals'];
				}
			}
		}
    return result;
  }

	// return value average all habit in the day
  double getAverageHabitDay(int date, int month, int year) {
    double result = 0.0;
    box.toMap().forEach((key, value) {
			if(value.type == "reguler"){
				result += getCompleteDay(value, date, month, year);
			}
    });
    return result;
  }

	// return value average to percentage circular progress bar
	double getFinalAverageHabitDay(int date, int month, int year){
		double averageHabitDay = getAverageHabitDay(date, month, year);
		int habitOnTheDay = getHabitOnTheDay(date, month, year);
	
		double result = (averageHabitDay / habitOnTheDay) * 100;
		return result.isNaN ? 0.0 : result;
	}

	// return count of habit
  int getHabitOnTheDay(int date, int month, int year) {
		String nameDay = DateFormat('EEEE').format(DateTime.now());
    int result = 0;
    box.toMap().forEach((key, value) {
      if (value.type == 'reguler') {
        if (value.start.day <= date && checkDate(value, date, month, year) ||
					value.start.month < month && checkDate(value, date, month, year) ||
					value.start.year < year && checkDate(value, date, month, year) ||
					getDay(value,nameDay) && value.start.day <= date
					) {
          result += 1;
        } 
			}
    });
    return result;
  }

	bool getDay(Habit habit, String day){
		bool result = false;
		String nameDay = '';
		if(day == 'Sunday') nameDay = 'Su';
		else if (day == 'Monday') nameDay = 'Mo';
		else if (day == 'Tuesday') nameDay = 'Tu';
		else if (day == 'Wednesday') nameDay = 'We';
		else if (day == 'Thursday') nameDay = 'Th';
		else if (day == 'Friday') nameDay = 'Fr';
		else if (day == 'Saturday') nameDay = 'Sa';

		result = habit.day[nameDay]!;
		return result;
	}



	// delete item in shared preferences
	void deleteItem() async{
		final dataSP = Get.find<DataSharedPreferences>();
		final pref = await SharedPreferences.getInstance();
		final box = Boxes.getHabit();
		if(box.length == 0){
			pref.remove("currentStreaksHabits");
		  pref.remove("longestStreaksHabits");
			pref.remove("totalPerfectDay");
			dataSP.clearData();
		}
	}




	// ================ Detail Page Habit ===============
	// return true if date are the same with habit history
	bool checkDate(Habit habit,int day, int month, int year) {
    for (int i = 0; i < habit.completeDay.length; i++) {
      if (habit.completeDay[i]["day"] == day &&
          habit.completeDay[i]["month"] == month &&
          habit.completeDay[i]["year"] == year) {
        return true;
      }
    }
    return false;
  }

	// return index from history habit
  int getIndexCompleteDay(Habit habit, int day, int month, int year) {
    for (int i = 0; i < habit.completeDay.length; i++) {
      if (habit.completeDay[i]["day"] == day &&
          habit.completeDay[i]["month"] == month &&
          habit.completeDay[i]["year"] == year) {
        return i;
      }
    }
    return 0;
  }

	// average daily habit
  double getAverageDaily(Habit habit) {
    double count = 0.0;
    int dayOff = 0;
    int lengthDay = 1;
    for (int i = 0; i < habit.completeDay.length; i++) {
      if (habit.completeDay[i]['finishGoals'] == 0) {
        dayOff += 1;
      } else {
        double average = habit.completeDay[i]['finishGoals'] / habit.completeDay[i]['goals'];
        count += average;
      }
    }
    lengthDay = habit.completeDay.length - dayOff;
		double result = double.parse((count / lengthDay).toStringAsFixed(2));
    return result.isNaN ? 0.0 : result;
  }

	// return total perfect day
  int getTotalPerfectDay(Habit habit) {
    int total = 0;
    for (int i = 0; i < habit.completeDay.length; i++) {
      if (habit.completeDay[i]['finishGoals'] == habit.completeDay[i]['goals']) {
        total += 1;
      }
    }
    return total;
  }

	// return average perfect day
  double getAveragePerfectDay(Habit habit) {
    int totalPerfect = 0;
		int dayOff = 0;
    for (int i = 0; i < habit.completeDay.length; i++) {
      if (habit.completeDay[i]['finishGoals'] == habit.completeDay[i]['goals']) {
        totalPerfect += 1;
      }else if(habit.completeDay[i]['finishGoals'] == 0){
				dayOff += 1;

			}
    }
    return double.parse((totalPerfect / (habit.completeDay.length - dayOff)).toStringAsFixed(2));
  }


	
	//==================== Habits Page ==================
	// return value total average perfect day
	double getTAPD(int totalPerfectDay, int dayOff){
		double result = (totalPerfectDay / (totalPerfectDay + dayOff)) * 100;
		return result.isNaN ? 0.0 : result;
	}

	// return value average daily habits
	double getAverageDailyHabits(){
		double count = 0.0;
		int oneTaskHabit = 0;
		int dayOff = 0;
		if(box.isNotEmpty){
			box.toMap().forEach((key, value) {
				if(value.type == "reguler"){
					if (value.completeDay.isEmpty) dayOff += 1;
					count += getAverageDaily(value);
					print("count = ${count}");
				}else{
					oneTaskHabit += 1;
				}
			});
		}

		double result = count.isNaN ? 0.0 : ((count / (box.length - oneTaskHabit - dayOff)) * 100);
		return result;

	}



	double getAverageTotalDays(){
		double totalAverage = 0.0;
		int oneTaskHabit = 0;
		int boxLength = 0;
		box.toMap().forEach((key, value) {
			if(value.type == "reguler"){
				
			}
		});
		return totalAverage;
	}

}
