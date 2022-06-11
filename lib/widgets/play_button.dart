import 'package:flutter/material.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';

Widget playButton(
    {required String imagePath,
    required Function() ontap,
    Color? color,
    double? width,
    double? height}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 60),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
        width: width != null ? width : 100,
        height: height != null ? height : 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset(imagePath),
        ),
      ),
    ),
  );
}
