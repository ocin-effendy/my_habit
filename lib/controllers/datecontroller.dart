import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_habit/widget/boxes.dart';
import '/utils/date_utils.dart' as date_util;

class DateController extends GetxController{
	DateTime dateToday = DateTime.now();
	DateTime currentDateTime = DateTime.now();
	//DateTime dateToday = DateTime(22, 9, 15);
	//DateTime currentDateTime = DateTime(22, 9, 15);
  List<DateTime> currentMonthList = List.empty();
  late ScrollController scrollControllerDateInline;
	int positionWeekDays = 0;
	String today = "";

	void setCurrentDateTime(DateTime time){
		currentDateTime = time;
		today = date_util.DateUtils.weekdays[currentDateTime.weekday - 1];
		update();
	}

	
	@override
	  void onInit() {
			today = date_util.DateUtils.weekdays[currentDateTime.weekday - 1];

			final box = Boxes.getHabit();
			box.toMap().forEach((key, value) { 
				if(value.day[today]! && currentDateTime.day >= value.start.day || value.start.day == currentDateTime.day){

					print(value.title);
				}

			});


			print("+++++++++++++++++++++++++++++++++");
			print(today);
			print("+++++++++++++++++++++++++++++++++");
			currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
			currentMonthList.sort((a, b) => a.day.compareTo(b.day));
			currentMonthList = currentMonthList.toSet().toList();
			scrollControllerDateInline = ScrollController(initialScrollOffset: 40.0 * currentDateTime.day);
			positionWeekDays = date_util.DateUtils.weekdays.indexOf(date_util.DateUtils.weekdays[currentMonthList[0].weekday]);
			print("DATE CONTROLLER CRESTE");
	    super.onInit();
	  }

	@override
	  void dispose() { 
			scrollControllerDateInline.dispose();
	    super.dispose();
	  }




}
