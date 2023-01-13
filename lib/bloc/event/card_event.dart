part of '../bloc/card_bloc.dart';

abstract class CardEditEvent extends Equatable {
  const CardEditEvent();

  @override
  List<Object> get props => [];
}

class CardElementSelected extends CardEditEvent {
  final ElementKey elementKey;

  const CardElementSelected({@required this.elementKey});
}

