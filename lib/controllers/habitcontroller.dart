import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HabitController extends GetxController {
  TimeOfDay _time = TimeOfDay.now();

  final nameHabitController = TextEditingController(); //title
  final goalsHabitController = TextEditingController(); // goals
  bool statusInput = true;
  bool statusSwitchGoalhabits = false;
  bool statusSwitchRepeatEveryday = false;
  bool statusSwitchReminders = false;

  IconData iconHabit = Icons.star_rate_rounded; //IconHabit
  String descGoals = 'times'; //descGoals
  String statusRepeat = 'daily'; //statusRepeat
  int week = 1;
  int month = 1;
  String statusHabits = "active";
  String timeReminders = "Do anytime";
  Map<String, bool> listDays = {
    "Su": true,
    "Mo": false,
    "Tu": false,
    "We": false,
    "Th": false,
    "Fr": false,
    "Sa": false,
  };
  late String time;
  List<String> listTime = ['12:50'];
	List<IconData> dataHabits = [];
	void addDatahabits(IconData data){
		dataHabits.add(data);
		update();
	}




	void setStatusInput(bool value){
		statusInput = value;
		update();
	}

	void setIconHabit(IconData icon){
		iconHabit = icon;
		update();
	}

	void setStatusSwitchGoalHabits(bool value){
		statusSwitchGoalhabits = value;
		update();
	}

	void setDescGoals(String name){
		descGoals = name;
		update();
	}

	void setStatusRepeat(String name){
		statusRepeat = name;
		update();
	}

	void setListDays(String key, bool value){
		listDays[key] = value;
	}

	void setStatusSwicthRepeatEveriday(bool value){
		statusSwitchRepeatEveryday = value;
		update();
	}


	void setValueStatusSwitchRepeatEveriday(bool value, String name, int position){
		if(value){
			listDays['Su'] = listDays['Mo'] = listDays['Tu'] =listDays['We'] =
			listDays['Th'] = listDays['Fr'] = listDays['Sa'] =  true;
		}else{
			listDays['Su'] = true;
			listDays['Mo'] = listDays['Tu'] =listDays['We'] =
			listDays['Th'] = listDays['Fr'] = listDays['Sa'] =  false;
		}

		if(name == 'day'){
			week = month = position;
		}else if(name == 'week'){
			week = position;
      month = 1;
		}else{
			month = position;
			week = 1;
		}
		update();
	}



	void setStatusSwicthReminder(bool value){
		statusSwitchReminders = value;
		update();
	}

	void deleteListTime(int i){
		listTime.removeAt(i);
		update();
	}

	void selectTime(BuildContext context) async {
		final newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      _time = newTime;
      time = _time.toString().split("(")[1].split(")")[0];
      listTime.add(time);
			update();
    }
  }


	@override
	  void onInit() {
			if (listTime.isNotEmpty) {
        statusSwitchReminders = true;
			}
	    super.onInit();
	  }


	@override
	void dispose() {
		nameHabitController.dispose();
		goalsHabitController.dispose();
	  super.dispose();
	}

}
