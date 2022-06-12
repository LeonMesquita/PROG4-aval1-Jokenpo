import 'package:flutter/material.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';
import 'package:prog4_aval1_jokenpo/models/play.dart';
import 'package:prog4_aval1_jokenpo/models/player.dart';
import 'package:prog4_aval1_jokenpo/widgets/placar_card.dart';
import 'package:prog4_aval1_jokenpo/widgets/versus_cards.dart';
import '../widgets/play_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Play> optionsList = [...options];
  List<Play> plays = [...options];
  Player player = Player();
  Player machine = Player();
  String machineImage = kInterrogImage;
  String playerImage = kInterrogImage;
  String machineLabel = kMachineLabel;
  String resultLabel = kPlayerLabel;
  String selectedButton = "";

  void selectPlay(playImage, playName) {
    setState(() {
      selectedButton = playName;
      playerImage = playImage;
      player.setPlay(playName);
      setMachinePlay();
      machineLabel = "Escolha do app:";
      resultLabel = checkPlays(player.getPlay(), machine.getPlay());
    });
  }

//Função que impede que a máquina escolha pedra duas vezes seguidas
  void setMachinePlay() {
    String machinePlay = "";
    while (true) {
      /*
        Para a máquina escolher uma jogada aleatória, nós tentamos sortear um número entre 0 e 2
        e então pegar o elemento desse índice da lista, mas nós notamos que a variação
        era muito pouca, caia quase sempre na mesma jogada.
        Então nós percebemos que tem uma variação de jogadas muito maior se embaralharmos
        a lista de opções e pegar a opção de índice 0;
     */
      plays.shuffle();
      machinePlay = plays[0].playName;
      machineImage = plays[0].imagePath;
      if (machine.selectedStones < 1) {
        machine.setPlay(machinePlay);
        break;
      } else if (machinePlay != "pedra") {
        machine.setPlay(machinePlay);
        machine.resetStonesCount();
        break;
      }
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
      resultLabel = kPlayerLabel;
      machineImage = kInterrogImage;
      playerImage = kInterrogImage;
      selectedButton = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Lista de botões das jogadas

    final buttonsList = List<PlayButton>.generate(
      optionsList.length,
      (index) => PlayButton(
        imagePath: optionsList[index].imagePath,
        ontap: () {
          selectPlay(optionsList[index].imagePath, optionsList[index].playName);
        },
        color: selectedButton == optionsList[index].playName
            ? kActiveColor
            : kStandardColor,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('jokenpô'),
      ),
      body: Column(
        children: [
          versusCards(playerImage: playerImage, machineImage: machineImage),
          Text(
            resultLabel,
            style: kGameTextStyle,
            textAlign: TextAlign.center,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...buttonsList,
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
