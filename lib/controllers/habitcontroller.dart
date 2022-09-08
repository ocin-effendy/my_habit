import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/utils/date_utils.dart' as date_util;
import 'package:my_habit/widget/boxes.dart';

class HabitController extends GetxController {
  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime.now();

	// UI interactive
  bool statusInput = true;
  bool statusSwitchGoalhabits = false;
  bool statusSwitchRepeatEveryday = false;
  bool statusSwitchReminders = false;

	// Data Create Habit
	//String type = ""; // type
	DateTime start = DateTime.now(); // start
  final nameHabitController = TextEditingController(); //title
	IconData iconHabit = Icons.star_rate_rounded; //IconHabit
  final goalsHabitController = TextEditingController(); // goals
	int currentGoals = 0; // currentGoals
  String descGoals = 'times'; //descGoals
  String statusRepeat = 'daily'; // statusRepeat
	Map<String, bool> listDays = { // day
    "Su": true,
    "Mo": false,
    "Tu": false,
    "We": false,
    "Th": false,
    "Fr": false,
    "Sa": false,
  };
  int week = 1; // week
  int month = 1; // month
  String status = "active"; // status
  List<TimeOfDay> timeReminders = []; // timeReminders
	Map<DateTime, double> completeDay = {}; // completeDay
	int currentStreaks = 0; // currentStreaks
	int longestStreaks = 0; // longestStreaks
  


  late String dateTime;
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
		week = month = 1;
		update();
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
			timeReminders.add(_time);
      time = _time.toString().split("(")[1].split(")")[0];
      listTime.add(time);
			update();
    }
  }



  void getDatePicker(context) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(_date.year, _date.month, _date.day),
        lastDate: DateTime(_date.year + 2),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                colorScheme: ColorScheme.dark(
                    surface: darkBlueOne, // head
                    onPrimary: darkBlueOne, // selected text color
                    onSurface: Colors.white, // default text color
                    primary: Colors.white // circle color
                    ),
                dialogBackgroundColor: darkBlueOne,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  primary: Colors.lightBlueAccent, // color of button's letters
                  backgroundColor: darkBlueOne, // Background color
                ))),
            child: child!,
          );
        });
    if (selectedDate != null) {
        _date = selectedDate;
				start = _date;
        dateTime ="${_date.day} ${date_util.DateUtils.months[_date.month - 1]} ${_date.year}";
				update();
    }
  }


	void addHabit(String type){
		final habit = Habit()
		..type = type
		..start = start
		..title = nameHabitController.text
		..icon = iconHabit.codePoint
		..goals = goalsHabitController.text == "" ? 0 : int.parse(goalsHabitController.text)
		..currentGoals = currentGoals
		..descGoals = descGoals
		..statusRepeat = statusRepeat
		..day = listDays
		..week = week
		..month = month
		..status = status
		..timeReminders = timeReminders
		..completeDay = completeDay
		..currentStreaks = currentStreaks
		..longestStreaks = longestStreaks;

		final box = Boxes.getHabit();
		box.add(habit);
		print("data ditambahkan");
	}


	@override
	  void onInit() {
    dateTime ="${_date.day} ${date_util.DateUtils.months[_date.month - 1]} ${_date.year}";
			if (listTime.isNotEmpty) {
        statusSwitchReminders = true;
			}
			print("HABIT CONTROLLER CREATEE reguler");
	    super.onInit();
	  }


	@override
	void dispose() {
		nameHabitController.dispose();
		goalsHabitController.dispose();
		print("HABIT CONTROLLER DISPOSE");
	  super.dispose();
	}

}
