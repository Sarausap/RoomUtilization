import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:room_utilization/calendar.dart';
import 'package:room_utilization/firebase_options.dart';
import 'package:flutter/cupertino.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

class _PietPaintingState extends State<PietPainting> {
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

  void SwitchFloor(int floor) {
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
        ? [3.0.fr,3.0.fr, 3.0.fr, 3.7.fr, 3.fr, 3.fr]
        : [10.0.fr, 10.0.fr];
    final rowSizes = screenSize.width > 600
        ? [ 1.fr, 
            3.0.fr, 
            3.0.fr, 
            3.0.fr, 
            3.0.fr, 
            3.0.fr, 
            1.fr, 
            1.fr]
            
        : [.5.fr, 1.0.fr, 1.0.fr, .5.fr, 1.0.fr, .5.fr];
    final areas = screenSize.width > 600
        ? '''
        hd hd hd hd hd hd 
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
          // gridArea('hd').containing(Container(
          //   color: Colors.white,
          //   child: Container(
          //     alignment: AlignmentDirectional.center,
          //     child: Text(
          //       "CISC 2nd Floor",
          //       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // )),
          gridArea('hd').containing(Container(color: Colors.white)),
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
                    child: Text("2nd Floor",),
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
                  Image.asset(c1),
                ],
              ),
            ),
          ),
          gridArea('c2').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c2),
                ],
              ),
            ),
          ),
          gridArea('c3').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c3),
                ],
              ),
            ),
          ),
          gridArea('c4').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c4),
                ],
              ),
            ),
          ),
          gridArea('c5').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c5),
                ],
              ),
            ),
          ),
          gridArea('c6').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c6),
                ],
              ),
            ),
          ),
          gridArea('c7').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c7),
                ],
              ),
            ),
          ),
          gridArea('c8').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c8),
                ],
              ),
            ),
          ),
          gridArea('c9').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c9),
                ],
              ),
            ),
          ),
          gridArea('c10').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c10),
                ],
              ),
            ),
          ),
          gridArea('c11').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c11),
                ],
              ),
            ),
          ),
          gridArea('c12').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c12),
                ],
              ),
            ),
          ),
          gridArea('c13').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c13),
                ],
              ),
            ),
          ),
          gridArea('c14').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c14),
                ],
              ),
            ),
          ),
          gridArea('c15').containing(
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(c15),
                ],
              ),
            ),
          ),


          //END OF NEW

          gridArea('bw').containing(Container(color: Colors.white)),
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
