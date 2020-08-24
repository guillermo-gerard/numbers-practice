import 'package:flutter/material.dart';
import 'package:number_trainer/I18n/my_localizations.dart';
import '../../constants.dart';
import 'drawing_painter.dart';
import 'package:number_trainer/Processes/number_recognizer_process.dart';
import 'package:fl_chart/fl_chart.dart';

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

  @override
  void initState() {
    super.initState();
    numberRecognizer.loadModel();
    _buildBarChartInfo();
    () async {
      await Future.delayed(Duration.zero);
      _resetLabels(context);
    }();
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
                    onPanEnd: (details) {
                      setState(() async {
                        points.add(null);
                        List predictions =
                            await numberRecognizer.processCanvasPoints(points);
                        print(predictions);
                        setState(() {
                          _buildBarChartInfo(recognitions: predictions);
                          _setLabelsForGuess(predictions.first['label']);
                        });
                      });
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 64),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Center(
                        child: Text(
                          footerText,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(32, 32, 32, 16),
                          child: BarChart(
                            BarChartData(
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 6,
                                    getTitles: (double value) {
                                      return value.toInt().toString();
                                    }),
                                leftTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              barGroups: chartItems,
                              // read about it in the below section
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cleanDrawing(context);
        },
        tooltip: 'Clean',
        child: Icon(Icons.delete),
      ),
    );
  }

  void _cleanDrawing(BuildContext context) {
    setState(() {
      points = List();
      _buildBarChartInfo();
      _resetLabels(context);
    });
  }

  void _resetLabels(BuildContext context) {
    headerText = MyLocalizations.of(context).drawNumberInBox;
    footerText = MyLocalizations.of(context).letMeGuess;
  }

  void _setLabelsForGuess(String guess) {
    headerText = ""; // Empty string
    footerText = MyLocalizations.of(context).theNumberYouDrawIs + guess;
  }

  void _buildBarChartInfo({List recognitions = const []}) {
    // Reset the list
    chartItems = List();

    // Create as many barGroups as outputs our prediction has
    for (var i = 0; i < kModelNubmerOutputs; i++) {
      var barGroup = _makeGroupData(i, 0);
      chartItems.add(barGroup);
    }

    // For each one of our predictions, attach the probability
    // to the right index
    for (var recognition in recognitions) {
      final idx = recognition["index"];
      if (0 <= idx && idx <= 9) {
        final confidence = recognition["confidence"];
        chartItems[idx] = _makeGroupData(idx, confidence);
      }
    }
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: y,
        color: kBarColor,
        width: kChartBarWidth,
        //       isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 1,
          color: kBarBackgroundColor,
        ),
      ),
    ]);
  }
}
