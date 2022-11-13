import 'package:get/get.dart';
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
		print("==================================");
		print("average Habit Day = ${averageHabitDay}");
		print("habit on the day = ${habitOnTheDay}");
		double result = (averageHabitDay / habitOnTheDay) * 100;
		print("ini result final = ${result}");
		return result.isNaN ? 0.0 : result;
	}

	// return count of habit
  int getHabitOnTheDay(int date, int month, int year) {
    int result = 0;
    box.toMap().forEach((key, value) {
      if (value.type == 'reguler') {
        if (value.start.day <= date ||value.start.month < month ||value.start.year < year) {
          result += 1;
        } 
			}
    });
    return result;
  }



	// delete item in shared preferences
	void deleteItem() async{
		final pref = await SharedPreferences.getInstance();
		final box = Boxes.getHabit();
		if(box.length == 0){
			pref.remove("currentStreaksHabits");
		  pref.remove("longestStreaksHabits");
			pref.remove("totalPerfectDay");
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
    double result = 0.0;
    int dayOff = 0;
    int lengthDay = 1;
    for (int i = 0; i < habit.completeDay.length; i++) {
      if (habit.completeDay[i]['finishGoals'] == 0) {
        dayOff += 1;
      } else {
        double average = habit.completeDay[i]['finishGoals'] / habit.completeDay[i]['goals'];
        result += average;
      }
    }
    lengthDay = habit.completeDay.length - dayOff;

    return double.parse((result / lengthDay).toStringAsFixed(2));
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
