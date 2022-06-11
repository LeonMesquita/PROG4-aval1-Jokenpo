import 'package:flutter/material.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';

import 'play_button.dart';

Widget versusCards(
    {required String playerImage, required String machineImage}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      cardWidget(playerImage, 'Você'),
      SizedBox(
        width: 70,
        child: Image.asset('assets/images/vs.png'),
      ),
      cardWidget(machineImage, 'Máquina'),
    ],
  );
}

Widget cardWidget(image, player) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 30),
    child: Column(
      children: [
        Text(player, style: kGameTextStyle),
        playButton(
          imagePath: image,
          ontap: () {},
          color: Colors.blue.shade600,
          width: 150,
          height: 150,
        ),
      ],
    ),
  );
}
