import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:number_trainer/I18n/my_localizations.dart';
import '../../constants.dart';
import 'drawing_painter.dart';
import 'package:number_trainer/Processes/number_recognizer_process.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' show Random;

class RecognizerScreen extends StatefulWidget {
  RecognizerScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecognizerScreen createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<RecognizerScreen> {
  List<Offset> points = List();
  NumberRecognizerProcess numberRecognizer = NumberRecognizerProcess();
  List<BarChartGroupData> chartItems = List();
  String headerText = 'Header placeholder';
  String footerText = 'Footer placeholder';
  var randomizer = new Random();
  int secretNumber;

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    numberRecognizer.loadModel();
    SchedulerBinding.instance.addPostFrameCallback((_) => initGame());
  }

  void initGame() async {
    _restartGame(context);
    //List<dynamic> languages = await flutterTts.getLanguages;
    var local = MyLocalizations.of(context).local;
    await flutterTts.setLanguage(
        await flutterTts.isLanguageAvailable(local) ? local : "en-US");
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.cyan[600],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  headerText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Container(
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
                        points.add(
                            renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanStart: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject();
                        points.add(
                            renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanEnd: (details) async {
                      points.add(null);
                    },
                    child: ClipRect(
                      child: CustomPaint(
                        size: Size(kCanvasSize, kCanvasSize),
                        painter: DrawingPainter(
                          offsetPoints: points,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.yellow,
                    child: IconButton(
                        icon: Icon(Icons.check_circle_outline),
                        color: Colors.green[600],
                        iconSize: 32,
                        onPressed: () async {
                          List predictions = await numberRecognizer
                              .processCanvasPoints(points);
                          setState(() {
                            print(predictions);
                            if (predictions.first['confidence'] > 0.99995 &&
                                predictions.first['index'] == secretNumber) {
                              headerText = MyLocalizations.of(context).excelent;
                            } else {
                              headerText =
                                  MyLocalizations.of(context).tryAgain +
                                      getSecretNumberText(secretNumber);
                            }
                            flutterTts.speak(headerText);
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.yellow,
                    child: IconButton(
                        icon: Icon(Icons.delete_outline),
                        color: Colors.red,
                        iconSize: 32,
                        onPressed: () async {
                          _restartGame(context);
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _restartGame(BuildContext context) {
    secretNumber = randomizer.nextInt(10);
    var secretNumberText = getSecretNumberText(secretNumber);
    this._resetLabels(context, secretNumberText);
    _cleanDrawing(context);
  }

  void _resetLabels(BuildContext context, String secretNumber) async {
    var headerTextNoNumber = MyLocalizations.of(context).couldYouDrawANumber_;
    headerText = headerTextNoNumber + secretNumber.toUpperCase() + "?";
    flutterTts.speak(headerText);
  }

  void _cleanDrawing(BuildContext context) {
    setState(() {
      points = List();
    });
  }

  String getSecretNumberText(int secretNumber) {
    switch (secretNumber) {
      case 0:
        return MyLocalizations.of(context).zero;
      case 1:
        return MyLocalizations.of(context).one;
      case 2:
        return MyLocalizations.of(context).two;
      case 3:
        return MyLocalizations.of(context).three;
      case 4:
        return MyLocalizations.of(context).four;
      case 5:
        return MyLocalizations.of(context).five;
      case 6:
        return MyLocalizations.of(context).six;
      case 7:
        return MyLocalizations.of(context).seven;
      case 8:
        return MyLocalizations.of(context).eight;
      case 9:
        return MyLocalizations.of(context).nine;
      default:
        return MyLocalizations.of(context).zero;
    }
  }
}
