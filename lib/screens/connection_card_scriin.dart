import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/entity/card.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/screens/main_screen.dart';
import 'package:pairit/services/api_service.dart';
import 'package:pairit/widgets.dart';
import 'package:provider/provider.dart';

class ConnectedCardScreen extends StatelessWidget {
  final int newCardId;

  ApiService _service = ApiService();

  ConnectedCardScreen({Key key, this.newCardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<BusinessCard>(
        future: _service.getCardById(newCardId),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: [
                Center(
                  child: ElementUtils()
                      .cardElements(
                    viewOnly: true,
                    context: context,
                    elementList: snapshot.data.components,
                    onSelect: () {},
                  )
                      .build(),
                ),
                Positioned(
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: AccentButton(
                          label: 'Add this card',
                          onPressed: () async {
                            // todo add loader

                            print(userState.addedCards.length);
                            _service.addCard(newCardId).then((value) {
                              if (value != null) {

                                userState.addedCards = value;
                                print(userState.addedCards.length);

                                _service.getChatRooms().then((chatRooms) {
                                  userState.chatRooms = chatRooms;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => MainActivityScreen()),
                                );
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: WhiteButton(
                          label: "Cancel",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MainActivityScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
