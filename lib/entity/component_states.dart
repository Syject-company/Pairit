import 'package:flutter/material.dart';
import 'package:pairit/utils/entity_utils.dart';

class ComponentStates {
  String value;
  double fontSize;
  FontWeight fontWeight;
  String fontFamily;
  Color color;
  Color iconColor;
  bool italic;
  int icon;

  ComponentStates({
    this.fontFamily,
    this.fontWeight,
    this.fontSize,
    this.italic,
    this.color,
    this.value,
    this.icon,
    this.iconColor,
  });

  factory ComponentStates.fromJson(Map<String, dynamic> json) {
    return ComponentStates(
      value: json['value'],
      fontSize: json['fontSize']*1.0,
      fontWeight: EntityUtil.fontWeightParse(json['fontWeight']),
      fontFamily: json['fontFamily'],
      color: EntityUtil.colorParse(json['color']),
      italic: json['isItalic'],
      icon: json['iconId'],
      iconColor: EntityUtil.colorParse(json['iconColor']),
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['value'] = value;
    map['fontSize'] = fontSize.toInt();
    map['fontWeight'] = fontWeight.toString().split('.')[1];
    map['fontFamily'] = fontFamily;
    map['color'] = color.value.toString();
    map['iconId'] = icon;
    map['iconColor'] = iconColor.value.toString();
    return map;
  }

  @override
  String toString() {
    return 'FontStates{value: $value, iconId:$icon, fontSize: $fontSize, fontWeight: $fontWeight, fontFamily: $fontFamily, color: $color, italic: $italic}';
  }
}