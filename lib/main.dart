import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

void main() {
  runApp(const MyApp());
}

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color.fromARGB(0, 36, 40, 48);

class PietPainting extends StatelessWidget {
  const PietPainting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: LayoutGrid(
        columnGap: 2,
        rowGap: 2,
        areas: '''
          w w g g
          cf2 cf2 g g
          cf2 cf2 g g
          ww ww g g
        ''',
        // A number of extension methods are provided for concise track sizing
        columnSizes: [1.0.fr, 1.0.fr, 1.0.fr, 2.2.fr],
        rowSizes: [
          .5.fr,
          1.0.fr,
          1.0.fr,
          .5.fr
        ],
        children: [
          // Column 1
          gridArea('r').containing(Container(color: cellRed)),
          gridArea('y').containing(Container(color: cellMustard)),
          // Column 2
          gridArea('R').containing(Container(color: cellRed)),
          // Column 3
          gridArea('B').containing(Container(color: cellBlue)),
          gridArea('Y').containing(Container(color: cellMustard)),
          gridArea('g').containing(Container(color: cellGrey)),
          // Column 4
          gridArea('b').containing(Container(color: cellBlue)),
          // Column 5
          gridArea('yy').containing(Container(color: cellMustard)),
          //new
          gridArea('g').containing(Container(color: Colors.green)),
          gridArea('w').containing
            (Container(
              color: Colors.white,
              child: Container(
                alignment: AlignmentDirectional.center,
                child: Text("CISC 2nd Floor",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),),
              ),)),
          gridArea('ww').containing(Container(color: Colors.white)),

          //image
          gridArea('cf2').containing(
            Stack(
              children: [
                Image.asset('assets/images/cisc2ndfloorv2.png'),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'Layout Grid Desktop Example',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      builder: (context, child) => const PietPainting(),
    );
  }
}