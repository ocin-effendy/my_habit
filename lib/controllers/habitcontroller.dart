import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/models/completeday.dart';
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
  List<String> timeReminders = []; // timeReminders
	List completeDay = []; // completeDay
	int currentStreaks = 0; // currentStreaks
	int longestStreaks = 0; // longestStreaks
  


  late String dateTime;
  late String time;
  List<String> listTime = [];


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
		timeReminders.removeAt(i);
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
			timeReminders.add(time);
      //listTime.add(time);
			update();
    }
  }



	// Function for oneTask input date
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

	// Function to clear data habit for new data Habit
	void clearDatahabit(){
		statusInput = true;
		statusSwitchGoalhabits = false;
		statusSwitchRepeatEveryday = false;
		statusSwitchReminders = false;

		nameHabitController.clear();
		iconHabit = Icons.star_rate_rounded;
		descGoals = "times";
		goalsHabitController.clear();
		statusRepeat = "daily";
		listDays = { // day
			"Su": true,
			"Mo": false,
			"Tu": false,
			"We": false,
			"Th": false,
			"Fr": false,
			"Sa": false,
		};
		week = 1;
		month = 1;
		status = "active";
		timeReminders = [];
	}

	// Function to put data in temp variabel data habit
	void setToUpdate(Habit habit, String type){
		if(habit.type == "reguler"){
			if(habit.goals != 0){
				statusSwitchGoalhabits = true;
			}

			if(habit.timeReminders.isNotEmpty){
				statusSwitchReminders = true;
			}

			nameHabitController.text = habit.title;
			iconHabit = IconData(habit.icon, fontFamily: "MaterialIcons");
			descGoals = habit.descGoals;
			goalsHabitController.text = habit.goals.toString();
			statusRepeat = habit.statusRepeat;
			listDays = habit.day;
			week = habit.week;
			month = habit.month;
			status = habit.status;
			timeReminders = habit.timeReminders;
			update();
		}
		// for Onetask
		//else {}

	}


	// Function add data to local with hive
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



	void updateHabit(Habit habit){
		if(habit.type == "reguler"){
			habit.title = nameHabitController.text;
			habit.icon = iconHabit.codePoint;
			habit.descGoals = descGoals;
			habit.goals = goalsHabitController.text == "" ? 0 : int.parse(goalsHabitController.text);
			habit.statusRepeat = statusRepeat;
			habit.day= listDays;
			habit.week = week;
			habit.month = month;
			habit.status = status;
			habit.timeReminders = timeReminders;
		}
		habit.save();

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
