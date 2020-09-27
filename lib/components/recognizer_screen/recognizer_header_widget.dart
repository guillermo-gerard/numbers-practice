import 'package:flutter/material.dart';

class RecognizerHeader extends StatelessWidget {
  const RecognizerHeader({
    Key key,
    @required this.headerText,
  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
