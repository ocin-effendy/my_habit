import 'package:flutter/material.dart';

class DataHabitsProvider extends ChangeNotifier{
	
	List<IconData> dataHabits = [];

	void addDatahabits(IconData data){
		dataHabits.add(data);
		notifyListeners();
	}

	List<IconData> get listDataHabits => dataHabits;

}
