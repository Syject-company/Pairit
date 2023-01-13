import 'package:flutter/material.dart';

class FontTypo {
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  FontTypo(this.fontStyle, this.fontWeight);
}

FontTypo parseFontTypo(String value) {
  FontTypo fontTypo;
  switch (value) {
    case 'Thin' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w100);
      }
      break;
    case 'ThinItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w100);
      }
      break;
    case 'ExtraLight' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w200);
      }
      break;
    case 'ExtraLightItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w200);
      }
      break;
    case 'Light' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w300);
      }
      break;
    case 'LightItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w300);
      }
      break;
    case 'Regular' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w400);
      }
      break;
    case 'Italic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w400);
      }
      break;
    case 'Medium' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w500);
      }
      break;
    case 'MediumItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w500);
      }
      break;
    case 'SemiBold' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w600);
      }
      break;
    case 'SemiBoldItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w600);
      }
      break;
    case 'Bold' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w700);
      }
      break;
    case 'BoldItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w700);
      }
      break;
    case 'ExtraBold' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w800);
      }
      break;
    case 'ExtraBoldItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w800);
      }
      break;
    case 'Black' :
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w900);
      }
      break;
    case 'BlackItalic' :
      {
        fontTypo = FontTypo(FontStyle.italic, FontWeight.w900);
      }
      break;
    default:
      {
        fontTypo = FontTypo(FontStyle.normal, FontWeight.w400);
      }
      break;
  }

  return fontTypo;
}

String convertFontTypo(FontTypo fontValue) {
  String weigh;
  String style;

  String fontTypo;

  if(fontValue.fontStyle == FontStyle.normal) {
    style = "";
  } else {
    style = "Italic";
  }

  switch (fontValue.fontWeight) {
    case FontWeight.w100 :
      {
        weigh = "Thin";
      }
      break;
    case FontWeight.w200 :
      {
        weigh = "ExtraLight";
      }
      break;
    case FontWeight.w300 :
      {
        weigh = "Light";
      }
      break;
    case FontWeight.w400 :
      {
        weigh = "Regular";
      }
      break;
    case FontWeight.w500 :
      {
        weigh = "Medium";
      }
      break;
    case FontWeight.w600 :
      {
        weigh = "SemiBold";
      }
      break;
    case FontWeight.w700 :
      {
        weigh = "Bold";
      }
      break;
    case FontWeight.w800 :
      {
        weigh = "ExtraBold";
      }
      break;
    case FontWeight.w900 :
      {
        weigh = "Black";
      }
      break;
    default:
      {
        weigh = "Regular";
      }
      break;
  }

  fontTypo = weigh + style;

  if(fontTypo == 'RegularItalic') {
    fontTypo = 'Italic';
  }

  return fontTypo;
}