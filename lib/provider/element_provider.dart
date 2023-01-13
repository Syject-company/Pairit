import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pairit/models/card_base.dart';
import 'package:pairit/entity/card_element_key.dart';
import 'package:pairit/entity/card_templates.dart';

class ElementProvider extends ChangeNotifier {

  static final ElementProvider _singleton = ElementProvider._internal();

  factory ElementProvider() => _singleton;

  ElementProvider._internal();


  // States

  ElementKey _elementKey;
  TextEditingController _controller;
  List<CardTemplates> _templates;

  Uint8List _background;
  Uint8List _logo;
  Uint8List _image;

  // Getters

  ElementKey get elementKey => _elementKey;

  TextEditingController get controller => _controller;

  List<CardTemplates> get templates => _templates;

  Uint8List get background => _background;

  Uint8List get logo => _logo;

  Uint8List get image => _image;

  // Setters

  void setTemplates(List<CardTemplates> value) {
    _templates = value ?? [];
  }

  void setElementKey(ElementKey elementKey) {
    _elementKey = elementKey;
  }

  void setController(TextEditingController controller) {
    _controller = controller;
  }

  void setBackground(Uint8List value) {
    _background = value;
  }

  void setLogo(Uint8List value) {
    _logo = value;
  }

  void setImage(Uint8List value) {
    _image = value;
  }
}