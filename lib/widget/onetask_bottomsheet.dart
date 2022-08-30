import 'package:flutter/material.dart';
import 'package:my_habit/data.dart';
import 'package:my_habit/models/color.dart';

class OneTaskBottomSheet extends StatefulWidget {
  @override
  State<OneTaskBottomSheet> createState() => _OneTaskBottomSheetState();
}

class _OneTaskBottomSheetState extends State<OneTaskBottomSheet> {
  final _nameOneTaskController = TextEditingController(); //title
  final bankIcons = DataHabits.bankIcon;
  IconData _iconHabit = Icons.star_rate_rounded; //IconHabit
  bool statusInput = true;
  bool statusSwitchReminders = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.97,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                  onPressed: () {},
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
                cursorColor: Colors.lightBlueAccent,
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
						onTap: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 5),
              child: Row(
                children: [
                  ShaderMask(
                      shaderCallback: (rect) => primaryGradient.createShader(rect),
                      child: Icon(
                        Icons.event_rounded,
                        color: Colors.white,
                        size: 34,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "31 Agustus 2022",
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
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
