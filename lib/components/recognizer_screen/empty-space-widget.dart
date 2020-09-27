import 'package:flutter/material.dart';

class EmptySpaceWidget extends StatelessWidget {
  const EmptySpaceWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(),
    );
  }
}
