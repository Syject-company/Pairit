part of '../bloc/card_bloc.dart';

abstract class CardEditState extends Equatable {
  final ElementKey elementKey;
  //final FontStates states;

  const CardEditState(this.elementKey);

  @override
  List<Object> get props => [elementKey];
}

class EditInitial extends CardEditState {
  const EditInitial(ElementKey elementKey) : super(elementKey);
}