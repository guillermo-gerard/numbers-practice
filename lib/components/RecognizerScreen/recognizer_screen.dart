import 'package:flutter/material.dart';
import '../../constants.dart';
import 'drawing_painter.dart';
import 'package:confetti/confetti.dart';

class RecognizerScreen extends StatefulWidget {
  RecognizerScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecognizerScreen createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<RecognizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                alignment: Alignment.center,
                child: Text('Header'),
              ),
            ),
            DrawBox(),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text('Footer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawBox extends StatefulWidget {
  @override
  _DrawBoxState createState() => _DrawBoxState();
}

class _DrawBoxState extends State<DrawBox> {
  List<Offset> points = List();
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _confettiX = 0.0;
    var _confettiY = 0.0;

    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(
          width: 3.0,
          color: Colors.yellow,
        ),
      ),
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                points.add(renderBox.globalToLocal(details.globalPosition));
                _confettiX = details.globalPosition.dx;
                _confettiY = details.globalPosition.dy;
                _confettiController.play();
              });
            },
            onPanStart: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                points.add(renderBox.globalToLocal(details.globalPosition));
              });
            },
            onPanEnd: (details) {
              setState(() {
                points.add(null);
              });
            },
            // onTap: () {
            //   //_confettiController.play();
            // },
            child: Stack(children: <Widget>[
              ClipRect(
                child: CustomPaint(
                  size: Size(kCanvasSize, kCanvasSize),
                  painter: DrawingPainter(
                    offsetPoints: points,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(_confettiX, _confettiY),
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      false, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
