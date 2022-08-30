import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:my_habit/data.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/provider/data_habits_provider.dart';
import 'package:my_habit/provider/pop_up_provider.dart';
import 'package:my_habit/root.dart';
import 'package:provider/provider.dart';
import 'utils/date_utils.dart' as date_util;

CarouselController carouselController = CarouselController();
CarouselController carouselController1 = CarouselController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _controllerDatePicker = DatePickerController();
  DateTime _selectedValue = DateTime.now();
	late ScrollController scrollController;
	List<DateTime> currentMonthList = List.empty();
	DateTime currentDateTime = DateTime.now();

	late AnimationController _animationController;
	late Animation<double> _animation;

  //List<IconData> dataIcon = [];
  int count = 3;

	void getAnimation(int timeDuration){
		_animationController = AnimationController(vsync: this, duration: Duration(seconds: timeDuration))..forward();
		_animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
	}

	@override
  void initState() {
    super.initState();
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
		print("================");
		print(currentMonthList[1]);
		print(currentMonthList[1].weekday);
    scrollController = ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);

	}

	@override
	  void dispose() {
	    super.dispose();
			scrollController.dispose();
			_animationController.dispose();
	  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PopUpProvider>(
      create: (context) => PopUpProvider(),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Container(
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
                              itemCount: count,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Consumer<DataHabitsProvider>(
                                    builder: (context, data, _) {
																				getAnimation(math.Random().nextInt(4));
                                       return  GestureDetector(
                                      onTap: () {
                                        if (data.listDataHabits.isNotEmpty && itemIndex < data.listDataHabits.length) {
                                          Provider.of<PopUpProvider>(context,listen: false).setStatus(true);
                                        }
                                      },
                                      child: FadeTransition(
																				opacity: _animation,
                                        child: Container(
                                            width: 78,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
																							gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        data.listDataHabits.isNotEmpty && itemIndex < data.listDataHabits.length ? 1 : .35),
                                                    Color.fromRGBO(
                                                        random.nextInt(256),
                                                        random.nextInt(256),
                                                        random.nextInt(256), data.listDataHabits.isNotEmpty && itemIndex <data.listDataHabits.length ? 1 : .35),
                                                  ]),
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Icon(data
                                                                .listDataHabits
                                                                .isNotEmpty &&
                                                            itemIndex <
                                                                data.listDataHabits
                                                                    .length
                                                        ? data.listDataHabits[
                                                            itemIndex]
                                                        : DataHabits.bankIcon[
                                                            random.nextInt(
                                                                DataHabits
                                                                    .bankIcon
                                                                    .length)])),
                                                data.listDataHabits.isNotEmpty &&
                                                        itemIndex <
                                                            data.listDataHabits
                                                                .length
                                                    ? const Align(
                                                        alignment:
                                                            Alignment.bottomRight,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3,
                                                                  right: 5),
                                                          child: Text(
                                                            "active",
                                                            style: TextStyle(
																															color: darkBlueOne,	
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    -.5),
                                                          ),
                                                        ))
                                                    : const Text(''),
                                              ],
                                            )),
                                      ),
																		
																		);}
                                  )),
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
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 3),
                                autoPlayInterval: const Duration(seconds: 4)),
                            itemCount: count,
                            itemBuilder: (BuildContext context, int itemIndex,int pageViewIndex) => Consumer<DataHabitsProvider>(
                              builder: (context, data, _) {
																getAnimation(math.Random().nextInt(4));
																return GestureDetector(
                                onTap: () {
                                  if (data.listDataHabits.isNotEmpty &&
                                      itemIndex < data.listDataHabits.length) {
                                    Provider.of<PopUpProvider>(context,
                                            listen: false)
                                        .setStatus(true);
                                  }
                                },
                                child: FadeTransition(
																	opacity: _animation,
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
                                                  itemIndex + count <
                                                          data.listDataHabits
                                                              .length
                                                      ? 1
                                                      : .35),
                                              Color.fromRGBO(
                                                  random.nextInt(256),
                                                  random.nextInt(256),
                                                  random.nextInt(256),
                                                  itemIndex + count <
                                                          data.listDataHabits
                                                              .length
                                                      ? 1
                                                      : .35),
                                            ]),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Icon(itemIndex + count <
                                                    data.listDataHabits.length
                                                ? data.listDataHabits[
                                                    itemIndex + count]
                                                : DataHabits.bankIcon[
                                                    random.nextInt(DataHabits
                                                        .bankIcon.length)])),
                                        itemIndex + count <
                                                data.listDataHabits.length
                                            ? const Align(
                                                alignment: Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3, right: 5),
                                                  child: Text(
                                                    "active",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: -.5),
                                                  ),
                                                ))
                                            : const Text(''),
                                      ])),
                                ),
                              );}
                            ),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Expanded(
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
                        const Text(
                          "Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 18,
                            )
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
												controller: scrollController,
												scrollDirection: Axis.horizontal,
												shrinkWrap: true,
												physics: BouncingScrollPhysics(),
												itemCount: currentMonthList.length,
												itemBuilder: (BuildContext context, int index){
													return GestureDetector(
														onTap: (){
															setState(() {
																currentDateTime = currentMonthList[index];
															});
														},
													  child: Container(
													  	width: 50,
													  	height: 60,
															decoration: BoxDecoration(
																color: currentMonthList[index].day != currentDateTime.day ? Colors.transparent : Colors.lightBlueAccent,
																borderRadius: const BorderRadius.all(Radius.circular(10))
															),
													    child: Column(
																mainAxisAlignment: MainAxisAlignment.center,
													    	children: [
													    		Text(date_util.DateUtils.weekdays[currentMonthList[index].weekday-1],
																	style: TextStyle(
																		color: currentMonthList[index].day != currentDateTime.day ? Colors.white54 : Colors.black,
																		fontSize: 14,
																		fontWeight: FontWeight.w500
																	),
																	),
																	const SizedBox(height: 8,),
																	Text(currentMonthList[index].day.toString(),
																		style: TextStyle(
																			color: currentMonthList[index].day != currentDateTime.day ? Colors.white : Colors.black,
																			fontSize: 18,
																			fontWeight: FontWeight.w700
																		),
																	)
													    	],
													    ),
													  ),
													);
												}
											),
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
                          style:Theme.of(context).textTheme.headline2,
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
              )),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  children: [
                    const Text(
                      "Work Habits",
									  	style: TextStyle(
										  color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                    ),
                    // ini getpopuphabits
										getPopUpHabit(),
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
										]
									),
								),
							),
						),
          ],
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
              viewportFraction: 0.23,
              height: 99,
              autoPlay: false,
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayInterval: const Duration(seconds: 4)),
          items: [1, 2, 3, 4, 5, 6].map((e) {
            return Builder(
              builder: (BuildContext context) {
								getAnimation(math.Random().nextInt(6));
                return FadeTransition(
									opacity: _animation,
                  child: Container(
                    width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(begin: Alignment.topLeft, colors: [
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
                );
              },
            );
          }).toList()),
    );
  }

  Widget getDatePicker() {
    return DatePicker(
      DateTime.now(),
      width: 57,
      controller: _controllerDatePicker,
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.lightBlueAccent,
      selectedTextColor: Colors.black,
      monthTextStyle: const TextStyle(color: Colors.white54, fontSize: 11),
      dateTextStyle: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      dayTextStyle: const TextStyle(
          color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
      onDateChange: (date) {
        // New date selected
        setState(() {
          _selectedValue = date;
        });
      },
    );
  }

  Widget getPopUpHabit() {
    return Consumer<PopUpProvider>(
      builder: (context, status, _) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: SizedBox(
          key: UniqueKey(),
          child: status.getStatus
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            constraints: const BoxConstraints(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            constraints: const BoxConstraints(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.pause_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            constraints: const BoxConstraints(),
                          ),
                          IconButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Provider.of<PopUpProvider>(context,
                                        listen: false)
                                    .setStatus(false);
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 18,
                              )),
                        ],
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.laptop_mac_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        title: Text(
                          "Coding",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Row(children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Got for it!",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Do Anytime",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              "active",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "0/3",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "times",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ]),
                            Row(
                              children: [
																IconButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.replay_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    )),
																IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  constraints: const BoxConstraints(),
                                ),
                                                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.done_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  constraints: const BoxConstraints(),
                                ),
																IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  constraints: const BoxConstraints(),
                                ),
																IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
