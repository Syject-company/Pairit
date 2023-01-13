import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pairit/utils/entity_utils.dart';

import 'card_element_key.dart';
import 'component_states.dart';

class CardComponents {
  int id;
  Offset position;
  Widget view;
  Size size;
  ComponentStates componentStates;
  ElementKey elementKey;

  CardComponents({this.position, this.view, this.size, this.componentStates, this.elementKey, this.id});

  factory CardComponents.fromJson(Map<String, dynamic> json) {
    return CardComponents(
      id: json['id'],
      size: Size(json['sizeX']*1.0, json['sizeY']*1.0),
      position: Offset(json['positionX']*1.0, json['positionY']*1.0),
      elementKey: EntityUtil.elementKeyParse(json['elementKey']),
      componentStates: ComponentStates.fromJson(json),
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['sizeX'] = size.width.toInt();
    map['sizeY'] = size.height.toInt();
    map['positionX'] = position.dx.toInt();
    map['positionY'] = position.dy.toInt();
    map['elementKey'] = elementKey.toString().split('.')[1];

    map.addAll(componentStates.toMap());

    return map;
  }

  Map<String, dynamic> toMapWithOutId() {
    var map = Map<String, dynamic>();
    map['sizeX'] = size.width.toInt();
    map['sizeY'] = size.height.toInt();
    map['positionX'] = position.dx.toInt();
    map['positionY'] = position.dy.toInt();
    map['elementKey'] = elementKey.toString().split('.')[1];

    map.addAll(componentStates.toMap());

    return map;
  }

  String toJson() {
    return jsonEncode({
      "id": id ?? '',
      "sizeX" : size.height.toInt(),
      "sizeY" : size.width.toInt(),
      "positionX" : position.dx.toInt(),
      "positionY" : position.dy.toInt(),
      "elementKey" : elementKey.toString().split('.')[1],
      "value" : componentStates.value,
      "fontSize" : componentStates.fontSize.toInt(),
      "fontWeight" : componentStates.fontWeight.toString().split('.')[1],
      "fontFamily" : componentStates.fontFamily,
      "color" : componentStates.color.toString()
          .substring(6, (componentStates.color.toString().length-1)),
    });
  }

  @override
  String toString() {
    return 'CardElement{componentStates: $componentStates, elementKey: $elementKey} \n';
  }
}