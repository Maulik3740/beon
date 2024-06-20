import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ads_web/constant/Constant.dart';
import 'package:super_ads_web/constant/Screen.dart';

class TaskProgressCard extends StatelessWidget {
  const TaskProgressCard({
    super.key,
    required this.colorData,
    required this.textfield,
    required this.context,
    required this.image
  });

  final Color colorData;
  final String textfield;
  final BuildContext context;
  final String image;

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Column(
      children: [
        Container(
          height: s.isDesktop ? 220 * s.customWidth : 400 * s.customWidth,
          width: s.isDesktop ? 220 * s.customWidth : 400 * s.customWidth,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: colorData,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Lottie.asset(
            image,
          ),
        ),
        SizedBox(
          height: .01 * s.width,
        ),
        Text(
          textfield,
          style: GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}