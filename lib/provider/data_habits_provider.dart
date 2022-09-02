import 'package:flutter/material.dart';

class DataHabitsProvider extends ChangeNotifier{
	
	List<IconData> _dataHabits = [];
	List<String> _listTimeReminder = [];

	void addDatahabits(IconData data){
		_dataHabits.add(data);
		notifyListeners();
	}

	void addTimeReminder(String time){
		_listTimeReminder.add(time);
		notifyListeners();
	}

	List<IconData> get listDataHabits => _dataHabits;
	List<String> get listTimeReminder => _listTimeReminder;

}
