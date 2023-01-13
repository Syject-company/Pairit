import 'package:pairit/entity/chat.dart';

import 'card.dart';
import 'user.dart';

class UserData {
  User user;

  List<BusinessCard> addedCards;

  BusinessCard personalCard;

  UserData({this.user, this.addedCards, this.personalCard});
}