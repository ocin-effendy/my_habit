import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_habit/home_page.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/pages/achievements_page.dart';
import 'package:my_habit/pages/habits_page.dart';
import 'package:my_habit/pages/profile_page.dart';
import 'package:my_habit/widget/onetask_bottomsheet.dart';
import 'dart:math' as math;

import 'package:my_habit/widget/regulerhabit_bottomsheet.dart';

final math.Random random = math.Random();
List<String> listDays = [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];


class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin{
	late AnimationController _animationControllerBottomSheet;
  int currentTab = 0;
  List<Widget> screen = [const HomePage(), Achievements(), Habits(), Profile()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  final iconsGradientColors =
      List<Color>.from([
				Colors.yellowAccent,
        Colors.greenAccent,
        Colors.lightBlueAccent
			]);

	@override
	  void initState() {
	    super.initState();
			_animationControllerBottomSheet =
					        BottomSheet.createAnimationController(this);
			    _animationControllerBottomSheet.duration = const Duration(milliseconds: 600);
  }

	@override
	  void dispose() {
	    super.dispose();
			_animationControllerBottomSheet.dispose();
	  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: getBottomBar(context),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            MediaQuery.of(context).size.width * 0.5 - 25,
            MediaQuery.of(context).size.height * 0.89),
        floatingActionButton: SpeedDial(
					icon: Icons.add,
					activeIcon: Icons.close,
					animationDuration: const Duration(milliseconds: 300),
            animationAngle: math.pi /2,
					gradient: primaryGradient,
					gradientBoxShape: BoxShape.circle,
					overlayColor: Colors.black,
					buttonSize: const Size(50, 50),
					overlayOpacity: .75,
					spacing: 20,
					spaceBetweenChildren: 5,
            children: [
              SpeedDialChild(
								backgroundColor: Color.fromRGBO(52, 232, 158, 1),
								onTap: (){
									showModalBottomSheet(
										context: context,
                    backgroundColor: darkBlueOne,
										isScrollControlled: true,
										transitionAnimationController: _animationControllerBottomSheet,
										shape: const RoundedRectangleBorder(
												borderRadius: BorderRadius.vertical(top: Radius.circular(35))
												),
										builder: (context) {
											return RegulerHabitBottomSheet();
										} 
									);
								},
								child: const Icon(Icons.calendar_month_rounded, color: darkBlueOne,)),
              SpeedDialChild(
								backgroundColor: Color.fromRGBO(52, 232, 158, 1),
								onTap: (){
									showModalBottomSheet(
										context: context,
										backgroundColor: darkBlueOne,
										isScrollControlled: true,
										transitionAnimationController: _animationControllerBottomSheet,
										shape: const RoundedRectangleBorder(
											borderRadius: BorderRadius.vertical(top: Radius.circular(35))
										),
										builder: (context){
											return OneTaskBottomSheet();
										}
									);
								},
								child: const Icon(Icons.event_available_rounded, color: darkBlueOne,)),
							] 
      ),
    );
  }


  Widget getFloatingActionButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
              Colors.yellowAccent,
              Colors.greenAccent,
              Colors.lightBlueAccent
            ])),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 60,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomAppBar(
              color: Colors.white.withOpacity(0.25),
              shape: const CircularNotchedRectangle(),
              notchMargin: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5 - 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = const HomePage();
                                currentTab = 0;
                              });
                            },
                            icon: currentTab == 0
                                ? ShaderMask(
                                    shaderCallback: (rect) => primaryGradient 
                                        .createShader(rect),
                                    child: const Icon(
                                      Icons.format_list_bulleted_rounded,
                                      color: Colors.white,
                                    ))
                                : const Icon(Icons.format_list_bulleted_rounded,
                                    color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Achievements();
                                currentTab = 1;
                              });
                            },
                            icon: currentTab == 1
                                ? ShaderMask(
                                    shaderCallback: (rect) => primaryGradient
                                        .createShader(rect),
                                    child: const Icon(
                                      Icons.pie_chart_outline_rounded,
                                      color: Colors.white,
                                    ))
                                : const Icon(Icons.pie_chart_outline_rounded,
                                    color: Colors.white))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5 - 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Habits();
                                currentTab = 2;
                              });
                            },
                            icon: currentTab == 2
                                ? ShaderMask(
                                    shaderCallback: (rect) => primaryGradient 
                                        .createShader(rect),
                                    child: const Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.white,
                                    ))
                                : const Icon(Icons.access_time_rounded,
                                    color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Profile();
                                currentTab = 3;
                              });
                            },
                            icon: currentTab == 3
                                ? ShaderMask(
                                    shaderCallback: (rect) => primaryGradient
                                        .createShader(rect),
                                    child: const Icon(
                                      Icons.account_circle_outlined,
                                      color: Colors.white,
                                    ))
                                : const Icon(Icons.account_circle_outlined,
                                    color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}

class CustomFloatingActionButtonLocation
    implements FloatingActionButtonLocation {
  final double x;
  final double y;
  const CustomFloatingActionButtonLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(x, y);
  }
}
