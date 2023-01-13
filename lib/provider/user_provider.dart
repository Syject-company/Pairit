import 'package:flutter/material.dart';
import 'package:pairit/entity/card.dart';
import 'package:pairit/entity/chat.dart';
import 'package:pairit/entity/user.dart';

class UserProvider extends ChangeNotifier {

  static final UserProvider _singleton = UserProvider._internal();

  factory UserProvider() => _singleton;

  UserProvider._internal();

  // States

  User _user;

  List<BusinessCard> _addedCards;

  BusinessCard _personalCard;

  BusinessCard _editCard;

  List<Chat> _chatRooms;

  // Getters

  User get user => _user;

  List<BusinessCard> get addedCards => _addedCards;

  BusinessCard get personalCard => _personalCard;

  BusinessCard get editCard => _editCard;

  List<Chat> get chatRooms => _chatRooms;

  // Setters

  set user(User user) {
    _user = user;
  }

  set addedCards(List<BusinessCard> cards) {
    _addedCards = cards;
  }

  set personalCard(BusinessCard card) {
    _personalCard = card;
  }

  set editCard(BusinessCard value) {
    _editCard = value;
  }

  set chatRooms(List<Chat> chats) {
    _chatRooms = chats;
  }
}