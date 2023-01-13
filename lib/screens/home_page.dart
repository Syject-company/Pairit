import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/screens/main_screen.dart';
import 'package:pairit/services/api_service.dart';
import 'package:pairit/states.dart';
import 'package:provider/provider.dart';

import 'connection_card_scriin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService _service = ApiService();

  bool _showAction = false;
  Offset _position;
  int _selectedCardId;

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _showAction = false;
        });
      },
      child: Stack(
        children: [
          ((userState.addedCards?.length ?? 0) != 0) ?
          ListView.separated(
            padding: EdgeInsets.only(
              top: 12,
            ),
            itemCount: userState.addedCards?.length ?? 0,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, color: Colors.black,),
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onLongPressStart: (details) {
                        print('long pressed start ${details.globalPosition}');
                        setState(() {
                          _selectedCardId = userState.addedCards[index].id;
                          _position = details.localPosition;
                          _showAction = true;
                        });
                      },

                      child: ElementUtils()
                          .cardElements(
                        viewOnly: true,
                        context: context,
                        elementList: userState.addedCards[index].components,
                        onSelect: () {},
                      )
                          .build(),
                    ),
                  ),
                ],
              );
            },
          ) : Center(
            child: Text(
              'You have not connect any card yet'
            ),
          ),
          _showAction ? actionWidget(userState) : SizedBox(),
          Positioned(
            right: 24,
            bottom: 24,
            child: FloatingActionButton(
              onPressed: () {
                scan();
              },
              child: Icon(Icons.add_box),
            ),
          ),
        ],
      ),
    );
  }

  Future scan() async {
    final _possibleFormats = BarcodeFormat.values.toList()
      ..removeWhere((e) => e == BarcodeFormat.unknown);

    List<BarcodeFormat> selectedFormats = [..._possibleFormats];

    try {
      var options = ScanOptions(
        restrictFormat: selectedFormats,
        useCamera: -1,
        autoEnableFlash: false,
      );

      var result = await BarcodeScanner.scan(options: options);

      print('scan results ' + result.rawContent);

      try {
        int id = int.parse(result.rawContent);
        Navigator.push(context, MaterialPageRoute(builder: (_) => ConnectedCardScreen(newCardId: int.parse(result.rawContent),)));
      } catch (e) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MainActivityScreen()));
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        print(result.rawContent);
        //scanResult = result;
      });
    }
  }

  Widget actionWidget(UserProvider userStates) {
    return Positioned(
      top: _position.dy,
      left: _position.dx,
      child: Container(
        width: 80,
        height: 66,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]
        ),
        child: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            GestureDetector(
              onTap: () {
                print('to chat');
              },
              child: Container(
                color: Colors.white,
                height: 30,
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.chat_bubble_outline,
                        color: accentColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            GestureDetector(
              onTap: () {
                print('remove');
                print(_selectedCardId);

                _service.removeCard(_selectedCardId).then((value) {
                  userStates.addedCards = value;
                }).then((value) => Timer(Duration(microseconds: 100), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainActivityScreen()));
                }));
              },
              child: Container(
                color: Colors.white,
                height: 30,
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
