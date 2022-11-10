import 'package:get/get.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/widget/boxes.dart';

class HabitsLogicController extends GetxController{

	final box = Boxes.getHabit();

	double getAverageHabit(Habit habit){
		double result = 0.0;
		int dayOff = 0;
		int lengthDay = 1;
		if(habit.completeDay.isNotEmpty){
			for(int i = 0; i < habit.completeDay.length; i++){
				if (habit.completeDay[i]['finishGoals'] == 0 && habit.completeDay.length > 1){
					dayOff += 1;
				}else{
					double average = habit.completeDay[i]['finishGoals'] / habit.completeDay[i]['goals'];
					print("average : ${average}");
					result += average;
				}
			}
			lengthDay = habit.completeDay.length - dayOff;
		}
			print("============= masuk ke get average =============");
			print("habit = ${habit.title}");
			print(result);
			print(habit.completeDay.length);
			print(dayOff);
			print(double.parse((result / lengthDay).toStringAsFixed(2)));
			return double.parse((result / lengthDay).toStringAsFixed(2));
	}


	double getAverageAllHabit(){
		double result = 0.0;
		int oneTaskHabit = 0;
		int boxLength = box.length;
			box.toMap().forEach((key, value) {
				if(value.type == 'reguler'){
					double count = getAverageHabit(value);
					if (boxLength > 1 && count == 0.0){
						boxLength -=1;
					}
					result += count;
				}else{
					oneTaskHabit += 1;
				}
			});
			return double.parse((result / (boxLength - oneTaskHabit)).toStringAsFixed(2));
	}


	double getCompleteDay(Habit habit, int date, int month, int year){
		double result = 0.0;
		if(habit.completeDay.isNotEmpty){
			for(int i = 0; i < habit.completeDay.length; i++){
				if(habit.completeDay[i]['day'] == date && habit.completeDay[i]['month'] == month && habit.completeDay[i]['year'] == year){
					result = habit.completeDay[i]['finishGoals'] / habit.completeDay[i]['goals'];
					return result;
				}
			}
		}
		return result;
	}

	
	double getAverageHabitDay(int date, int month, int year){
		double result = 0.0;
		if(box.isNotEmpty){
			box.toMap().forEach((key, value) {
				result += getCompleteDay(value, date, month, year);
			});
		}
		
		return result;
	}

	int getHabitOnTheDay(int date, int month, int year){
		int result = 0;
		if (box.isNotEmpty){
			box.toMap().forEach((key, value) {
				if(value.type == 'reguler'){
					if(value.start.day <= date || value.start.month < month || value.start.year < year){
						result += 1;
					}
				}
			});
			print("print count habit on the day = ${result}");
		}
		return result;
	}
}
