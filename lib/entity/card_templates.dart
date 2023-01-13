import 'package:equatable/equatable.dart';
import 'package:pairit/entity/card_components.dart';

class CardTemplates extends Equatable{
  int id;
  bool isFree;
  double price;
  List<CardComponents> components;

  CardTemplates({this.id, this.price, this.isFree, this.components});

  factory CardTemplates.fromJson(Map<String, dynamic> json) {
    var componentsJson = json['components'] as List;
    List<CardComponents> components = componentsJson.map((tagJson) => CardComponents.fromJson(tagJson)).toList();
    return CardTemplates(
      id: json['id'],
      isFree: json['isFree'],
      price: json['price'],
      components: components,
    );
  }

  @override
  String toString() {
    return 'CardTemplates{id: $id, isFree: $isFree, price: $price, components: $components}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [components];
}