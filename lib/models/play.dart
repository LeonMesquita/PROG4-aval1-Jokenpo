import 'package:prog4_aval1_jokenpo/constants.dart';

class Play {
  String imagePath;
  String playName;

  Play({required this.imagePath, required this.playName});
}

List<Play> options = [
  Play(imagePath: kStone, playName: "pedra"),
  Play(imagePath: kPaper, playName: "papel"),
  Play(imagePath: kScissor, playName: "tesoura"),
];
