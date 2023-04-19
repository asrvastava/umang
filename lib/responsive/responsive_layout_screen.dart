import 'package:flutter/material.dart';
import 'package:umang/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileCreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.mobileCreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreenLayout;
        } else {
          return mobileCreenLayout;
        }
      },
    );
  }
}
