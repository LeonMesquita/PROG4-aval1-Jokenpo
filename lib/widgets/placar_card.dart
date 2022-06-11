import 'package:flutter/material.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';

Widget placarCards({required playerScore, required machineScore}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      card(text: 'Você', score: playerScore),
      const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          'X',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
      card(text: 'Máquina', score: machineScore),
    ],
  );
}

Widget card({required String text, required String score}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(text, style: kGameTextStyle),
      ),
      Container(
        decoration: BoxDecoration(
          color: kPlacarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        width: 80,
        child: Center(
          child: Text(
            score,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      )
    ],
  );
}
