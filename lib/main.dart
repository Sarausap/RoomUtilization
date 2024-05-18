import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:provider/provider.dart';
import 'package:room_utilization/calendar.dart';
import 'package:room_utilization/firebase_options.dart';
import 'package:room_utilization/model/semester.dart';
import 'package:room_utilization/notifier.dart';
import 'package:room_utilization/reservation_modal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CalendarData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Layout Grid Desktop Example',
      debugShowCheckedModeBanner: false,
      home: PietPainting(),
    );
  }
}

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color.fromARGB(0, 36, 40, 48);

class PietPainting extends StatefulWidget {
  final Function(String, String)? onRoomUpdated;

  const PietPainting({Key? key, this.onRoomUpdated}) : super(key: key);

  @override
  PietPaintingState createState() => PietPaintingState();
}

/////////////BACK UP OLD FORMAT DONT DELETE////////////////

// gridArea('cf2').containing(
//             Center(
//               child: Stack(
//                 children: [
//                   Image.asset(pathfloor),
//                 ],
//               ),
//             ),
//           ),

////////////END OF BACK UP ///////////////////////////////

class PietPaintingState extends State<PietPainting> {
  String pathfloor = 'assets/images/cisc1stfloor.png';
  String pathfloor2 = 'assets/images/cisc2ndfloor.png';

  //Floors/////////////
  String c1 = 'assets/images/cisc1stf/1.png';
  String c2 = 'assets/images/cisc1stf/2.png';
  String c3 = 'assets/images/cisc1stf/3.png';
  String c4 = 'assets/images/cisc1stf/4.png';
  String c5 = 'assets/images/cisc1stf/5.png';
  String c6 = 'assets/images/cisc1stf/6.png';
  String c7 = 'assets/images/cisc1stf/7.png';
  String c8 = 'assets/images/cisc1stf/8.png';
  String c9 = 'assets/images/cisc1stf/9.png';
  String c10 = 'assets/images/cisc1stf/10.png';
  String c11 = 'assets/images/cisc1stf/11.png';
  String c12 = 'assets/images/cisc1stf/12.png';
  String c13 = 'assets/images/cisc1stf/13.png';
  String c14 = 'assets/images/cisc1stf/14.png';
  String c15 = 'assets/images/cisc1stf/15.png';

  int currentFloor = 1;
  String? _selectedValue;

  void SwitchFloor(int floor) {
    currentFloor = floor;
    setState(() {
      if (floor == 1) {
        c1 = 'assets/images/cisc1stf/1.png';
        c2 = 'assets/images/cisc1stf/2.png';
        c3 = 'assets/images/cisc1stf/3.png';
        c4 = 'assets/images/cisc1stf/4.png';
        c5 = 'assets/images/cisc1stf/5.png';
        c6 = 'assets/images/cisc1stf/6.png';
        c7 = 'assets/images/cisc1stf/7.png';
        c8 = 'assets/images/cisc1stf/8.png';
        c9 = 'assets/images/cisc1stf/9.png';
        c10 = 'assets/images/cisc1stf/10.png';
        c11 = 'assets/images/cisc1stf/11.png';
        c12 = 'assets/images/cisc1stf/12.png';
        c13 = 'assets/images/cisc1stf/13.png';
        c14 = 'assets/images/cisc1stf/14.png';
        c15 = 'assets/images/cisc1stf/15.png';
      } else {
        c1 = 'assets/images/cisc2ndf/1.png';
        c2 = 'assets/images/cisc2ndf/2.png';
        c3 = 'assets/images/cisc2ndf/3.png';
        c4 = 'assets/images/cisc2ndf/4.png';
        c5 = 'assets/images/cisc2ndf/5.png';
        c6 = 'assets/images/cisc2ndf/6.png';
        c7 = 'assets/images/cisc2ndf/7.png';
        c8 = 'assets/images/cisc2ndf/8.png';
        c9 = 'assets/images/cisc2ndf/9.png';
        c10 = 'assets/images/cisc2ndf/10.png';
        c11 = 'assets/images/cisc2ndf/11.png';
        c12 = 'assets/images/cisc2ndf/12.png';
        c13 = 'assets/images/cisc2ndf/13.png';
        c14 = 'assets/images/cisc2ndf/14.png';
        c15 = 'assets/images/cisc2ndf/15.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final columnSizes = screenSize.width > 600
        ? [3.0.fr, 3.0.fr, 3.0.fr, 3.7.fr, 3.fr, 3.fr]
        : [10.0.fr, 10.0.fr];
    final rowSizes = screenSize.width > 600
        ? [1.fr, 3.0.fr, 3.0.fr, 3.0.fr, 3.0.fr, 3.0.fr, 1.fr, 1.fr]
        : [.5.fr, 1.0.fr, 1.0.fr, .5.fr, 1.0.fr, .5.fr];
    final areas = screenSize.width > 600
        ? '''
        hd hd hd na se se
        c1 c2 c3 ca ca ca
        c4 c5 c6 ca ca ca
        c7 c8 c9 ca ca ca
        c10 c11 c12 ca ca ca
        c13 c14 c15 ca ca ca
        fl fl fl bw bw bw
        fo fo fo fo fo fo
        '''
        : '''
        hd hd
        cf2 cf2
        cf2 cf2
        fl fl
        ca ca
        fo fo
        ''';

    Future<Semester?> fetchsemester() async {
      return await Semester.getSemester();
    }

    void showModalExample(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReservationModal();
        },
      );
    }

    return Container(
      color: background,
      child: LayoutGrid(
        columnGap: 0,
        rowGap: 0,
        areas: areas,
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        children: [
          gridArea('ca').containing(CalendarWidget()),
          gridArea('hd').containing(Container(color: Colors.white)),
          gridArea('na').containing(Container(
              width: 200,
              color: Colors.white,
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalExample(context);
                },
                icon: Icon(Icons.add),
                label: Text('New Reservation'),
              ))),
          gridArea('se').containing(Container(
              width: double.infinity,
              child: Material(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 300,
                      child: FutureBuilder<List<Semester?>>(
                        future: Semester.fetchAllSemesters(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Semester?>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            String? _selectedValue =
                                snapshot.data![0]?.semester_name ?? '';
                            return DropdownButton<String>(
                              value: _selectedValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              onChanged: (String? newValue) {
                                print(newValue);
                                setState(() {
                                  _selectedValue = newValue;
                                });
                                print(_selectedValue);
                              },
                              items: snapshot.data!
                                  .map<DropdownMenuItem<String>>(
                                      (Semester? semester) {
                                    // Check if semester is not null before accessing properties
                                    if (semester != null) {
                                      return DropdownMenuItem<String>(
                                        value: semester.semester_name,
                                        child: Text(semester.semester_name),
                                      );
                                    }
                                    return DropdownMenuItem(
                                        child: Text(
                                            '')); // Return an empty item if semester is null
                                  })
                                  .where((item) => item.value!
                                      .isNotEmpty) // Filter out any empty items
                                  .toList(),
                            );
                          } else {
                            return Text(
                                'No semesters found.'); // Handle case where no data is returned
                          }
                        },
                      )),
                ],
              )))),
          gridArea('fl').containing(Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromARGB(255, 30, 23, 104),
                    ),
                    onPressed: () {
                      SwitchFloor(1);
                    },
                    child: Text("1st Floor"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromARGB(255, 30, 23, 104),
                    ),
                    onPressed: () {
                      SwitchFloor(2);
                    },
                    child: Text(
                      "2nd Floor",
                    ),
                  ),
                ),
              ],
            ),
          )),

          // NEW
          gridArea('c1').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(child: GestureDetector(child: Image.asset(c1))),
                ],
              ),
            ),
          ),
          gridArea('c2').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c2),
                    onTap: () => currentFloor == 1
                        ? Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC CONFERENCE ROOM", "OeuPodVAHxh2AKNQWU77")
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC EVENT ROOM", "OeuPodVAHxh2AKNQWU77"),
                  ))
                ],
              ),
            ),
          ),
          gridArea('c3').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c3),
                    onTap: () {},
                  )),
                ],
              ),
            ),
          ),
          gridArea('c4').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c4),
                    onTap: () => currentFloor == 1
                        ? Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 11", "OeuPodVAHxh2AKNQWU77")
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 23", "OeuPodVAHxh2AKNQWU77"),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c5').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(child: GestureDetector(child: Image.asset(c5))),
                ],
              ),
            ),
          ),
          gridArea('c6').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c6),
                    onTap: () => currentFloor == 1
                        ? Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LEC 3", "OeuPodVAHxh2AKNQWU77")
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 26", "OeuPodVAHxh2AKNQWU77"),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c7').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c7),
                    onTap: () => currentFloor == 1
                        ? Null
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 22", "OeuPodVAHxh2AKNQWU77"),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c8').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(child: GestureDetector(child: Image.asset(c8))),
                ],
              ),
            ),
          ),
          gridArea('c9').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c9),
                    onTap: () => currentFloor == 1
                        ? Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LEC 2", "OeuPodVAHxh2AKNQWU77")
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 25", "OeuPodVAHxh2AKNQWU77"),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c10').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c10),
                    onTap: () => currentFloor == 2
                        ? Null
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 21", "OeuPodVAHxh2AKNQWU77"),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c11').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(child: GestureDetector(child: Image.asset(c11))),
                ],
              ),
            ),
          ),
          gridArea('c12').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c12),
                    onTap: () => currentFloor == 1
                        ? Null
                        : Provider.of<CalendarData>(context, listen: false)
                            .updateCalendar(
                                "CISC LAB 24", "OeuPodVAHxh2AKNQWU77"),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c13').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    child: Image.asset(c13),
                  )),
                ],
              ),
            ),
          ),
          gridArea('c14').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(child: GestureDetector(child: Image.asset(c14))),
                ],
              ),
            ),
          ),
          gridArea('c15').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(child: GestureDetector(child: Image.asset(c15))),
                ],
              ),
            ),
          ),
          gridArea('bw').containing(Container(color: Colors.white)),
          gridArea('fo').containing(Container(color: Colors.white)),
        ],
      ),
    );
  }
}
