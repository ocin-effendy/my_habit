import 'package:flutter/material.dart';
import 'package:my_habit/data.dart';
import 'package:my_habit/home_page.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/utils/date_utils.dart' as date_util;
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class OneTaskBottomSheet extends StatefulWidget {
  @override
  State<OneTaskBottomSheet> createState() => _OneTaskBottomSheetState();
}

class _OneTaskBottomSheetState extends State<OneTaskBottomSheet> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  final _nameOneTaskController = TextEditingController(); //title
  final bankIcons = DataHabits.bankIcon;
  IconData _iconHabit = Icons.star_rate_rounded; //IconHabit
  bool statusInput = true;
  bool statusSwitchReminders = false;
  late String dateTime;
  late String time;

  List<String> listTime = ['14:50'];

  @override
  void initState() {
    super.initState();
    dateTime ="${_date.day} ${date_util.DateUtils.months[_date.month - 1]} ${_date.year}";
		if(listTime.isNotEmpty){
			setState(() {
				statusSwitchReminders = true;
			});
		}
  }

  void _selectTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        time = _time.toString().split("(")[1].split(")")[0];
				//Provider.of<DataHabitsProvider>(context, listen: false).addTimeReminder(time);
				listTime.add(time);
      });
    }
  }

  void _getDatePicker() async {
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
                colorScheme: const ColorScheme.dark(
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
      setState(() {
        _date = selectedDate;
        dateTime =
            "${_date.day} ${date_util.DateUtils.months[_date.month - 1]} ${_date.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataHabitsProvider>(
			builder: (context, data, _) => Container(
        height: MediaQuery.of(context).size.height * 0.97,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "One Task",
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Creating a new One Task",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
											Navigator.pop(context);
										},
                      icon: ShaderMask(
                          shaderCallback: (rect) =>
                              primaryGradient.createShader(rect),
                          child: const Icon(
                            Icons.done_all_rounded,
                            color: Colors.white,
                          ))),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  TextField(
                    controller: _nameOneTaskController,

                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Name your One Task",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 15.0,
                      ),
                      suffixIcon: statusInput
                          ? null
                          : const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    child: Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(gradient: primaryGradient),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromRGBO(21, 21, 70, 1),
                          title: Text("Choose Icon"),
                          titleTextStyle:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          content: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                for (int i = 0; i < bankIcons.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ShaderMask(
                                        shaderCallback: (rect) =>
                                            primaryGradient.createShader(rect),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _iconHabit = bankIcons[i];
                                              Navigator.pop(context);
                                            });
                                          },
                                          icon: Icon(
                                            bankIcons[i],
                                            size: 36,
                                          ),
                                          color: Colors.white,
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShaderMask(
                          shaderCallback: (rect) =>
                              primaryGradient.createShader(rect),
                          child: Icon(
                            _iconHabit,
                            color: Colors.white,
                            size: 34,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Change Icon",
                        style: Theme.of(context).textTheme.headline1,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _getDatePicker();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    children: [
                      ShaderMask(
                          shaderCallback: (rect) =>
                              primaryGradient.createShader(rect),
                          child: Icon(
                            Icons.event_rounded,
                            color: Colors.white,
                            size: 34,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        dateTime,
                        style: Theme.of(context).textTheme.headline1,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get Reminders',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Switch(
                      value: statusSwitchReminders,
                      onChanged: (value) {
                        setState(() {
                          statusSwitchReminders = value;
												if(!statusSwitchReminders){
													listTime.clear();
												}
                        });
                      })
                ],
              ),
              Visibility(
                visible: statusSwitchReminders,
                child: Column(
                  children: [
                    for (int i = 0; i < listTime.length; i++)
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.access_time_rounded,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        title: Text(
                          listTime[i],
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
											trailing: SizedBox(
												height: double.infinity, 
												child: IconButton(
													onPressed:(){
														setState(() {
															listTime.removeAt(i);
														});
													}, 
													icon:Icon(Icons.close_rounded, color: Colors.white,),)),
                        minLeadingWidth: 0,
                      ),
                    ListTile(
										onTap: (){
											_selectTime();
										},
                      leading: Container(
                        height: double.infinity,
                        child: Icon(
                          Icons.add_circle_rounded,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      title: Text(
                        "Add reminder time",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      minLeadingWidth: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
