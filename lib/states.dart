import 'package:flutter/material.dart';

final Color accentColor = Color(0xFF2996FF);

class AppStates {
  final BuildContext context;
  final Size _fullCardSize = Size(500, 900);

  double _width;
  double _height;
  bool _isPortrait;
  double _cardHeight;
  double _cardWight;
  double _cardRadius;
  double _k;

  double get width => _width;

  double get height => _height;

  bool get isPortrait => _isPortrait;

  double get cardWidth => _cardWight;

  double get cardHeight => _cardHeight;

  double get cardRadius => _cardRadius;

  double get coefficient => _k;

  AppStates(this.context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _k = _isPortrait
        ? (MediaQuery.of(context).size.shortestSide * 0.9) / 900
        : (MediaQuery.of(context).size.shortestSide * 0.6) / 500;
    _cardHeight = _k * _fullCardSize.shortestSide;
    _cardWight = _k * _fullCardSize.longestSide;
    _cardRadius = 0;
  }
}

final List<String> fontFamilies = [
  'Montserrat',
  'ArchitectsDaughter',
  'CourierPrime',
  'Lobster',
  'Oswald',
];

final List<int> fontSizes = [
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
];

List<DropdownMenuItem<int>> dropdownFontSizes = fontSizes
    .map((e) => DropdownMenuItem(
          child: Text(e.toString()),
          value: e,
        ))
    .toList();

final Map<String, List<String>> fontTypes = {
  'Montserrat': [
    'Thin',
    'ThinItalic',
    'ExtraLight',
    'ExtraLightItalic',
    'Light',
    'LightItalic',
    'Regular',
    'Italic',
    'Medium',
    'MediumItalic',
    'SemiBold',
    'SemiBoldItalic',
    'Bold',
    'BoldItalic',
    'ExtraBold',
    'ExtraBoldItalic',
    'Black',
    'BlackItalic',
  ],
  'ArchitectsDaughter': [
    'Regular',
  ],
  'CourierPrime': [
    'Regular',
    'Italic',
    'Bold',
    'BoldItalic',
  ],
  'Lobster': [
    'Regular',
  ],
  'Oswald': [
    'ExtraLight',
    'Light',
    'Regular',
    'Medium',
    'SemiBold',
    'Bold',
  ],
};

List<Color> colors = [
  Colors.black,
  Colors.white,
  Colors.grey,
  Colors.blue,
  Colors.red,
  Colors.amber,
  Colors.green,
  Colors.deepPurple,
  Colors.pink,
  Colors.teal
];

Widget iconWidget(int index, Color color, double size) {
  List<Widget> icons = [
    Icon(Icons.phone, size: size, color: color),
    Icon(Icons.phone, size: size, color: color),
    Icon(Icons.phone, size: size, color: color),
    Icon(Icons.home, size: size, color: color),
    Icon(Icons.location_on, size: size, color: color),
    Icon(Icons.location_city, size: size, color: color),
    Icon(Icons.email, size: size, color: color),
    Icon(Icons.alternate_email, size: size, color: color),
    Icon(Icons.send, size: size, color: color),
    Icon(Icons.web, size: size, color: color),
    Icon(Icons.language, size: size, color: color),
    Icon(Icons.not_interested, size: size, color: color),
    Icon(Icons.face, size: size, color: color),
    Icon(Icons.tag_faces, size: size, color: color),
    Icon(Icons.accessibility, size: size, color: color),
    Icon(Icons.camera_alt, size: size, color: color),
    Icon(Icons.center_focus_weak, size: size, color: color),
    Icon(Icons.camera, size: size, color: color),
  ];
  return icons[index];
}

List<IconData> cardIcons = [
  Icons.add,
  Icons.phone,
  Icons.home,
  Icons.location_on,
  Icons.location_city,
  Icons.email,
  Icons.alternate_email,
  Icons.send,
  Icons.web,
  Icons.language,
  Icons.not_interested,
  Icons.face,
  Icons.tag_faces,
  Icons.accessibility,
  Icons.camera_alt,
  Icons.center_focus_weak,
  Icons.camera,
];

List<int> iconIndex = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
];
