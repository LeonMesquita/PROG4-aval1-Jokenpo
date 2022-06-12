import 'package:flutter/material.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';

import 'play_button.dart';

class VersusCard extends StatelessWidget {
  String playerImage;
  String machineImage;
  VersusCard({Key? key, required this.machineImage, required this.playerImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardWidth = size.width * .38;
    var cardHeight = size.height * .2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        cardWidget(
            image: playerImage,
            player: 'Você',
            width: cardWidth,
            height: cardHeight),
        SizedBox(
          width: size.width * .17,
          child: Image.asset('assets/images/vs.png'),
        ),
        cardWidget(
            image: machineImage,
            player: 'Máquina',
            width: cardWidth,
            height: cardHeight),
      ],
    );
  }
}

Widget cardWidget(
    {image, player, required double width, required double height}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 30),
    child: Column(
      children: [
        Text(player, style: kGameTextStyle),
        playButton(
          imagePath: image,
          ontap: () {},
          color: Colors.blue.shade600,
          width: width,
          height: height,
        ),
      ],
    ),
  );
}
