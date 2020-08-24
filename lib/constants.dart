import 'package:flutter/material.dart';

const double kCanvasSize = 200.0;
const double kStrokeWidth = 12.0;
const Color kBlackBrushColor = Colors.black;
const bool kIsAntiAlias = true;
//mnist database consist on images of 28x28 px where the data is centeres in squares of 20x20 with 4px padding
//that is the next value:
const int kModelInputSize = 28;
//as we define our canvas size as 200x200 without any padding/border, then we need to add
//our "padding", and it will be 40 to mantain the proportion
const double kCanvasInnerOffset = 40.0;

const int kModelNubmerOutputs = 10;
const Color kBarColor = Colors.yellow;
const Color kBarBackgroundColor = Colors.transparent;
const double kChartBarWidth = 22;
