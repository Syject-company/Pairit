import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'states.dart';

InputDecoration _textFieldDecoration(String title, Widget suffixIcon) {
  return InputDecoration(
    filled: true,
    suffixIcon: suffixIcon,
    fillColor: Colors.white,
    labelText: title,
    labelStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    alignLabelWithHint: true,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1),
    ),
    contentPadding: const EdgeInsets.only(
      left: 14,
      right: 14,
      top: 8,
      bottom: 8,
    ),
  );
}

InputDecoration _textFieldErrorDecoration(String title, Widget suffixIcon) {
  return InputDecoration(
    filled: true,
    suffixIcon: suffixIcon,
    fillColor: Colors.white,
    labelText: title,
    labelStyle: TextStyle(
      color: Colors.red,
      fontSize: 14,
    ),
    alignLabelWithHint: true,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    contentPadding: const EdgeInsets.only(
      left: 14,
      right: 14,
      top: 8,
      bottom: 8,
    ),
  );
}

class PairItTextField extends StatelessWidget {

  PairItTextField({
    Key key,
    this.title,
    this.active = false,
    this.suffixIcon,
    this.controller,
    this.isError = false,
    TextInputType keyboardType,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.onTap,
    this.obscureText  = false,
    this.buildCounter,
    this.focusNode,
  }) : assert(textAlign != null),
        assert(readOnly != null),
        assert(maxLines == null || maxLines > 0),
        assert(maxLength == null || maxLength == TextField.noMaxLength || maxLength > 0),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  final bool active;
  final String title;
  final Widget suffixIcon;
  final TextEditingController controller;
  final bool isError;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final int maxLines;
  final bool readOnly;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final bool enabled;
  final GestureTapCallback onTap;
  final bool obscureText;
  final InputCounterWidgetBuilder buildCounter;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.01,
      ),
      child: TextField(
        readOnly: readOnly,
        maxLength: maxLength,
        maxLengthEnforced: true,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: isError
            ? _textFieldErrorDecoration(title, suffixIcon)
            : _textFieldDecoration(title, suffixIcon),
        cursorColor: accentColor,
        maxLines: 1,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textAlign: textAlign,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        enabled: enabled,
        onTap: onTap,
        buildCounter: buildCounter,

      ),
    );
  }
}

class AccentButton extends MaterialButton {
  final String label;
  final VoidCallback onPressed;
  double minWidth;

  AccentButton({@required this.onPressed, this.label, this.minWidth});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: ButtonTheme(
        minWidth: minWidth ?? 150,
        height: 40,
        highlightColor: Colors.transparent,
        child: FlatButton(
          onPressed: onPressed,
          color: accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class WhiteButton extends MaterialButton {
  final String label;
  final VoidCallback onPressed;
  double minWidth;

  WhiteButton({@required this.onPressed, this.label, this.minWidth});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: ButtonTheme(
        minWidth: minWidth ?? 150,
        height: 40,
        highlightColor: Colors.transparent,
        child: FlatButton(
          onPressed: onPressed,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class CirclePairAvatar extends StatelessWidget {
  final double width;
  final double radius;
  final bool changeable;
  final Image child;
  final VoidCallback onAdd;

  const CirclePairAvatar({
    Key key,
    this.width,
    this.radius,
    this.changeable = false,
    this.child,
    this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius*2,
      width:  radius*2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: 45,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFB2FFB6),
                    accentColor
                  ]
                )
              ),
            ),
          ),
          CircleAvatar(
            radius: radius-width,
            backgroundColor: Colors.grey[300],
            backgroundImage: child.image,
          ),
          changeable ? Container(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onAdd,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: accentColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}

class BottomCustomTabBar extends StatefulWidget {
  final VoidCallback onFirstButtonTab;
  final VoidCallback onSecondButtonTab;
  final VoidCallback onThirdButtonTab;
  int activeTab;

  BottomCustomTabBar({this.onFirstButtonTab, this.onSecondButtonTab, this.onThirdButtonTab, this.activeTab});

  @override
  _BottomCustomTabBarState createState() => _BottomCustomTabBarState();
}

class _BottomCustomTabBarState extends State<BottomCustomTabBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(0, -3),
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.activeTab = 0;
              });
              widget.onFirstButtonTab();
            },
            child: Container(
              height: 40,
              width: 40,
              child: widget.activeTab == 0
                  ? SvgPicture.asset('assets/images/buton_1_active.svg')
                  : SvgPicture.asset('assets/images/button_1.svg'),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.activeTab = 1;
              });
              widget.onSecondButtonTab();
            },
            child: Container(
              height: 40,
              width: 40,
              child: widget.activeTab == 1
                  ? SvgPicture.asset('assets/images/button_2_active.svg')
                  : SvgPicture.asset('assets/images/button_2.svg'),
            ),
          ),GestureDetector(
            onTap: () {
              setState(() {
                widget.activeTab = 2;
              });
              widget.onThirdButtonTab();
            },
            child: Container(
              height: 40,
              width: 40,
              child: widget.activeTab == 2
                  ? SvgPicture.asset('assets/images/buton_3_active.svg')
                  : SvgPicture.asset('assets/images/button_3.svg'),
            ),
          ),
        ],
      ),
    );
  }
}

Widget colorBox({Color color, VoidCallback onSelectColor}) {
  return GestureDetector(
    onTap: onSelectColor,
    child: Container(
      width: 26,
      height: 26,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        height: 18,
        width: 18,
        color: color,
      ),
    ),
  );
}

Widget dropDown() {
  return Container(
    margin: EdgeInsets.only(left: 4),
    height: 14,
    width: 14,
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(2)
    ),
    alignment: Alignment.topLeft,
    child: Icon(Icons.arrow_drop_down, size: 14, color: Colors.black,),
  );
}


