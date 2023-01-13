import 'package:flutter/material.dart';
import 'package:pairit/entity/card_components.dart';
import 'package:pairit/entity/component_states.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:provider/provider.dart';

import '../states.dart';


class CardTextElement extends StatelessWidget {
  final ComponentStates states;
  final TextEditingController controller;
  final VoidCallback onSelect;
  final ValueChanged<String> onChanged;
  final bool readOnly;
  final Widget icon;

  double fontSize;
  FontWeight fontWeight;
  String fontFamily;
  Color color;
  bool italic;

  CardTextElement({
    Key key,
    this.states,
    this.controller,
    this.onSelect,
    this.onChanged,
    this.readOnly = false,
    this.icon
  }) :
        fontSize = states.fontSize,
        fontWeight = states.fontWeight,
        fontFamily = states.fontFamily,
        color = states.color,
        italic = states.italic;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: onChanged,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          color: color,
        ),
        decoration: InputDecoration(
          prefix: icon,
          hintText: states.value,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: fontSize,
          ),
          alignLabelWithHint: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1),
            borderRadius: BorderRadius.circular(0),
            gapPadding: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1),
            gapPadding: 0,
          ),
          contentPadding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 0,
            bottom: 0,
          ),
        ),
        cursorColor: accentColor,
        maxLines: 1,
        controller: controller,
        onTap: onSelect,
      ),
    );
  }
}


class CardImageElement extends StatelessWidget {
  final String url;
  final VoidCallback onSelect;

  CardImageElement({Key key, this.url, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onSelect,
        child: (url == null || url.isEmpty) ? Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.grey, width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            '+Add Logo',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ) : Image.network(
          url, fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class CardImageBackground extends StatelessWidget {
  final String url;
  final VoidCallback onSelect;

  CardImageBackground({Key key, this.url, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onSelect,
        child: (url == null || url.isEmpty) ? Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Text(
            '+',
            style: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ) : Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class CardTextViewElement extends StatelessWidget {
  final ComponentStates states;
  final String value;

  double fontSize;
  FontWeight fontWeight;
  String fontFamily;
  Color color;
  bool italic;

  CardTextViewElement({Key key, this.states, this.value}) :
        fontSize = states.fontSize,
        fontWeight = states.fontWeight,
        fontFamily = states.fontFamily,
        color = states.color,
        italic = states.italic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          color: color,
        ),
      ),
    );
  }
}
