import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class backroundwidget extends StatelessWidget {
  const backroundwidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'images/background.svg',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
