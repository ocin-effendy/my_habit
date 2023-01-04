import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_habit/controllers/animationcontroller.dart';
import 'package:my_habit/controllers/datecontroller.dart';
import 'package:my_habit/controllers/habitcontroller.dart';
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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int count = 5;
  final dateController = Get.find<DateController>();
  final habitController = Get.find<HabitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          ValueListenableBuilder<Box<Habit>>(
              valueListenable: Boxes.getHabit().listenable(),
              builder: (context, box, _) {
                final habit = box.values.toList().cast<Habit>();

                return GetBuilder<DateController>(
                  initState: (_) {
                    dateController.setWeekInMonth();
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: CarouselSlider.builder(
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      viewportFraction: 0.21,
                                      height: 99,
                                      autoPlay: false,
                                    ),
                                    itemCount: count,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      Get.find<AnimationControllerHabit>()
                                          .getAnimation(
                                              math.Random().nextInt(3));
                                      // if daily return when daily items is true and current habit >= start habit
                                      // if onetask return when start habit == current habit
                                      // CHECK REGULER DAILY
                                      bool check1 = itemIndex < habit.length &&
                                          habit[itemIndex]
                                              .day[dateController.today]! &&
                                          dateController.currentDateTime.day >=
                                              habit[itemIndex].start.day;
                                      bool check2 = itemIndex < habit.length &&
                                          habit[itemIndex]
                                              .day[dateController.today]! &&
                                          dateController.currentDateTime.month >
                                              habit[itemIndex].start.month;
                                      bool check3 = itemIndex < habit.length &&
                                          habit[itemIndex]
                                              .day[dateController.today]! &&
                                          dateController.currentDateTime.year >
                                              habit[itemIndex].start.year;

                                      // CHECK REGULER WEEKLY
                                      bool check6 = itemIndex < habit.length &&
                                          habit[itemIndex].statusRepeat ==
                                              "weekly" &&
                                          dateController.currentDateTime.day >=
                                              habit[itemIndex].start.day &&
                                          habitController
                                              .checkWeekly(habit[itemIndex]);
                                      bool check7 = itemIndex < habit.length &&
                                          habit[itemIndex].statusRepeat ==
                                              "weekly" &&
                                          dateController.currentDateTime.month >
                                              habit[itemIndex].start.month &&
                                          habitController
                                              .checkWeekly(habit[itemIndex]);
                                      bool check8 = itemIndex < habit.length &&
                                          habit[itemIndex].statusRepeat ==
                                              "weekly" &&
                                          dateController.currentDateTime.year >
                                              habit[itemIndex].start.year &&
                                          habitController
                                              .checkWeekly(habit[itemIndex]);

                                      // CHECK REGULER MONTHLY
                                      bool check9 = itemIndex < habit.length &&
                                          habit[itemIndex].statusRepeat ==
                                              "monthly" &&
                                          dateController.currentDateTime.day >=
                                              habit[itemIndex].start.day &&
                                          habitController
                                              .checkMonthly(habit[itemIndex]);
                                      bool check10 = itemIndex < habit.length &&
                                          habit[itemIndex].statusRepeat ==
                                              "monthly" &&
                                          dateController.currentDateTime.month >
                                              habit[itemIndex].start.month &&
                                          habitController
                                              .checkMonthly(habit[itemIndex]);
                                      bool check11 = itemIndex < habit.length &&
                                          habit[itemIndex].statusRepeat ==
                                              "monthly" &&
                                          dateController.currentDateTime.year >
                                              habit[itemIndex].start.year &&
                                          habitController
                                              .checkMonthly(habit[itemIndex]);

                                      // CHECK ONETASK
                                      // check oneTask when not done yet (future or now)
                                      bool check4 = itemIndex < habit.length &&
                                          habit[itemIndex].start.day ==
                                              dateController
                                                  .currentDateTime.day &&
                                          habit[itemIndex].type == "oneTask";
                                      // check oneTask in last or have done (last)
                                      bool check5 = itemIndex < habit.length &&
                                          habit[itemIndex].type == "oneTask" &&
                                          dateController.currentDateTime.day <
                                              habit[itemIndex].start.day &&
                                          habitController
                                              .checkCompleteDayOneTask(
                                                  habit[itemIndex]);

                                      if (check1 ||
                                          check2 ||
                                          check3 ||
                                          check4 ||
                                          check5 ||
                                          check6 ||
                                          check7 ||
                                          check8 ||
                                          check9 ||
                                          check10 ||
                                          check11) {
                                        return getBoxActiveHabit(
                                            context, habit, itemIndex, true);
                                      } else {
                                        return getBoxActiveHabit(
                                            context, habit, itemIndex, false);
                                      }
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: CarouselSlider.builder(
                                  carouselController: carouselController1,
                                  options: CarouselOptions(
                                      pageSnapping: true,
                                      viewportFraction: 0.21,
                                      height: 99,
                                      autoPlay: false,
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 3),
                                      autoPlayInterval:
                                          const Duration(seconds: 4)),
                                  itemCount: count,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      Consumer<DataHabitsProvider>(
                                          builder: (context, data, _) {
                                    Get.find<AnimationControllerHabit>()
                                        .getAnimation(math.Random().nextInt(3));

                                    bool check1 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count]
                                            .day[dateController.today]! &&
                                        dateController.currentDateTime.day >=
                                            habit[itemIndex + count].start.day;
                                    bool check2 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count]
                                            .day[dateController.today]! &&
                                        dateController.currentDateTime.month >
                                            habit[itemIndex + count]
                                                .start
                                                .month;
                                    bool check3 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count]
                                            .day[dateController.today]! &&
                                        dateController.currentDateTime.year >
                                            habit[itemIndex + count].start.year;

                                    bool check6 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].statusRepeat ==
                                            "weekly" &&
                                        dateController.currentDateTime.day >=
                                            habit[itemIndex + count]
                                                .start
                                                .day &&
                                        habitController.checkWeekly(
                                            habit[itemIndex + count]);
                                    bool check7 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].statusRepeat ==
                                            "weekly" &&
                                        dateController.currentDateTime.month >
                                            habit[itemIndex + count]
                                                .start
                                                .month &&
                                        habitController.checkWeekly(
                                            habit[itemIndex + count]);
                                    bool check8 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].statusRepeat ==
                                            "weekly" &&
                                        dateController.currentDateTime.year >
                                            habit[itemIndex + count]
                                                .start
                                                .year &&
                                        habitController.checkWeekly(
                                            habit[itemIndex + count]);

                                    bool check9 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].statusRepeat ==
                                            "monthly" &&
                                        dateController.currentDateTime.day >=
                                            habit[itemIndex + count]
                                                .start
                                                .day &&
                                        habitController.checkMonthly(
                                            habit[itemIndex + count]);
                                    bool check10 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].statusRepeat ==
                                            "monthly" &&
                                        dateController.currentDateTime.month >
                                            habit[itemIndex + count]
                                                .start
                                                .month &&
                                        habitController.checkMonthly(
                                            habit[itemIndex + count]);
                                    bool check11 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].statusRepeat ==
                                            "monthly" &&
                                        dateController.currentDateTime.year >
                                            habit[itemIndex + count]
                                                .start
                                                .year &&
                                        habitController.checkMonthly(
                                            habit[itemIndex + count]);

                                    bool check4 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].start.day ==
                                            dateController
                                                .currentDateTime.day &&
                                        habit[itemIndex + count]
                                            .completeDay
                                            .isEmpty &&
                                        habit[itemIndex + count].type ==
                                            "oneTask";
                                    bool check5 = itemIndex + count <
                                            habit.length &&
                                        habit[itemIndex + count].type ==
                                            "oneTask" &&
                                        habitController.checkCompleteDayOneTask(
                                            habit[itemIndex + count]);
                                    if (check1 ||
                                        check2 ||
                                        check3 ||
                                        check4 ||
                                        check5 ||
                                        check6 ||
                                        check7 ||
                                        check8 ||
                                        check9 ||
                                        check10 ||
                                        check11) {
                                      return getBoxActiveHabit(context, habit,
                                          itemIndex + count, true);
                                    } else {
                                      return getBoxActiveHabit(context, habit,
                                          itemIndex + count, false);
                                    }
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
              }),
          GetBuilder<DateController>(
            builder: (c) => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .4,
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
                          onPressed: () {
                            dateController
                                .updateCurrentMonthList(DateTime.now());
                          },
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: dateController.dateToday.day ==
                                        dateController.currentDateTime.day
                                    ? Colors.white
                                    : Colors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                dateController.setCurrentDateTime(DateTime(
                                    dateController.currentDateTime.year,
                                    dateController.currentDateTime.month,
                                    dateController.currentDateTime.day - 1));
                              },
                              icon: const Icon(Icons.arrow_back_ios_rounded,
                                  color: Colors.white, size: 18),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                dateController.setCurrentDateTime(DateTime(
                                    dateController.currentDateTime.year,
                                    dateController.currentDateTime.month,
                                    dateController.currentDateTime.day + 1));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white, size: 18),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
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
                                dateController.setCurrentDateTime(
                                    dateController.currentMonthList[index]);
                              },
                              child: Container(
                                width: 50,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: dateController
                                                .currentMonthList[index].day !=
                                            dateController.currentDateTime.day
                                        ? Colors.transparent
                                        : Colors.lightBlueAccent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      date_util.DateUtils.weekdays[
                                          dateController.currentMonthList[index]
                                                  .weekday -
                                              1],
                                      style: TextStyle(
                                          color: dateController
                                                      .currentMonthList[index]
                                                      .day !=
                                                  dateController
                                                      .currentDateTime.day
                                              ? Colors.white54
                                              : Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      dateController.currentMonthList[index].day
                                          .toString(),
                                      style: TextStyle(
                                          color: dateController
                                                      .currentMonthList[index]
                                                      .day !=
                                                  dateController
                                                      .currentDateTime.day
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
                    const SizedBox(height: 6),
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
                          "${Boxes.getHabit().toMap().length} task",
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

  Widget getBoxActiveHabit(
      BuildContext context, List habit, int itemIndex, bool active) {
    return GestureDetector(
      onTap: () {
        if (active) {
          showDialog(
              context: context,
              builder: (context) {
                // push data habit by index and check this habit for today or not
                return DialogHabit(
                  habit: habit[itemIndex],
                  today: dateController.dateToday.day ==
                      dateController.currentDateTime.day,
                );
              });
        }
      },
      child: GetBuilder<AnimationControllerHabit>(
        init: AnimationControllerHabit(),
        builder: (controller) => FadeTransition(
          opacity: controller.animation,
          child: Container(
              width: 78,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                  Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                      random.nextInt(257), active ? 1 : .35),
                  Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                      random.nextInt(256), active ? 1 : .35),
                ]),
              ),
              child: Stack(children: [
                Align(
                    alignment: Alignment.center,
                    child: Icon(active
                        ? IconData(habit[itemIndex].icon,
                            fontFamily: "MaterialIcons")
                        : DataHabits.bankIcon[
                            random.nextInt(DataHabits.bankIcon.length)])),
                active
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 3, right: 5),
                          child: Text(
                            // if today return status, if last return done, if future return active
                            dateController.dateToday.day ==
                                    dateController.currentDateTime.day
                                ? habit[itemIndex].status
                                : dateController.dateToday.day >
                                        dateController.currentDateTime.day
                                    ? "done"
                                    : "active",
                            style: TextStyle(
                                color: darkBlueOne,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -.5),
                          ),
                        ))
                    : const Text(''),
              ])),
        ),
      ),
    );
  }

  Widget getCarousel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: CarouselSlider(
          options: CarouselOptions(
              pageSnapping: true,
              viewportFraction: 0.21,
              height: 99,
              autoPlay: false,
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayInterval: const Duration(seconds: 4)),
          items: [1, 2, 3, 4, 5, 6].map((e) {
            return Builder(
              builder: (BuildContext context) {
                Get.find<AnimationControllerHabit>()
                    .getAnimation(math.Random().nextInt(5));
                //	animationControllerHabit.getAnimation(math.Random().nextInt(6));
                return GetBuilder<AnimationControllerHabit>(
                  init: AnimationControllerHabit(),
                  builder: (controller) => FadeTransition(
                    opacity: controller.animation,
                    child: Container(
                      width: 78,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        gradient:
                            LinearGradient(begin: Alignment.topLeft, colors: [
                          Color.fromRGBO(random.nextInt(256),
                              random.nextInt(256), random.nextInt(256), .35),
                          Color.fromRGBO(random.nextInt(256),
                              random.nextInt(256), random.nextInt(256), .35),
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
