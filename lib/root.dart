import 'package:flutter/material.dart';
import 'package:my_habit/home_page.dart';
import 'package:my_habit/pages/habits_page.dart';
import 'package:my_habit/pages/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentTab = 0;

  List<Widget> screen = [HomePage(), Habits(), Profile()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  final iconsGradientColors =
      List<Color>.from([Colors.yellow, Colors.greenAccent, Colors.blue]);

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
      floatingActionButton: GestureDetector(
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
      ),
    );
  }

  Widget getBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
																currentScreen = HomePage();
																currentTab = 0;
                              });
                            },
                            icon: currentTab == 0 ? ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                colors: iconsGradientColors,
																begin: Alignment.topLeft).createShader(rect),
                                child: const Icon(Icons.format_list_bulleted_rounded, color: Colors.white,)
                                ) : const Icon(Icons.format_list_bulleted_rounded, color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Habits();
                                currentTab = 1;
                              });
                            },
                            icon: currentTab == 1 ? ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                colors: iconsGradientColors,
                                begin: Alignment.topLeft).createShader(rect),
                                child: const Icon(Icons.pie_chart_outline_rounded, color: Colors.white,)
																) : const Icon(Icons.pie_chart_outline_rounded, color: Colors.white))
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
															icon: currentTab == 2 ? ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                colors: iconsGradientColors,
                                begin: Alignment.topLeft).createShader(rect),
                                child: const Icon(Icons.access_time_rounded, color: Colors.white,)
																) : const Icon(Icons.access_time_rounded, color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Profile();
                                currentTab = 3;
                              });
                            },
                            icon: currentTab == 3 ? ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                colors: iconsGradientColors,
                                begin: Alignment.topLeft).createShader(rect),
                                child: const Icon(Icons.account_circle_outlined, color: Colors.white,)
																) : const Icon(Icons.account_circle_outlined, color: Colors.white)),
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
