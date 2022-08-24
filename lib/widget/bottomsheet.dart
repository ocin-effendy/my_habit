import 'package:flutter/material.dart';
import 'package:my_habit/data.dart';
import 'package:my_habit/home_page.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/root.dart';
import 'package:provider/provider.dart';

class GetBottomSheet extends StatefulWidget {
  @override
  State<GetBottomSheet> createState() => _GetBottomSheetState();
}

class _GetBottomSheetState extends State<GetBottomSheet> {
  final bankIcons = DataHabits.bankIcon;
  final _nameHabitController = TextEditingController(); //title
  final _goalsHabitController = TextEditingController(); // goals
  bool statusInput = true;
  bool statusSwitchGoalhabits = false;
  bool statusSwitchRepeatEveryday = false;
  bool statusSwitchReminders = false;
  IconData _iconHabit = Icons.star_rate_rounded; //IconHabit
  String _descGoals = 'times'; //descGoals
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

  List<Map<String, dynamic>> dataHabits = [
    {
      "title": "Coding",
      "icon": Icons.laptop_mac_rounded,
      "goals": "10",
      "descGoals": "minutes",
      "statusRepeat": "daily",
      "day": {
				"Monday": true,
				"Sunday": false,
				"Tuesday": false,
				"Wednesday": false,
				"Thursday": false,
				"Friday": false,
				"Saturday": false,
			},
      "week": "",
      "month": "",
      "statusHabits": "active",
      "timeReminders": "Do anytime"
    }
  ];


  final iconsGradientColors = List<Color>.from(
      [Colors.yellowAccent, Colors.greenAccent, Colors.lightBlueAccent]);

  @override
  void dispose() {
    super.dispose();
    _nameHabitController.dispose();
    _goalsHabitController.dispose();
  }

  @override
  Widget build(BuildContext context) {
			    return Consumer<DataHabitsProvider>(
      builder: (cotext, data, _) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.97,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: DefaultTabController(
                length: 3,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Regular Habit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Creating a new habit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              if (_nameHabitController.text.isNotEmpty) {

																dataHabits.add(
																		{
																			"title": _nameHabitController.text,
																			"icon": _iconHabit,
																			"goals": _goalsHabitController.text,
																			"descGoals": _descGoals,
																			"statusRepeat": statusRepeat,
																			"day": listDays,
																			"week": statusRepeat != "Weekly" ? "" : week.toString(),
																			"month": statusRepeat != "Montly" ? "" : month.toString(),
																			"statusHabits": "active",
																			"timeReminders": "Do anytime",
																			"do": 0
																		}

																);


                                if (data.listDataHabits.length < 3) {
                                  carouselController.nextPage(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.ease);
                                } else {
                                  carouselController1.nextPage(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.ease);
                                }

                                Provider.of<DataHabitsProvider>(context,
                                        listen: false)
                                    .addDatahabits(DataHabits.bankIcon[random
                                        .nextInt(DataHabits.bankIcon.length)]);
                                Navigator.pop(context);
                                statusSwitchGoalhabits = false;
																print("===========================================");
																print(dataHabits[1]);
                              } else {
                                setState(() {
                                  statusInput = false;
                                });
                              }
                            },
                            icon: ShaderMask(
                                shaderCallback: (rect) => LinearGradient(
                                        colors: iconsGradientColors,
                                        begin: Alignment.topLeft)
                                    .createShader(rect),
                                child: const Icon(
                                  Icons.done_all_rounded,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        TextField(
                          controller: _nameHabitController,
                          cursorColor: Colors.lightBlueAccent,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "Name your habit",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            suffixIcon: statusInput
                                ? null
                                : Icon(
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
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.yellowAccent,
                                  Colors.greenAccent,
                                  Colors.lightBlueAccent
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Color.fromRGBO(21, 21, 70, 1),
                                      title: Text("Choose Icon"),
                                      titleTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      content: SingleChildScrollView(
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i < bankIcons.length;
                                                i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                                colors:
                                                                    iconsGradientColors,
                                                                begin: Alignment
                                                                    .topLeft)
                                                            .createShader(rect),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _iconHabit =
                                                              bankIcons[i];
                                                          Navigator.pop(
                                                              context);
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
                            icon: ShaderMask(
                                shaderCallback: (rect) => LinearGradient(
                                        colors: iconsGradientColors,
                                        begin: Alignment.topLeft)
                                    .createShader(rect),
                                child: Icon(
                                  _iconHabit,
                                  color: Colors.white,
                                  size: 34,
                                ))),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Change Icon",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Goal for Habit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Switch(
                              value: statusSwitchGoalhabits,
                              onChanged: (value) {
                                setState(() {
                                  statusSwitchGoalhabits = value;
                                });
                              })
                        ],
                      ),
                      Visibility(
                        visible: statusSwitchGoalhabits,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _descGoals == "times"
                                            ? Colors.lightBlueAccent
                                            : Colors.grey,
                                        shape: const StadiumBorder(),
                                        fixedSize: Size(
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                40,
                                            40),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _descGoals = "times";
                                        });
                                      },
                                      child: Text(
                                        "of times",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _descGoals == "minutes"
                                            ? Colors.lightBlueAccent
                                            : Colors.grey,
                                        shape: const StadiumBorder(),
                                        fixedSize: Size(
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                40,
                                            40),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _descGoals = "minutes";
                                        });
                                      },
                                      child: Text(
                                        "time",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  TextField(
                                    controller: _goalsHabitController,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.lightBlueAccent,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      hintText: "Input here",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 15.0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 1,
                                    child: Container(
                                      height: 1.5,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.yellowAccent,
                                            Colors.greenAccent,
                                            Colors.lightBlueAccent
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        TabBar(
                          // ============= for get statusRepeat
                          onTap: (index) {
                            if (index == 0) {
                              setState(() {
                                statusRepeat = "daily";
                              });
                            } else if (index == 1) {
                              setState(() {
                                statusRepeat = "weekly";
                              });
                            } else {
                              setState(() {
                                statusRepeat = "monthly";
                              });
                            }
                            print("ini index : $index");
                          },
                          indicatorPadding: const EdgeInsets.all(0.0),
                          indicatorWeight: 3.0,
                          labelPadding:
                              const EdgeInsets.only(left: 0.0, right: 0.0),
                          indicator: const ShapeDecoration(
                              shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 0.0,
                                      style: BorderStyle.solid)),
                              gradient: LinearGradient(colors: [
                                Color(0xff0081ff),
                                Color(0xff01ff80)
                              ])),
                          tabs: [
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              color: const Color.fromRGBO(21, 21, 70, 1),
                              child: const Text(
                                "Daily",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              color: const Color.fromRGBO(21, 21, 70, 1),
                              child: const Text(
                                "Weekly",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              color: const Color.fromRGBO(21, 21, 70, 1),
                              child: const Text(
                                "Monthly",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160,
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "During these day",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: listDays.map((key, value) => MapEntry(
                                                  key,
                                                  Container(
                                                      width: 43,
                                                      height: 43,
                                                      decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              colors: [
                                                                Colors
                                                                    .yellowAccent,
                                                                Colors
                                                                    .greenAccent,
                                                                Colors
                                                                    .lightBlueAccent
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          14))),
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              listDays[key] =!value;
																															if(!listDays.containsValue(true)){
																																listDays[key] =!value;

																															}
                                                              if (listDays.containsValue(false)) {
                                                                statusSwitchRepeatEveryday = false;
                                                              }else{
																																statusSwitchRepeatEveryday = true;
																															}
                                                              week = month = 1;
                                                            });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14.0),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  primary: value ? Colors.transparent: Colors.grey,
                                                                  shadowColor:
                                                                      Colors
                                                                          .transparent),
                                                          child: Text(
                                                            key,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ))),
                                                ))
                                            .values
                                            .toList()),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Every Days",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Switch(
                                              value: statusSwitchRepeatEveryday,
                                              onChanged: (value) {
                                                setState(() {
                                                  statusSwitchRepeatEveryday =
                                                      value;
                                                  if (statusSwitchRepeatEveryday) {
                                                    listDays['Su'] = listDays[
                                                        'Mo'] = listDays[
                                                            'Tu'] =
                                                        listDays['We'] =
                                                            listDays[
                                                                'Th'] = listDays[
                                                                    'Fr'] =
                                                                listDays['Sa'] =
                                                                    true;
                                                  } else {
                                                    listDays['Su'] = true;
                                                    listDays['Mo'] = listDays[
                                                        'Tu'] = listDays[
                                                            'We'] =
                                                        listDays['Th'] =
                                                            listDays['Fr'] =
                                                                listDays['Sa'] =
                                                                    false;
                                                  }
                                                  week = month = 1;
                                                });
                                              })
                                        ]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$week times a week",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            for (int i = 1; i < 7; i++)
                                              Container(
                                                  width: 43,
                                                  height: 43,
                                                  decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          colors: [
                                                            Colors.yellowAccent,
                                                            Colors.greenAccent,
                                                            Colors
                                                                .lightBlueAccent
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14))),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          week = i;
                                                          month = 1;
                                                          listDays['Su'] = true;
                                                          listDays['Mo'] = listDays[
                                                              'Tu'] = listDays[
                                                                  'We'] =
                                                              listDays[
                                                                  'Th'] = listDays[
                                                                      'Fr'] =
                                                                  listDays[
                                                                          'Sa'] =
                                                                      false;
                                                        });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14.0),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              primary: week == i
                                                                  ? Colors
                                                                      .transparent
                                                                  : Colors.grey,
                                                              shadowColor: Colors
                                                                  .transparent),
                                                      child: Text(
                                                        i.toString(),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ))),
                                          ]),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$month times a month",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(children: [
                                      for (int i = 1; i < 4; i++)
                                        Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            width: 43,
                                            height: 43,
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    colors: [
                                                      Colors.yellowAccent,
                                                      Colors.greenAccent,
                                                      Colors.lightBlueAccent
                                                    ]),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    month = i;
                                                    week = 1;
                                                    listDays['Su'] = true;
                                                    listDays['Mo'] = listDays['Tu'] = listDays['We'] =listDays['Th'] =listDays['Fr'] =listDays['Sa'] =false;
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.0),
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    primary: month == i
                                                        ? Colors.transparent
                                                        : Colors.grey,
                                                    shadowColor:
                                                        Colors.transparent),
                                                child: Text(
                                                  i.toString(),
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ))),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Get Reminders',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Switch(
                            value: statusSwitchReminders,
                            onChanged: (value) {
                              setState(() {
                                statusSwitchReminders = value;
                              });
                            })
                      ],
                    )
                  ],
                ))),
      ),
    );
  }
}
