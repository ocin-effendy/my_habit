import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
					Container(
							color: Colors.blue,
					),
					Align(
						alignment: Alignment.bottomCenter,
							child: Expanded(
									child: Container(
										width: MediaQuery.of(context).size.width,
										height: MediaQuery.of(context).size.height * .35,
										decoration: const BoxDecoration(
											color: Color.fromRGBO(21, 21, 81, 1),
											borderRadius: BorderRadius.only(
												topLeft: Radius.circular(35),
												topRight: Radius.circular(35),
											)
										),
									)
									),
							),
						SafeArea(
						  child: Padding(
						    padding: const EdgeInsets.all(20),
						    child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
						    	children: [
						  			const Text("Work Habits",
											style: TextStyle(
												color: Colors.white,
												fontSize: 28,
												fontWeight: FontWeight.w500
											),
										),
										IconButton(
											onPressed: (){},
											icon: const Icon(Icons.settings_outlined, color: Colors.white,),
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
