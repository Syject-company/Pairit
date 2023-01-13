import 'dart:typed_data';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bitmap/bitmap.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pairit/widgets.dart';

import 'screens/edit_image_elements/image_value.dart';
import 'services/signalr_service.dart';
import 'ui_elements.dart';

class TestPage extends StatefulWidget {

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  SignalRService _signalR;

  @override
  void initState() {
    _signalR = SignalRService(
      onMessage: () {},
    );
    _signalR.openChatConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AccentButton(
          label: "Go",
          onPressed: () {
            _signalR.sendMessage(
              message: 'hi',
              chatId: '',
            );
          },
        ),
      ),
    );
  }

}