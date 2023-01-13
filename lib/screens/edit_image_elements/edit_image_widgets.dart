import 'package:flutter/material.dart';

import '../../states.dart';

class EditActiveButton extends MaterialButton {
  final Widget icon;
  final VoidCallback onPressed;
  final String label;
  bool isActive;

  EditActiveButton({@required this.onPressed, this.icon, this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          child: FlatButton(
            onPressed: onPressed,
            color: isActive ? accentColor : Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: icon,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12
          ),
        ),
      ],
    );
  }
}