
import 'package:flutter/material.dart';
import 'package:pairit/entity/card_components.dart';

import '../card_element.dart';
import '../states.dart';
import 'edit_body_widget/edit_body_landscape.dart';
import 'edit_body_widget/edit_body_portrait.dart';

class CardEditor extends StatelessWidget {

  CardEditor();

  AppStates _states;

  @override
  Widget build(BuildContext context) {
    _states = AppStates(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: _states.isPortrait ? EditBodyPortrait() : EditBodyLandscape(),
      ),
    );
  }
}
