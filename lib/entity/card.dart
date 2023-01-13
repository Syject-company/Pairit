import 'dart:convert';

import 'package:pairit/entity/card_element_key.dart';

import 'card_components.dart';

class BusinessCard {
  int id;
  String qrUrl;
  String cardOwnerId;
  String backgroundUrl;
  List<CardComponents> components;


  BusinessCard({this.id, this.qrUrl, this.backgroundUrl, this.components, this.cardOwnerId});

  factory BusinessCard.fromJson(Map<String, dynamic> json) {
    var componentsJson = json['components'] as List;
    List<CardComponents> components = componentsJson.map((tagJson) => CardComponents.fromJson(tagJson)).toList();
    String background = '';
    for(CardComponents element in components) {
      if (element.elementKey == ElementKey.background) {
        element.componentStates.value = json['background'];
      }
    }
    return BusinessCard(
      id: json['id'],
      qrUrl: json['qrCode'],
      cardOwnerId: json['cardOwnerId'],
      backgroundUrl: json['background'],
      components: components,
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    if (qrUrl != null) {
      map['qrCode'] = qrUrl;
    }
    if (backgroundUrl != null) {
      map['background'] = backgroundUrl;
    }
    map['cardOwnerId'] = cardOwnerId;
    map['components'] = components.map((e) => e.toMap()).toList();
    return map;
  }
  
  String toJson() {
    return jsonEncode({
      "id": id,
      "qrCode" : qrUrl,
      "background" : backgroundUrl,
      "cardOwnerId" : cardOwnerId,
      "components" : components.map((component) => component.toMap()).toList(),
    });
  }

  String saveCardJson() {
    return jsonEncode({
      "isFree" : true,
      "price" : 0.00,
      "components" : components.map((component) => component.toMapWithOutId()).toList(),
    });
  }

  @override
  String toString() {
    return '\nBusinessCard{\nid: $id, \nqrUrl: $qrUrl, \ncardOwnerId: $cardOwnerId, \nbackgroundUrl: $backgroundUrl, \ncomponents: $components}';
  }
}