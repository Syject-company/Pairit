import 'package:flutter/material.dart';
import 'package:pairit/screens/edit_body_widget/select_card_template_landscape.dart';

import '../states.dart';
import 'edit_body_widget/select_card_template_portrait.dart';

class SelectCardTemplate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var _states = AppStates(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: _states.isPortrait ? SelectCardTemplatePortrait() : SelectCardTemplateLandscape(),
      ),
    );
  }
}