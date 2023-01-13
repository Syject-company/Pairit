import 'package:flutter/material.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../states.dart';
import 'card_editor.dart';
import 'edit_body_widget/select_card_template_portrait.dart';
import 'select_card_template.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStates = Provider.of<UserProvider>(context);
    var states = AppStates(context);
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Align(
            alignment: Alignment.center,
            child: userStates.personalCard == null ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SelectCardTemplate()));
              },
              child: Container(
                height: states.cardHeight,
                width: states.cardWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(states.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 120,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ) : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardEditor(),
                  ),
                );
              },
              child: ElementUtils()
                  .cardElements(
                viewOnly: true,
                context: context,
                elementList: userStates.personalCard.components,
                onSelect: () {},
              )
                  .build(),
            ),
          ),
        ),
      ),
    );
  }
}