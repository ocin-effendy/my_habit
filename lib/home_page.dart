import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_habit/controllers/animationcontroller.dart';
import 'package:my_habit/controllers/datecontroller.dart';
import 'package:my_habit/data.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/models/habit.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/root.dart';
import 'package:my_habit/widget/boxes.dart';
import 'package:my_habit/widget/dialoghabit.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/date_utils.dart' as date_util;
import 'dart:math' as math;

CarouselController carouselController = CarouselController();
CarouselController carouselController1 = CarouselController();
DateTime currentDateTime = DateTime.now();

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int count = 3;
	final dateController = Get.put(DateController());
	


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            ValueListenableBuilder<Box<Habit>>(
							valueListenable: Boxes.getHabit().listenable(),
							builder: (context, box, _){
							final habit = box.values.toList().cast<Habit>();
							print("======= cok ===========");
						//	print(habit[0].day);
              return  GetBuilder<DateController>(
								initState: (_){
									print("============= complate day =============");
									print(habit[0].completeDay);
									
								},
                builder: (x) => Container(
                  color: const Color.fromRGBO(21, 21, 71, 1),
                  child: Transform.translate(
                    offset: const Offset(-35, -35),
                    child: Transform.rotate(
                      angle: -math.pi / 15,
                      child: Transform(
                        transform: Matrix4.diagonal3Values(1.3, 1, 1),
                        child: Column(
                          children: [
                            getCarousel(),
                            getCarousel(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: CarouselSlider.builder(
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    viewportFraction: 0.23,
                                    height: 99,
                                    autoPlay: false,
                                  ),
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context, int itemIndex,int pageViewIndex) {
																			Get.find<AnimationControllerHabit>().getAnimation(math.Random().nextInt(5));
                                        return GestureDetector(
                                          onTap: () {
																					if(itemIndex < habit.length && habit[itemIndex].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex].start.day){
																						showDialog(
																						context: context, 
																						builder: (context){
																							// push data habit by index and check this habit for today or not
																							return DialogHabit(habit: habit[itemIndex],today: dateController.dateToday.day == dateController.currentDateTime.day,); 
																						}
																					);

																				}
                                          },
                                          child: GetBuilder<AnimationControllerHabit>(
																				init: AnimationControllerHabit(),
                                            builder: (controller) => FadeTransition(
                                              opacity: controller.animation,
                                              child: Container(
                                                  width: 78,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(15)),
                                                    gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        colors: [
                                                          Color.fromRGBO(
                                                              random.nextInt(256),
                                                              random.nextInt(256),
                                                              random.nextInt(257),
                                                              itemIndex < habit.length && habit[itemIndex].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex].start.day ? 1: .35
                                                              //habit.isNotEmpty &&itemIndex < habit.length? 1: .35
																													),
                                                          Color.fromRGBO(
                                                              random.nextInt(256),
                                                              random.nextInt(256),
                                                              random.nextInt(256),
                                                              itemIndex < habit.length && habit[itemIndex].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex].start.day ? 1: .35
                                                              //itemIndex < habit.length && habit[itemIndex].day[dateController.today]! ? 1: .35
                                                              //habit.isNotEmpty &&itemIndex < habit.length? 1: .35
                                                              //data.listDataHabits.isNotEmpty &&itemIndex < data.listDataHabits.length? 1: .35
																													),
                                                        ]),
                                                  ),
																									child: Stack(
																										children: [
																								Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(itemIndex < habit.length && habit[itemIndex].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex].start.day ? IconData(habit[itemIndex].icon, fontFamily: "MaterialIcons")
                                                      : DataHabits.bankIcon[random.nextInt(DataHabits.bankIcon.length)])),
																								itemIndex < habit.length && habit[itemIndex].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex].start.day
                                                  ? Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(bottom: 3, right: 5),
                                                        child: Text(
																												// if today return status, if last return done, if future return active
                                                          dateController.dateToday.day == dateController.currentDateTime.day ? habit[itemIndex].status : dateController.dateToday.day > dateController.currentDateTime.day ? "done" : "active",
																												//'active',
                                                          style: TextStyle(color: darkBlueOne,
                                                              fontSize: 12,
                                                              fontWeight:FontWeight.w600,
                                                              letterSpacing: -.5),
                                                        ),
                                                      ))
                                                  : const Text(''),
                                            ])),


                                              ),
                                          ),
                                        );
                                      }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: CarouselSlider.builder(
                                carouselController: carouselController1,
                                options: CarouselOptions(
                                    pageSnapping: true,
                                    viewportFraction: 0.23,
                                    height: 99,
                                    autoPlay: false,
                                    autoPlayAnimationDuration:const Duration(seconds: 3),
                                    autoPlayInterval: const Duration(seconds: 4)),
                                itemCount: count,
                                itemBuilder: (BuildContext context, int itemIndex,int pageViewIndex) =>
                                    Consumer<DataHabitsProvider>(
                                        builder: (context, data, _) {
																				Get.find<AnimationControllerHabit>().getAnimation(math.Random().nextInt(5));
                                  return GestureDetector(
                                    onTap: () {
																		if (itemIndex + count < habit.length && habit[itemIndex + count].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex + count].start.day) {
                                        //Provider.of<PopUpProvider>(context,listen: false).setStatus(true);
																		showDialog(
																			context: context, 
																			builder: (context){
																				return DialogHabit(habit: habit[itemIndex + count],today: dateController.dateToday.day == dateController.currentDateTime.day,); 
																			}
																		);
                                      }
                                    },
                                    child: GetBuilder<AnimationControllerHabit>(
																	init: AnimationControllerHabit(),
                                      builder: (controller)=> FadeTransition(
                                        opacity: controller.animation,
                                        child: Container(
                                            width: 78,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(15)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        itemIndex + count < habit.length && habit[itemIndex + count].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex + count].start.day ? 1: .35),
                                                    Color.fromRGBO(
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        itemIndex + count < habit.length && habit[itemIndex + count].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex + count].start.day ? 1: .35),
                                                        //itemIndex + count < habit.length	&& habit[itemIndex + count].day[dateController.today]!? 1 : .35),
                                                  ]),
                                            ),
                                            child: Stack(children: [
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(itemIndex + count < habit.length && habit[itemIndex + count].day[dateController.today]! ? IconData(habit[itemIndex + count].icon, fontFamily: "MaterialIcons")
                                                      : DataHabits.bankIcon[random.nextInt(DataHabits .bankIcon.length)])),
                                              itemIndex + count < habit.length && habit[itemIndex + count].day[dateController.today]! && dateController.currentDateTime.day >= habit[itemIndex + count].start.day
                                                  ? Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom: 3, right: 5),
                                                        child: Text(
																												// if today return status, if last return done, if future return active
                                                          dateController.dateToday.day == dateController.currentDateTime.day ? habit[itemIndex + count].status : dateController.dateToday.day > dateController.currentDateTime.day ? "done" : "active",
                                                         // habit[itemIndex + count].status,
																												//'active',
                                                          style: TextStyle(
																												color: darkBlueOne,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              letterSpacing: -.5),
                                                        ),
                                                      ))
                                                  : const Text(''),
                                            ])),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            getCarousel(),
                            getCarousel(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
							}
            ),
            GetBuilder<DateController>(
              builder: (c) => Align(
                alignment: Alignment.bottomCenter,
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .42,
                  decoration: const BoxDecoration(
                      color: darkBlueOne,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
												TextButton(
													onPressed: (){
														dateController.setCurrentDateTime(DateTime.now());
													}, 
													child: Text(
                            "Today",
                            style: TextStyle(
                                color: dateController.dateToday.day == dateController.currentDateTime.day ? Colors.white : Colors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
												),
                            Row(
                            children: [
                              IconButton(
															onPressed: (){
																dateController.setCurrentDateTime(DateTime(dateController.currentDateTime.year,dateController.currentDateTime.month, dateController.currentDateTime.day - 1 ));
															},
                                icon: const Icon(
																Icons.arrow_back_ios_rounded,
																color: Colors.white,
																size: 18
                                ),
                              ),
                              SizedBox(width: 20),
														IconButton(
															onPressed: (){
																dateController.setCurrentDateTime(DateTime(dateController.currentDateTime.year,dateController.currentDateTime.month, dateController.currentDateTime.day + 1 ));
															},
                                icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
																color: Colors.white,
																size: 18
                                ),
                              ),
												 ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //sgetDatePicker(),
									  SizedBox(
                          height: 60,
                          child: ListView.builder(
                              controller: dateController.scrollControllerDateInline,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: dateController.currentMonthList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
																	dateController.setCurrentDateTime(dateController.currentMonthList[index]);

                                    //setState(() {
                                     // currentDateTime = currentMonthList[index];
                                   // });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: dateController.currentMonthList[index].day !=
                                                dateController.currentDateTime.day
                                            ? Colors.transparent
                                            : Colors.lightBlueAccent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          date_util.DateUtils.weekdays[dateController.currentMonthList[index].weekday - 1],
                                          style: TextStyle(
                                              color: dateController.currentMonthList[index].day !=
                                                      dateController.currentDateTime.day
                                                  ? Colors.white54
                                                  : Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          dateController.currentMonthList[index].day.toString(),
                                          style: TextStyle(
                                              color: dateController.currentMonthList[index].day !=
                                                      dateController.currentDateTime.day
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        color: Colors.white54,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "All habits:",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "two task",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Work Habits",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                    // ini getpopuphabits
     //               getPopUpHabit(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .18,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(1),
                        Colors.black.withOpacity(.8),
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(0),
                      ]),
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget getCarousel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: CarouselSlider(
          options: CarouselOptions(
              pageSnapping: true,
              viewportFraction: 0.23,
              height: 99,
              autoPlay: false,
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayInterval: const Duration(seconds: 4)),
          items: [1, 2, 3, 4, 5, 6].map((e) {
            return Builder(
              builder: (BuildContext context) {
								Get.find<AnimationControllerHabit>().getAnimation(math.Random().nextInt(5));
							//	animationControllerHabit.getAnimation(math.Random().nextInt(6));
                return GetBuilder<AnimationControllerHabit>(
									init: AnimationControllerHabit(),
                  builder: (controller)=>FadeTransition(
                    opacity: controller.animation,
                    child: Container(
                      width: 78,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        gradient:
                            LinearGradient(begin: Alignment.topLeft, colors: [
                          Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                              random.nextInt(256), .35),
                          Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                              random.nextInt(256), .35),
                        ]),
                      ),
                      child: Center(
                          child: Icon(DataHabits.bankIcon[
                              random.nextInt(DataHabits.bankIcon.length)])),
                    ),
                  ),
                );
              },
            );
          }).toList()),
    );
  }
 }
