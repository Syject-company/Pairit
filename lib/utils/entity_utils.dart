import 'package:flutter/material.dart';
import 'package:pairit/entity/card_element_key.dart';

class EntityUtil {


  static ElementKey elementKeyParse(String value) {
    ElementKey elementKey;
    switch (value) {
      case "name" :
        {
          elementKey = ElementKey.name;
        }
        break;
      case "logo" :
        {
          elementKey = ElementKey.logo;
        }
        break;
      case "companyInfo" :
        {
          elementKey = ElementKey.companyInfo;
        }
        break;
      case "background" :
        {
          elementKey = ElementKey.background;
        }
        break;
      case "phoneNumber1" :
        {
          elementKey = ElementKey.phoneNumber1;
        }
        break;
      case "phoneNumber2" :
        {
          elementKey = ElementKey.phoneNumber2;
        }
        break;
      case "address" :
        {
          elementKey = ElementKey.address;
        }
        break;
      case "email" :
        {
          elementKey = ElementKey.email;
        }
        break;
      case "web" :
        {
          elementKey = ElementKey.web;
        }
        break;
      case "facebook" :
        {
          elementKey = ElementKey.facebook;
        }
        break;
      case "instaLink" :
        {
          elementKey = ElementKey.instaLink;
        }
        break;
    }
    return elementKey;
  }

  static FontWeight fontWeightParse(String value) {
    FontWeight fontWeight;
    switch (value) {
      case "w100" :
        {
          fontWeight = FontWeight.w100;
        }
        break;
      case "w200" :
        {
          fontWeight = FontWeight.w200;
        }
        break;
      case "w300" :
        {
          fontWeight = FontWeight.w300;
        }
        break;
      case "w400" :
        {
          fontWeight = FontWeight.w400;
        }
        break;
      case "w500" :
        {
          fontWeight = FontWeight.w500;
        }
        break;
      case "w600" :
        {
          fontWeight = FontWeight.w600;
        }
        break;
      case "w700" :
        {
          fontWeight = FontWeight.w700;
        }
        break;
      case "w800" :
        {
          fontWeight = FontWeight.w800;
        }
        break;
      case "w900" :
        {
          fontWeight = FontWeight.w900;
        }
        break;
      default:
        {
          fontWeight = FontWeight.w400;
        }
        break;
    }

    return fontWeight;
  }

  static Color colorParse(String value) {

    if(value == null) {
      return Colors.transparent;
    }

    return Color(int.parse(value));
  }
}