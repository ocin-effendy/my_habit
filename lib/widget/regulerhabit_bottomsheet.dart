import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_habit/controllers/habitcontroller.dart';
import 'package:my_habit/data.dart';
import 'package:my_habit/home_page.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/root.dart';
import 'package:my_habit/widget/dialogicons.dart';
import 'package:provider/provider.dart';

class RegulerHabitBottomSheet extends StatelessWidget {
  RegulerHabitBottomSheet({Key? key, this.habit}) : super(key: key);
	final controller = Get.put(HabitController());
	Habit? habit;

  List<Map<String, dynamic>> dataHabits = [
    {
			"type": "reguler",
			"start": DateTime,
      "title": "Coding",
      "icon": Icons.laptop_mac_rounded,
      "goals": "10",
			"currentGoals": "0",
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
      "status": "active",
      "timeReminders": [TimeOfDay], 
			"completeDay": {
				DateTime: "currentGoals / goals"
			},
			"currentStreaks": 5,
			"longestStreaks": 10,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DataHabitsProvider>(
      builder: (cotext, data, _) => GetBuilder<HabitController>(
				initState: (_){
					if(habit != null){
						Get.find<HabitController>().setToUpdate(habit!, "reguler");
					}else{
						Get.find<HabitController>().clearDatahabit();
						
					}
				},
        builder: (controller) => GestureDetector(
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
                                    fontSize: 36, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Creating a new habit",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                if (controller.nameHabitController.text.isNotEmpty) {
                                  if (data.listDataHabits.length < 3) {
                                    print("masukkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                    carouselController.nextPage(
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.ease);
                                  } else {
                                    carouselController1.nextPage(
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.ease);
                                  }

																	if(habit != null){
																		controller.updateHabit(habit!);
																		print("Data DI UPDATE");

																	}else{
																		controller.addHabit("reguler");
																	}


                                  Provider.of<DataHabitsProvider>(context,
                                          listen: false)
                                      .addDatahabits(DataHabits.bankIcon[random
                                          .nextInt(DataHabits.bankIcon.length)]);
																	//controller.addDatahabits(DataHabits.bankIcon[random.nextInt(DataHabits.bankIcon.length)]);
                                  Navigator.pop(context);
                                  controller.statusSwitchGoalhabits = false;
                                  print(
                                      "===========================================");
                                } else {
																	controller.setStatusInput(false);
                                  //setState(() {
                                  //  statusInput = false;
                                  //});
                                }
                              },
                              icon: ShaderMask(
                                  shaderCallback: (rect) =>
                                      primaryGradient.createShader(rect),
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
                            controller: controller.nameHabitController,
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
                              suffixIcon: controller.statusInput
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
                              decoration: const BoxDecoration(gradient: primaryGradient),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogIcons();
															});

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ShaderMask(
                                  shaderCallback: (rect) =>
                                      primaryGradient.createShader(rect),
                                  child: Icon(
                                    controller.iconHabit,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Goal for Habit',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            Switch(
                                value: controller.statusSwitchGoalhabits,
                                onChanged: (value) {
																	controller.setStatusSwitchGoalHabits(value);
                                 // setState(() {
                                  //  statusSwitchGoalhabits = value;
                                  //});
                                })
                          ],
                        ),
                        Visibility(
                          visible: controller.statusSwitchGoalhabits,
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
                                          primary: controller.descGoals == "times"
                                              ? Colors.lightBlueAccent
                                              : Colors.grey,
                                          shape: const StadiumBorder(),
                                          fixedSize: Size(
                                              MediaQuery.of(context).size.width / 2 -40, 40),
                                        ),
                                        onPressed: () {
																					controller.setDescGoals("times");
                                        },
                                        child: Text(
                                          "of times",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        )),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: controller.descGoals == "minutes"
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
																					controller.setDescGoals("minutes");
                                          //setState(() {
                                           // _descGoals = "minutes";
                                          //});
                                        },
                                        child: Text(
                                          "time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  children: [
                                    TextField(
                                      controller: controller.goalsHabitController,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.lightBlueAccent,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        hintText: controller.descGoals == "times" ? "Ex. 3 times" : "Ex. 10 minutes",
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
                                            gradient: primaryGradient),
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
																controller.setStatusRepeat("daily");

                                //setState(() {
                                //  statusRepeat = "daily";
                                //});
                              } else if (index == 1) {
																controller.setStatusRepeat("weekly");
                               // setState(() {
                               //   statusRepeat = "weekly";
                               // });
                              } else {
																controller.setStatusRepeat("monthly");
                               // setState(() {
                               //   statusRepeat = "monthly";
                                //});
                              }
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
                              gradient: primaryGradient,
                            ),
                            tabs: [
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(21, 21, 70, 1),
                                child: Text(
                                  "Daily",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(21, 21, 70, 1),
                                child: Text(
                                  "Weekly",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(21, 21, 70, 1),
                                child: Text(
                                  "Monthly",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: controller.listDays
                                              .map((key, value) => MapEntry(
                                                    key,
                                                    Container(
                                                        width: 43,
                                                        height: 43,
                                                        decoration: const BoxDecoration(
                                                            gradient:
                                                                primaryGradient,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            14))),
                                                        child: ElevatedButton(
                                                            onPressed: () {
																															controller.setListDays(key, !value);
																															if (controller.listDays.containsValue(false)) {
																																	controller.setStatusSwicthRepeatEveriday(false);
                                                                } else {
																																	controller.setStatusSwicthRepeatEveriday(true);
                                                                }


																																// tanpa update 

                                                              //setState(() {
                                                                //listDays[key] =!value;

                                                               // if (listDays.containsValue(false)) {
                                                               //   statusSwitchRepeatEveryday =false;
                                                               // } else {
                                                               //   statusSwitchRepeatEveryday =
                                                               //       true;
                                                               // }
                                                               // week = month = 1;
                                                              //});
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
                                                                    primary: value
                                                                        ? Colors
                                                                            .transparent
                                                                        : Colors
                                                                            .grey,
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
                                              style: Theme.of(context).textTheme .headline1,
                                            ),
                                            Switch(
                                                value: controller.statusSwitchRepeatEveryday,
                                                onChanged: (value) {
																									controller.setStatusSwicthRepeatEveriday(value);
                                                  //setState(() {
                                                    //statusSwitchRepeatEveryday = value;
                                                  if (controller.statusSwitchRepeatEveryday) {
																										controller.setValueStatusSwitchRepeatEveriday(true, 'day', 1);
                                                  } else {
																										controller.setValueStatusSwitchRepeatEveriday(false, 'day', 1);
																									}
                                                  //});
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
                                          "${controller.week} times a week",
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
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              for (int i = 1; i < 7; i++)
                                                Container(
                                                    width: 43,
                                                    height: 43,
                                                    decoration:
                                                        const BoxDecoration(
                                                            gradient: primaryGradient,
                                                            borderRadius:
                                                                BorderRadius.all(Radius.circular( 14))),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          //setState(() {
                                                            controller.setValueStatusSwitchRepeatEveriday(false, 'week', i);
																														controller.setStatusSwicthRepeatEveriday(false);
                                                            
                                                          //});
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
                                                                primary: controller.week == i
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
                                        "${controller.month} times a month",
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
                                                  gradient: primaryGradient,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(14))),
                                              child: ElevatedButton(
                                                  onPressed: () {
																											controller.setValueStatusSwitchRepeatEveriday(false, 'month', i);
																											controller.setStatusSwicthRepeatEveriday(false);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape:RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(14.0),
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      primary: controller.month == i
                                                          ? Colors.transparent
                                                          : Colors.grey,
                                                      shadowColor:
                                                          Colors.transparent),
                                                  child: Text(
                                                    i.toString(),
                                                    style: TextStyle(fontSize: 14),
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
                              value: controller.statusSwitchReminders,
                              onChanged: (value) {
                                //setState(() {
                                controller.setStatusSwicthReminder(value);
																if(!controller.statusSwitchReminders){
																	controller.timeReminders.clear();
																}
                               // });
                              })
                        ],
                      ),
                      Visibility(
                        visible: controller.statusSwitchReminders,
                        child: Column(
                          children: [
                            for (int i = 0; i < controller.timeReminders.length; i++)
                              ListTile(
                                leading: SizedBox(
                                  height: double.infinity,
                                  child: Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                title: Text(
                                  //controller.timeReminders[i].toString().split("(")[1].split(")")[0],
                                  controller.timeReminders[i],
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                trailing: SizedBox(
                                    height: double.infinity,
                                    child: IconButton(
                                      onPressed: () {
																				controller.deleteListTime(i);
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                      ),
                                    )),
                                minLeadingWidth: 0,
                              ),
                            ListTile(
                              onTap: () {
                                controller.selectTime(context);
                              },
                              leading: SizedBox(
                                height: double.infinity,
                                child: Icon(
                                  Icons.add_circle_rounded,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              title: Text(
                                "Add reminder time",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              minLeadingWidth: 0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
