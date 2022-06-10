import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prog4_aval1_jokenpo/constants.dart';
import 'package:prog4_aval1_jokenpo/screens/game_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jokenpô',
          style: kInitialScreenTextStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.purple.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 300,
              // height: 500,

              child: Image.asset(
                'assets/images/jokenpo.png',
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    iconSize: 150,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const GameScreen()));
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Play',
                    style: kInitialScreenTextStyle,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Desenvolvido por:\n Leonardo Evangelista Mesquita, Marcos Vinicius dos Santos Dantas, Arthur Oliveira de Souza',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
