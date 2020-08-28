import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  final IconData _iconButton;
  final VoidCallback _executeOnTap;
  final Color _iconColor;

  const CircleButtonWidget(
    this._executeOnTap,
    this._iconButton,
    this._iconColor, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.yellow,
        child: IconButton(
            icon: Icon(_iconButton),
            color: _iconColor,
            iconSize: 32,
            onPressed: () async {
              _executeOnTap();
            }),
      ),
    );
  }
}
