import 'package:flutter/material.dart';
import 'package:my_habit/data.dart';
import 'package:my_habit/models/color.dart';

class DialogIcons extends StatefulWidget {
  @override
  State<DialogIcons> createState() => _DialogIconsState();
}

class _DialogIconsState extends State<DialogIcons> {
  final bankIcons = DataHabits.bankIcon;

  IconData _iconHabit = Icons.star_rate_rounded; 
 //IconHabit
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: AlertDialog(
			backgroundColor: darkBlueOne,
        title: Text("Choose Icon"),
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
