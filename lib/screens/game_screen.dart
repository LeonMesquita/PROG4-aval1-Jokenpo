import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';
import 'package:prog4_aval1_jokenpo/models/player.dart';
import 'dart:math';

import '../widgets/play_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> plays = [kStone, kPaper, kScissor];
  Player player = Player();
  Player machine = Player();
  String machineImage = kInterrogImage;
  String machineLabel = kMachineLabel;
  String playerLabel = kPlayerLabel;

  String selectedButton = "";

  void selectPlay(play) {
    String selectedPlay = setPlayName(play);
    setState(() {
      selectedButton = play;

      player.setPlay(selectedPlay);
      plays.shuffle();
      String machinePlay = setPlayName(plays[0]);
      machineImage = plays[0];
      machine.setPlay(machinePlay);
      debugPrint(machine.getPlay());
      machineLabel = "Escolha do app:";
      playerLabel = checkPlays(player.getPlay(), machine.getPlay());
    });
  }

  String setPlayName(play) {
    if (play == kStone) {
      return "pedra";
    } else if (play == kPaper) {
      return "papel";
    } else {
      return "tesoura";
    }
  }

  String checkPlays(playerPlay, machinePlay) {
    String result = "";
    setState(() {
      if ((playerPlay == "pedra" && machinePlay == "tesoura") ||
          (playerPlay == "papel" && machinePlay == "pedra") ||
          (playerPlay == "tesoura" && machinePlay == "papel")) {
        player.resetStones();
        player.incrementPoints();
        result = kVictoryMessage;
      } else if (playerPlay == machinePlay) {
        if (playerPlay == "pedra") {
          player.incrementStones();
          result = player.checkStonesPlayed() ? "Você perdeu! :(" : "Empate!";
        } else if (machinePlay == "pedra") {
          machine.incrementStones();
          result = player.checkStonesPlayed() ? "Você venceu! :)" : "Empate!";
        } else {
          result = "Empate!";
        }
      } else {
        machine.resetStones();
        machine.incrementPoints();
        result = kDefeatMessage;
      }
    });

    return result;
  }

  void resetGame() {
    setState(() {
      player = Player();
      machine = Player();
      machineLabel = kMachineLabel;
      playerLabel = kPlayerLabel;
      machineImage = kInterrogImage;
      selectedButton = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('jokenpô'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              machineLabel,
              style: kGameTextStyle,
            ),
          ),
          playButton(
              imagePath: machineImage, ontap: () {}, color: kStandardColor),
          Text(
            playerLabel,
            style: kGameTextStyle,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              playButton(
                  imagePath: kStone,
                  color:
                      selectedButton == kStone ? kActiveColor : kStandardColor,
                  ontap: () {
                    selectPlay(kStone);
                  }),
              playButton(
                  imagePath: kPaper,
                  color:
                      selectedButton == kPaper ? kActiveColor : kStandardColor,
                  ontap: () {
                    selectPlay(kPaper);
                  }),
              playButton(
                  imagePath: kScissor,
                  color: selectedButton == kScissor
                      ? kActiveColor
                      : kStandardColor,
                  ontap: () {
                    selectPlay(kScissor);
                  }),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Partidas ganhas pelo jogador: ${player.getPoints()}',
                  style: kGameTextStyle,
                ),
                Text(
                  'Partidas ganhas pela máquina: ${machine.getPoints()}',
                  style: kGameTextStyle,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: resetGame,
                      child: const Text(
                        'Reiniciar',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
