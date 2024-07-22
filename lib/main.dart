import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_utilization/calendar.dart';
import 'package:room_utilization/firebase_options.dart';
import 'package:room_utilization/model/map.dart';
import 'package:room_utilization/model/semester.dart';
import 'package:room_utilization/notifier.dart';
import 'package:room_utilization/pending.dart';
import 'package:room_utilization/reservation_modal.dart';
import 'package:room_utilization/theme.dart';
import 'package:room_utilization/ui_components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => CalendarData())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Map_Display());
  }
}

class Map_Display extends StatefulWidget {
  const Map_Display({Key? key}) : super(key: key);

  @override
  State<Map_Display> createState() => _Map_DisplayState();
}

class _Map_DisplayState extends State<Map_Display> {
  late String base64 = '';
  late String currentSemester = '';
  late int currentFloor = 1;

  @override
  void initState() {
    super.initState();
    _fetchLatestMap(1);
    getLatestSemester();
  }

  void _fetchLatestMap(int Floor) async {
    Map_Detail? latestMap = await Map_Detail.getLatestMap(Floor);
    if (latestMap != null) {
      setState(() {
        currentFloor = Floor;
        base64 = latestMap.map_image;
      });
    }
  }

  void showModalReservation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReservationModal();
      },
    );
  }

  void showModalPending(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PendingModal();
      },
    );
  }

  Future<void> getLatestSemester() async {
    Semester? latestSemester = await Semester.fetchLatestSemester();
    if (latestSemester != null) {
      setState(() {
        print("print semester${latestSemester.semester_name}");
        currentSemester = latestSemester.id!;
      });
      Provider.of<CalendarData>(context, listen: false)
          .updateSemester(currentSemester!);
    } else {
      print("No semester found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Current Floor : ${currentFloor}",
                        style: const TextStyle(
                            fontFamily: 'Satoshi', fontSize: 24),
                      ),
                      Container(
                        width: 1000,
                        height: 750,
                        child: Image.memory(
                          base64Decode(base64),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ))),
          Container(
            color: Colors.white,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: TextButton(
                      onPressed: () {
                        print("button 1 clicked");
                        setState(() {
                          _fetchLatestMap(1);
                        });
                      },
                      child: const Text(
                        "1",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    )),
                Container(height: 50),
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: TextButton(
                      onPressed: () {
                        print("button 2 clicked");
                        setState(() {
                          _fetchLatestMap(2);
                        });
                      },
                      child: const Text(
                        "2",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
          Container(
              width: 500,
              child: Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          bottom: BorderSide.none,
                          left: BorderSide(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        color: bgColor,
                      ),
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "ROOM RESERVATION",
                              style: TextStyle(
                                  fontFamily: 'Satoshi', fontSize: 36),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: SimpleElevatedButtonWithIcon(
                                          label: const Text(
                                            'Reservation',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'Satoshi'),
                                          ),
                                          iconData: Icons.post_add_rounded,
                                          iconColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          color: const Color(0xff274c77),
                                          onPressed: () {
                                            showModalReservation(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: SimpleElevatedButtonWithIcon(
                                          label: const Text(
                                            'Pending',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'Satoshi'),
                                          ),
                                          iconData: Icons.post_add_rounded,
                                          iconColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          color: const Color(0xff274c77),
                                          onPressed: () {
                                            showModalPending(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: DynamicList())
                        ],
                      )))),
        ],
      ),
    ));
  }
}

class DynamicList extends StatefulWidget {
  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rooms')
          .orderBy('room_name')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Container();
        return ListView.builder(
          padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            return Material(
              type: MaterialType.transparency,
              child: ListTile(
                hoverColor: secondaryColor,
                minVerticalPadding: 10,
                title: Text(
                  document['room_name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Satoshi',
                  ),
                ),
                onTap: () {
                  print('Item tapped: ${document.id}');
                  Provider.of<CalendarData>(context, listen: false)
                      .updateCalendar(document['room_id']);
                  showCalendarModal(
                    context,
                    document['room_name'],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

void showCalendarModal(BuildContext context, String roomName) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            Text(roomName),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: FutureBuilder<List<Semester?>>(
                        future: Semester.fetchAllSemesters(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Semester?>> snapshot) {
                          String currentSemester = snapshot.data![0]?.id ?? '';
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Material(
                              child: DropdownButton<String>(
                                underline: Container(),
                                hint: const Text(
                                  'Select a semester',
                                  style: TextStyle(fontFamily: 'Satoshi'),
                                ),
                                value: Provider.of<CalendarData>(context)
                                    .semesterId,
                                onChanged: (String? newValue) {
                                  print("New sem:${newValue}");
                                  currentSemester = newValue!;
                                  Provider.of<CalendarData>(context,
                                          listen: false)
                                      .updateSemester(newValue!);
                                },
                                items: snapshot.data!
                                    .where((semester) => semester != null)
                                    .map((Semester? semester) =>
                                        DropdownMenuItem<String>(
                                          value: semester?.id ?? '',
                                          child: Text(
                                              semester?.semester_name ?? '',
                                              style: const TextStyle(
                                                  fontFamily: 'Satoshi')),
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                width: 1200,
                height: 800,
                child: CalendarWidget(),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}




// const cellRed = Color(0xffc73232);
// const cellMustard = Color(0xffd7aa22);
// const cellGrey = Color(0xffcfd4e0);
// const cellBlue = Color(0xff1553be);
// const background = Color.fromARGB(255, 255, 255, 255);

// class PietPainting extends StatefulWidget {
//   final Function(String, String)? onRoomUpdated;

//   const PietPainting({Key? key, this.onRoomUpdated}) : super(key: key);

//   @override
//   PietPaintingState createState() => PietPaintingState();
// }

// /////////////BACK UP OLD FORMAT DONT DELETE////////////////

// // gridArea('cf2').containing(
// //             Center(
// //               child: Stack(
// //                 children: [
// //                   Image.asset(pathfloor),
// //                 ],
// //               ),
// //             ),
// //           ),

// ////////////END OF BACK UP ///////////////////////////////

// class PietPaintingState extends State<PietPainting> {
//   Color? floor1Color = Color(0xff274c77);
//   Color? floor2Color = Color(0xff4f749f);

//   String currentFloor = "Floor 2 : ";
//   String roomName = "CISC LAB 24";
//   String pathfloor = 'assets/images/cisc1stfloor.png';
//   String pathfloor2 = 'assets/images/cisc2ndfloor.png';

//   //Floors/////////////
//   String c1 = 'assets/images/cisc1stf/1.png';
//   String c2 = 'assets/images/cisc1stf/2.png';
//   String c3 = 'assets/images/cisc1stf/3.png';
//   String c4 = 'assets/images/cisc1stf/4.png';
//   String c5 = 'assets/images/cisc1stf/5.png';
//   String c6 = 'assets/images/cisc1stf/6.png';
//   String c7 = 'assets/images/cisc1stf/7.png';
//   String c8 = 'assets/images/cisc1stf/8.png';
//   String c9 = 'assets/images/cisc1stf/9.png';
//   String c10 = 'assets/images/cisc1stf/10.png';
//   String c11 = 'assets/images/cisc1stf/11.png';
//   String c12 = 'assets/images/cisc1stf/12.png';
//   String c13 = 'assets/images/cisc1stf/13.png';
//   String c14 = 'assets/images/cisc1stf/14.png';
//   String c15 = 'assets/images/cisc1stf/15.png';

//   int activeFloor = 1;

//   void SwitchFloor(int floor) {
//     activeFloor = floor;
//     setState(() {
//       if (floor == 1) {
//         c1 = 'assets/images/cisc1stf/1.png';
//         c2 = 'assets/images/cisc1stf/2.png';
//         c3 = 'assets/images/cisc1stf/3.png';
//         c4 = 'assets/images/cisc1stf/4.png';
//         c5 = 'assets/images/cisc1stf/5.png';
//         c6 = 'assets/images/cisc1stf/6.png';
//         c7 = 'assets/images/cisc1stf/7.png';
//         c8 = 'assets/images/cisc1stf/8.png';
//         c9 = 'assets/images/cisc1stf/9.png';
//         c10 = 'assets/images/cisc1stf/10.png';
//         c11 = 'assets/images/cisc1stf/11.png';
//         c12 = 'assets/images/cisc1stf/12.png';
//         c13 = 'assets/images/cisc1stf/13.png';
//         c14 = 'assets/images/cisc1stf/14.png';
//         c15 = 'assets/images/cisc1stf/15.png';
//       } else {
//         c1 = 'assets/images/cisc2ndf/1.png';
//         c2 = 'assets/images/cisc2ndf/2.png';
//         c3 = 'assets/images/cisc2ndf/3.png';
//         c4 = 'assets/images/cisc2ndf/4.png';
//         c5 = 'assets/images/cisc2ndf/5.png';
//         c6 = 'assets/images/cisc2ndf/6.png';
//         c7 = 'assets/images/cisc2ndf/7.png';
//         c8 = 'assets/images/cisc2ndf/8.png';
//         c9 = 'assets/images/cisc2ndf/9.png';
//         c10 = 'assets/images/cisc2ndf/10.png';
//         c11 = 'assets/images/cisc2ndf/11.png';
//         c12 = 'assets/images/cisc2ndf/12.png';
//         c13 = 'assets/images/cisc2ndf/13.png';
//         c14 = 'assets/images/cisc2ndf/14.png';
//         c15 = 'assets/images/cisc2ndf/15.png';
//       }
//     });
//   }

//   late String currentSemester;

//   String getCurrentSemester() {
//     return currentSemester;
//   }

//   Future<void> getLatestSemester() async {
//     Semester? latestSemester = await Semester.fetchLatestSemester();
//     if (latestSemester != null) {
//       setState(() {
//         print("print semester${latestSemester.semester_name}");
//         currentSemester = latestSemester.id!;
//       });
//       Provider.of<CalendarData>(context, listen: false)
//           .updateSemester(currentSemester!);
//     } else {
//       // Handle the case where no semester is found
//       print("No semester found.");
//     }
//   }

//   Future<void> getAllSemester() async {
//     List<Semester?> latestSemester = await Semester.fetchAllSemesters();

//     // Iterate over the list, handling potential null values
//     for (Semester? semesterNullable in latestSemester) {
//       if (semesterNullable != null) {
//         // Cast the nullable Semester to a non-nullable Semester for printing
//         Semester semester = semesterNullable!;
//         print(
//             'Semester Name: ${semester.semester_name}, Start Date: ${semester.start_date.toDate()}, End Date: ${semester.end_date.toDate()}, Created Date: ${semester.date_created.toDate()}');
//       }
//     }
//   }

//   @override
//   void initState() {
//     getLatestSemester();
//     getAllSemester();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     final columnSizes = screenSize.width > 600
//         ? [3.0.fr, 3.0.fr, 3.0.fr, 3.5.fr, 3.5.fr, 3.5.fr]
//         : [10.0.fr, 10.0.fr, 10.0.fr];
//     final rowSizes = screenSize.width > 600
//         ? [1.5.fr, 3.5.fr, 3.5.fr, 3.5.fr, 3.5.fr, 3.5.fr, 1.5.fr, .5.fr]
//         : [
//             1.0.fr,
//             .5.fr,
//             2.0.fr,
//             2.0.fr,
//             2.0.fr,
//             2.0.fr,
//             2.0.fr,
//             .5.fr,
//             1.0.fr,
//             1.0.fr,
//             .5.fr,
//             3.0.fr,
//           ];
//     final areas = screenSize.width > 600
//         ? '''
//         hd hd hd se na pe
//         c1 c2 c3 ca ca ca
//         c4 c5 c6 ca ca ca
//         c7 c8 c9 ca ca ca
//         c10 c11 c12 ca ca ca
//         c13 c14 c15 ca ca ca
//         fl fl fl bw bw bw
//         fo fo fo fo fo fo
//         '''
//         : '''
//         se se na
//         hd hd hd
//         c1 c2 c3
//         c4 c5 c6
//         c7 c8 c9
//         c10 c11 c12
//         c13 c14 c15
//         fl fl fl
//         ca ca ca
//         ca ca ca
//         ca ca ca
//         ca ca ca
//         ''';

//     void showModalExample(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ReservationModal();
//         },
//       );
//     }

//     void showModalPending(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return PendingModal();
//         },
//       );
//     }

//     return Container(
//       color: background,
//       child: LayoutGrid(
//         columnGap: 0,
//         rowGap: 0,
//         areas: areas,
//         columnSizes: columnSizes,
//         rowSizes: rowSizes,
//         children: [
//           gridArea('ca').containing(CalendarWidget()),
//           gridArea('hd').containing(Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//               width: double.infinity,
//               height: double.infinity,
//               child: Center(
//                   child: Text(
//                 currentFloor + roomName,
//                 style: TextStyle(
//                   fontFamily: 'Satoshi',
//                   fontSize: 24, // Font size
//                   color: Colors.black, // Text color
//                   decoration: TextDecoration.none, // No underline
//                   // Add shadow for depth
//                 ),
//                 textAlign: TextAlign.center, // Center-align the text
//               )))),
//           gridArea('na').containing(
//             Container(
//               width: 500,
//               height: 200,
//               color: Colors.white,
//               child: SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: Center(
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: SimpleElevatedButtonWithIcon(
//                         label: const Text(
//                           'Reservation',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 255, 255, 255),
//                               fontFamily: 'Satoshi'),
//                         ),
//                         iconData: Icons.post_add_rounded,
//                         iconColor: Color.fromARGB(255, 255, 255, 255),
//                         color: Color(0xff274c77),
//                         onPressed: () {
//                           showModalExample(context);
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           gridArea('pe').containing(
//             Container(
//               width: 500,
//               height: 200,
//               color: Colors.white,
//               child: SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: Center(
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: SimpleElevatedButtonWithIcon(
//                         label: const Text(
//                           'Pendings',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 255, 255, 255),
//                               fontFamily: 'Satoshi'),
//                         ),
//                         iconData: Icons.post_add_rounded,
//                         iconColor: Color.fromARGB(255, 255, 255, 255),
//                         color: Color(0xff274c77),
//                         onPressed: () {
//                           showModalPending(context);
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           gridArea('se').containing(
//             Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(
//                           20), //border raiuds of dropdown button
//                       //blur radius of shadow
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0),
//                       child: FutureBuilder<List<Semester?>>(
//                         future: Semester.fetchAllSemesters(),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<List<Semester?>> snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator());
//                           } else if (snapshot.hasError ||
//                               snapshot.data == null) {
//                             return Center(
//                                 child: Text('Error: ${snapshot.error}'));
//                           } else {
//                             // Find the index of the currentSemester in the list of items
//                             int? currentIndex = snapshot.data!.indexWhere(
//                                 (item) => item?.id == currentSemester);

//                             return Material(
//                               child: DropdownButton<String>(
//                                 underline: Container(),
//                                 hint: Text(
//                                   'Select a semester',
//                                   style: TextStyle(fontFamily: 'Satoshi'),
//                                 ),
//                                 value: currentSemester,
//                                 onChanged: (String? newValue) {
//                                   print("New sem:${newValue}");
//                                   Provider.of<CalendarData>(context,
//                                           listen: false)
//                                       .updateSemester(newValue!);
//                                   setState(() {
//                                     currentSemester = newValue!;
//                                   });
//                                 },
//                                 items: snapshot.data!
//                                     .where((semester) =>
//                                         semester !=
//                                         null) // Filter out null semesters
//                                     .map((Semester? semester) =>
//                                         DropdownMenuItem<String>(
//                                           value: semester?.id ??
//                                               '', // Provide a default value if semester is null
//                                           child: Text(
//                                               semester?.semester_name ?? '',
//                                               style: TextStyle(
//                                                   fontFamily:
//                                                       'Satoshi')), // Provide a default text if semester is null
//                                         ))
//                                     .toList(),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Add other widgets here if needed
//               ],
//             ),
//           ),
//           gridArea('fl').containing(Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//             ),
//             width: double.infinity,
//             height: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 5),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Color.fromARGB(255, 255, 255, 255),
//                       backgroundColor: floor1Color,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(100)),
//                       fixedSize: Size(100, 100),
//                     ),
//                     onPressed: () {
//                       SwitchFloor(1);
//                       setState(() {
//                         floor2Color = Color(0xff4f749f); // Update floor2Color
//                         floor1Color = Color(0xff274c77); // Update floor1Color
//                         currentFloor = "Floor 1 : "; // Update currentFloor
//                       });
//                     },
//                     child: Center(
//                       // Center the text inside the button
//                       child: Text(
//                         "1st Floor",
//                         style: TextStyle(
//                             fontSize: 16), // Optional: Adjust the text size
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 5),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Color.fromARGB(255, 255, 255, 255),
//                       backgroundColor: floor2Color,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(100)),
//                       fixedSize: Size(100, 100),
//                     ),
//                     onPressed: () {
//                       SwitchFloor(2);
//                       setState(() {
//                         floor2Color = Color(0xff274c77); // Update floor2Color
//                         floor1Color = Color(0xff4f749f); // Update floor1Color
//                         currentFloor = "Floor 2 : "; // Update currentFloor
//                       });
//                     },
//                     child: Center(
//                       // Center the text inside the button
//                       child: Text(
//                         "2nd Floor",
//                         style: TextStyle(
//                             fontSize: 16), // Optional: Adjust the text size
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),

//           // NEW
//           gridArea('c1').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                           child: Image.asset(c1, fit: BoxFit.fill))),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c2').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c2,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC CONFERENCE ROOM");
//                             setState(() {
//                               roomName = "CISC CONFERENCE ROOM";
//                             });
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC TRAINING ROOM");
//                             setState(() {
//                               roomName = "CISC TRAINING ROOM";
//                             });
//                           }
//                         },
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c3').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(c3, fit: BoxFit.fill),
//                         onTap: () {},
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c4').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c4,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 11");
//                             setState(() {
//                               roomName = "CISC LAB 11";
//                             });
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 23");
//                             setState(() {
//                               roomName = "CISC LAB 23";
//                             });
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c5').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                           child: Image.asset(
//                         c5,
//                         fit: BoxFit.fill,
//                       ))),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c6').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c6,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LEC 3");
//                             setState(() {
//                               roomName = "CISC ROOM 3";
//                             });
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 26");
//                             setState(() {
//                               roomName = "CISC LAB 26";
//                             });
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c7').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c7,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             return;
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 22");
//                             setState(() {
//                               roomName = "CISC LAB 22";
//                             });
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c8').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                           child: Image.asset(
//                         c8,
//                         fit: BoxFit.fill,
//                       ))),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c9').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c9,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LEC 2");
//                             setState(() {
//                               roomName = "CISC ROOM 2";
//                             });
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 25");
//                             setState(() {
//                               roomName = "CISC ROOM 25";
//                             });
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c10').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c10,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             return;
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 21");
//                             setState(() {
//                               roomName = "CISC LAB 21";
//                             });
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c11').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                           child: Image.asset(
//                         c11,
//                         fit: BoxFit.fill,
//                       ))),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c12').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c12,
//                           fit: BoxFit.fill,
//                         ),
//                         onTap: () {
//                           if (activeFloor == 1) {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LEC 1");
//                             setState(() {
//                               roomName = "CISC ROOM 1";
//                             });
//                           } else {
//                             Provider.of<CalendarData>(context, listen: false)
//                                 .updateCalendar("CISC LAB 24");
//                             setState(() {
//                               roomName = "CISC LAB 24";
//                             });
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c13').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                         child: Image.asset(
//                           c13,
//                           fit: BoxFit.fill,
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c14').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                           child: Image.asset(
//                         c14,
//                         fit: BoxFit.fill,
//                       ))),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('c15').containing(
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: GestureDetector(
//                           child: Image.asset(
//                         c15,
//                         fit: BoxFit.fill,
//                       ))),
//                 ],
//               ),
//             ),
//           ),
//           gridArea('bw').containing(Container(color: Colors.white)),
//           gridArea('fo').containing(Container(color: Colors.white)),
//         ],
//       ),
//     );
//   }
// }
