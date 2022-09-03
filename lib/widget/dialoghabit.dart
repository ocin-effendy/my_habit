import 'package:flutter/material.dart';
import 'package:my_habit/models/color.dart';
import 'package:my_habit/pages/detail_habit_page.dart';
import 'package:my_habit/widget/regulerhabit_bottomsheet.dart';


class DialogHabit extends StatelessWidget{
  const DialogHabit({Key? key}) : super(key: key);

	@override
	  Widget build(BuildContext context) {
			var width = MediaQuery.of(context).size.width;
			var height = MediaQuery.of(context).size.height;

		 return AlertDialog(
			insetPadding: EdgeInsets.symmetric(vertical: height * .1, horizontal: width * .05),
			alignment: Alignment.topCenter,
			contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
			shape: const RoundedRectangleBorder(
					borderRadius: BorderRadius.all(Radius.circular(30))
				),
			backgroundColor: Colors.black.withOpacity(.7), // status.getStatus ? Container : null
          content: Container(
						height: height *.22,
						width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const DetailHabit()));
                              },
                              icon: const Icon(
                                Icons.info_outline_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: darkBlueOne,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(35))),
                                    builder: (context) {
                                      return RegulerHabitBottomSheet();
                                    });
                              },
                              icon: const Icon(
                                Icons.edit_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.pause_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  //Provider.of<PopUpProvider>(context,
                                   //       listen: false)
                                    //  .setStatus(false);
																	Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          ],
                        ),
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
                              fontSize: 22, fontWeight: FontWeight.w500),
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
                                fontSize: 12, fontWeight: FontWeight.w500),
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
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text(
                              "active",
                              style: TextStyle(fontWeight: FontWeight.w500),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
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
                                  padding:const EdgeInsets.symmetric(horizontal: 2),
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
    );

	  }

}
