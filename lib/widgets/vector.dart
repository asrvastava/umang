import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VectorsWidget extends StatefulWidget {
  @override
  _VectorsWidgetState createState() => _VectorsWidgetState();
}

class _VectorsWidgetState extends State<VectorsWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator VectorsWidget - GROUP

    return Container(
        width: 1302,
        height: 111,
        child: Stack(children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child:
                SvgPicture.asset('assets/vector.svg', semanticsLabel: 'vector'),
          ),
          Positioned(
            top: 0,
            left: 22,
            child: SvgPicture.asset('assets/vector1.svg',
                semanticsLabel: 'vector'),
          ),
        ]));
  }
}
