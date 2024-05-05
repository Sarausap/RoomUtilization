import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:room_utilization/calendar.dart'; // Ensure this import is correct

void main() {
  runApp(const MyApp());
}

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color.fromARGB(0, 36, 40, 48);

class PietPainting extends StatefulWidget {
  const PietPainting({Key? key}) : super(key: key);

  @override
  _PietPaintingState createState() => _PietPaintingState();
}

class _PietPaintingState extends State<PietPainting> {
  String path = 'assets/images/cisc2ndfloorv2.png';

  void SwitchFloor(int floor) {
    setState(() {
      if (floor == 1) {
        path = 'assets/images/cisck2ndfloor.png';
      } else {
        path = 'assets/images/cisc2ndfloorv2.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final columnSizes = screenSize.width > 600
        ? [2.0.fr, 2.0.fr, 1.fr, 3.fr, 3.fr]
        : [10.0.fr, 10.0.fr];
    final rowSizes = screenSize.width > 600
        ? [.5.fr, 3.0.fr, 3.0.fr, .5.fr]
        : [.5.fr, 1.0.fr, 1.0.fr, .5.fr, 1.0.fr, .5.fr];
    final areas = screenSize.width > 600
        ? '''
        hd hd hd hd hd
        cf2 cf2 fl ca ca
        cf2 cf2 fl ca ca
        fo fo fo fo fo
        '''
        : '''
        hd hd
        cf2 cf2
        cf2 cf2
        fl fl
        ca ca
        fo fo
        ''';

    return Container(
      color: background,
      child: LayoutGrid(
        columnGap: 0,
        rowGap: 2,
        areas: areas,
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        children: [
          gridArea('ca').containing(CalendarWidget()),
          gridArea('hd').containing(Container(
            color: Colors.white,
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text(
                "CISC 2nd Floor",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          gridArea('hd').containing(Container(color: Colors.white)),
          gridArea('fl').containing(Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    SwitchFloor(1);
                  },
                  child: Text("1"),
                ),
                TextButton(
                  onPressed: () {
                    SwitchFloor(2);
                  },
                  child: Text("2"),
                ),
              ],
            ),
          )),
          gridArea('cf2').containing(
            Stack(
              children: [
                Image.asset(path),
              ],
            ),
          ),
          gridArea('fo').containing(Container(color: Colors.white)),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Grid Desktop Example',
      debugShowCheckedModeBanner: false,
      home: const PietPainting(),
    );
  }
}
