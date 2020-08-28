import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class MyConfettiWidget extends StatelessWidget {
  const MyConfettiWidget(this._blastDirection, this._alignement,
      {Key key, @required ConfettiController confettiController})
      : _confettiController = confettiController,
        super(key: key);

  final ConfettiController _confettiController;
  final double _blastDirection;
  final Alignment _alignement;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _alignement, //Alignment.bottomRight,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: _blastDirection, //4 * pi / 3,
        emissionFrequency: 0.6,
        minimumSize: const Size(10,
            10), // set the minimum potential size for the confetti (width, height)
        maximumSize: const Size(25,
            25), // set the maximum potential size for the confetti (width, height)
        numberOfParticles: 1,
        gravity: 0.1,
      ),
    );
  }
}
