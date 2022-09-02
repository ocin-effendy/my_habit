import 'package:flutter/material.dart';
import 'package:my_habit/models/color.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
	TimeOfDay _time = TimeOfDay.now();
	bool switchSound = false;
	String morning = "00:00";
	String afternoon = "12:00";
	String evening = "18:00";


	void _selectTime(String day) async {
    final  newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
			if(day == "morning"){
				setState(() {
					_time = newTime;
					morning = _time.toString();
					morning = morning.split("(")[1].split(")")[0];
				});
			}else if(day == "afternoon"){
				setState(() {
					_time = newTime;
					afternoon = _time.toString();
					afternoon = afternoon.split("(")[1].split(")")[0];
				});
			}else{
				setState(() {
					_time = newTime;
					evening = _time.toString();
					evening = evening.split("(")[1].split(")")[0];
				});
			}
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
			body: Stack(
				children: [
						SafeArea(
						  child: SingleChildScrollView(
								child: Padding(
										padding: const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 30),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Padding(
											  padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
													"Settings",
													  style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
															fontWeight: FontWeight.w600
														),
                        ),
                      ),
                      SizedBox(
											  height: 20,
                      ),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Text("TIME 0F DAY",
															style: Theme.of(context).textTheme.headline1,
														),
														ListTile(
															onTap: (){
																_selectTime("morning");
															},
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.yellowAccent,
																		Colors.orange,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.wb_sunny_rounded,color: Colors.white,)),
															),
															title: Text("Morning", style: Theme.of(context).textTheme.headline1),
															subtitle: Text(morning, style: Theme.of(context).textTheme.headline2),
															minLeadingWidth: 0,
														),
														ListTile(
															onTap: (){
																_selectTime("afternoon");
															},
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.blueAccent,
																		Colors.lightBlueAccent,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.wb_cloudy_rounded,color: Colors.white,)),
															),
															title: Text("Afternoon", style: Theme.of(context).textTheme.headline1),
															subtitle: Text(afternoon, style: Theme.of(context).textTheme.headline2),
															minLeadingWidth: 0,
														),
														ListTile(
															onTap: (){
																_selectTime("evening");
															},
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.white,
																		Colors.orangeAccent,
																		Colors.deepOrangeAccent
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.brightness_2_rounded,color: Colors.white,)),
															),
															title: Text("Evening", style: Theme.of(context).textTheme.headline1),
															subtitle: Text(evening, style: Theme.of(context).textTheme.headline2),
															minLeadingWidth: 0,
														),
													],
												),
											SizedBox(
												height: 10,
											),
											Container(
												width: MediaQuery.of(context).size.width,
												height: 1,
												decoration: BoxDecoration(
													gradient: primaryGradient,
													),
											),
											SizedBox(
												height: 20,
											),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Text("GENERAL",
															style: Theme.of(context).textTheme.headline1,
														),
														ListTile(
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.greenAccent,
																		Colors.lightGreenAccent,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.volume_up_rounded,color: Colors.white,)),
															),
															title: Text("Sound", style: Theme.of(context).textTheme.headline1),
															minLeadingWidth: 0,
															trailing: Switch.adaptive(value: switchSound, onChanged: (value){setState(() {switchSound = value;});}),
														),
														ListTile(
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.red,
																		Colors.redAccent,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.delete_rounded,color: Colors.white,)),
															),
															title: Text("Delete All", style: Theme.of(context).textTheme.headline1),
															minLeadingWidth: 0,
														),
														ListTile(
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.purpleAccent,
																		Colors.deepPurpleAccent
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.help_rounded,color: Colors.white,)),
															),
															title: Text("Help", style: Theme.of(context).textTheme.headline1),
															minLeadingWidth: 0,
														),
														ListTile(
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.yellow,
																		Colors.yellowAccent,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.thumb_up_rounded,color: Colors.white,)),
															),
															title: Text("Rate Us", style: Theme.of(context).textTheme.headline1),
															minLeadingWidth: 0,
														),
														ListTile(
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.lightBlueAccent,
																		Colors.blueAccent,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.message_rounded,color: Colors.white,)),
															),
															title: Text("Send Feedback", style: Theme.of(context).textTheme.headline1),
															minLeadingWidth: 0,
														),
														ListTile(
															leading: ShaderMask(
																shaderCallback: (rect)=> LinearGradient(
																	colors: [
																		Colors.white,
																		Colors.white54,
																	]
																).createShader(rect),
															  child: SizedBox(
															  	height: double.infinity,
															  	child: Icon(Icons.share_rounded,color: Colors.white,)),
															),
															title: Text("Share App", style: Theme.of(context).textTheme.headline1),
															minLeadingWidth: 0,
														),


													],
												),

										],

									),

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
    );
  }
}


