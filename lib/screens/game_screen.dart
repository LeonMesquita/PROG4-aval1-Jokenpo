import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';
import 'package:prog4_aval1_jokenpo/models/player.dart';
import 'package:prog4_aval1_jokenpo/widgets/placar_card.dart';
import 'package:prog4_aval1_jokenpo/widgets/versus_cards.dart';
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
  String playerImage = kInterrogImage;

  String machineLabel = kMachineLabel;
  String playerLabel = kPlayerLabel;
  String selectedButton = "";

  void selectPlay(play) {
    String selectedPlay = setPlayName(play);
    setState(() {
      selectedButton = play;
      playerImage = play;
      player.setPlay(selectedPlay);
      setMachinePlay();
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

//Função que impede que a máquina escolha pedra duas vezes seguidas
  void setMachinePlay() {
    String machinePlay = "";

    while (true) {
      plays.shuffle();
      machinePlay = setPlayName(plays[0]);
      machineImage = plays[0];
      if (machine.selectedStones < 1) {
        machine.setPlay(machinePlay);
        break;
      } else if (machinePlay != "pedra") {
        machine.setPlay(machinePlay);
        machine.resetStonesCount();
        break;
      } else {}
    }
  }

  String checkPlays(playerPlay, machinePlay) {
    String result = "";
    setState(() {
      if (player.playedTwoStones()) {
        result = "Você escolheu pedra duas vezes seguidas! O App venceu.";
        machine.incrementPoints();
      } else {
        if ((playerPlay == "pedra" && machinePlay == "tesoura") ||
            (playerPlay == "papel" && machinePlay == "pedra") ||
            (playerPlay == "tesoura" && machinePlay == "papel")) {
          player.incrementPoints();
          result = kVictoryMessage;
        } else if (playerPlay == machinePlay) {
          result = "Empate!";
        } else {
          machine.incrementPoints();
          result = kDefeatMessage;
        }
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
      playerImage = kInterrogImage;
      selectedButton = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('jokenpô'),
      ),
      body: Column(
        children: [
          versusCards(playerImage: playerImage, machineImage: machineImage),
          Text(
            playerLabel,
            style: kGameTextStyle,
            textAlign: TextAlign.center,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Placar:',
                  style: kGameTextStyle,
                ),
                placarCards(
                    playerScore: player.getPoints(),
                    machineScore: machine.getPoints()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
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
