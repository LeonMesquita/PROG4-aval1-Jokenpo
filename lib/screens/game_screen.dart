import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prog4_aval1_jokenpo/constantes.dart';
import 'package:prog4_aval1_jokenpo/models/player.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> plays = [kStone, kPaper, kScissor];
  Player player = Player();
  Player machine = Player();
  String machineImage = 'assets/images/interrog.png';
  String machineLabel = "Máquina";
  String playerLabel = 'Escolha uma jogada:';

  void selectPlay(play) {
    String selectedPlay = setPlayName(play);
    setState(() {
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
        result = "Você venceu! :)";
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
        result = "Você perdeu! :(";
      }
    });

    return result;
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
            padding: EdgeInsets.only(top: 30),
            child: Text(
              machineLabel,
              style: kGameTextStyle,
            ),
          ),
          playButton(imagePath: machineImage, ontap: () {}),
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
                  ontap: () {
                    selectPlay(kStone);
                  }),
              playButton(
                  imagePath: kPaper,
                  ontap: () {
                    selectPlay(kPaper);
                  }),
              playButton(
                  imagePath: kScissor,
                  ontap: () {
                    selectPlay(kScissor);
                  }),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Partidas ganhas pelo jogador: ${player.getPoints()}'),
                Text('Partidas ganhas pela máquina: ${machine.getPoints()}'),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Jogar',
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

Widget playButton({required String imagePath, required Function() ontap}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, bottom: 30),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(imagePath),
        ),
      ),
    ),
  );
}
