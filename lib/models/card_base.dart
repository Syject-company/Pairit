import 'package:flutter/material.dart';
import 'package:pairit/entity/component_states.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:provider/provider.dart';

import '../states.dart';
import '../entity/card_components.dart';
import '../entity/card_element_key.dart';


class CardBase {
  ImageProvider _backgroundImage;
  Map<ElementKey, CardComponents> _elements;

  double _height, _width, _radius, _coefficient;

  bool isSelected = false;

  ImageProvider get backgroundImage => _backgroundImage;

  set backgroundImage(ImageProvider value) {
    _backgroundImage = value;
  }

  // Add already generate new card element
  addCardElement({ElementKey elementKey, CardComponents cardElement}) {
    _elements.putIfAbsent(elementKey, () => cardElement);
  }

  // Update already generate card element
  updateCardElement({ElementKey elementKey, CardComponents cardElement}) {
    _elements.update(elementKey, (element) => cardElement);
  }

  // Generate and add new card element
  addWidget({ElementKey elementKey, Offset position, Size size, Widget child, ComponentStates componentStates}) {
    _elements.putIfAbsent(elementKey, () => CardComponents(
      position: position,
      size: size,
      view: child,
      componentStates: componentStates,
      elementKey: elementKey,
    ));
  }

  // Generate and update card element
  updateWidget({ElementKey elementKey, Offset position, Size size, Widget child, ComponentStates fontStates}) {
    _elements.update(elementKey, (value) => CardComponents(
      position: position,
      size: size,
      view: child,
      componentStates: fontStates,
      elementKey: elementKey,
    ));
  }

  // Return all card elements
  CardComponents getCardElement(ElementKey elementKey) {
    return _elements.entries.firstWhere((element) => element.key == elementKey).value;
  }

  // Rendering Cards
  Widget build () {
    ImageProvider background;

    if(_backgroundImage == null) {
      for(CardComponents element in _elements.values) {
        if(element.elementKey == ElementKey.background
            && element.componentStates?.value != null
            && element.componentStates.value.isNotEmpty) {
          background = NetworkImage(element.componentStates.value);
        }
      }
    } else {
      background = _backgroundImage;
    }

    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        border: isSelected ? Border.all(
          color: accentColor,
          width: 3,
        ) : Border.all(
          color: Colors.transparent,
          width: 0,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        image: DecorationImage(
          image: background ?? AssetImage('assets/images/white_bg.jpg'),
          fit: BoxFit.cover
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: _elements.values.map((element) => Container(
          margin: EdgeInsets.only(
            top: element.position.dy*_coefficient,
            left: element.position.dx*_coefficient,
          ),
          height: element.size.height*_coefficient,
          width: element.size.width*_coefficient,
          child: element.view,
        )).toList()
      ),
    );
  }

  // Class constructor
  CardBase(context) {
    var states = AppStates(context);
    final elementState = Provider.of<ElementProvider>(context);
    _elements = {};
    _height = states.cardHeight;
    _width = states.cardWidth;
    _radius = states.cardRadius;
    _coefficient = states.coefficient;
    _backgroundImage = elementState.background != null ? MemoryImage(elementState.background) : null;
  }
}
