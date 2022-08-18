import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatePickerController _controllerDatePicker = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  final math.Random _random = math.Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(21, 21, 81, 1),
            child: Transform.translate(
              offset: Offset(-35, -35),
              child: Transform.rotate(
                angle: -math.pi / 15,
                child: Transform(
                  transform: Matrix4.diagonal3Values(1.3, 1, 1),
                  child: Column(
                    children: [
                      for (int i = 0; i < 7; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: CarouselSlider(
                              options: CarouselOptions(
                                  viewportFraction: 0.23, height: 99, autoPlay: true, autoPlayAnimationDuration: Duration(seconds: 3*i), autoPlayInterval: Duration(seconds: 4)),
                              items: [1, 2].map((e) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    int item = e;
                                    return Container(
                                      key: ValueKey('$i'),
                                      width: 78,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            colors: [
                                              Color.fromRGBO(
                                                  _random.nextInt(256),
                                                  _random.nextInt(256),
                                                  _random.nextInt(256),
                                                  i == 2 || i == 3 ? 1 : .35),
                                              Color.fromRGBO(
                                                  _random.nextInt(256),
                                                  _random.nextInt(256),
                                                  _random.nextInt(256),
                                                  i == 2 || i == 3 ? 1 : .35),
                                            ]),
                                      ),
                                    );
                                  },
                                );
                              }).toList()),
                        ),
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
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .42,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(21, 21, 81, 1),
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
                        children: [
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
									SizedBox(height: 8,),
                  DatePicker(
                    DateTime.now(),
                    width: 57,
                    controller: _controllerDatePicker,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.lightBlueAccent,
                    selectedTextColor: Colors.black,
										monthTextStyle: const TextStyle(color: Colors.white54, fontSize: 11),
										dateTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
										dayTextStyle: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                      });
                    },
                  ),
									const Divider(
										color: Colors.white54,
									),
									SizedBox(height: 8),
									Row(
										children: [
											Text("All habits:", style: TextStyle(color: Colors.white54),),
											SizedBox(width: 8),
											Text("two task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
										],
									),
                ],
              ),
            )),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Work Habits",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
