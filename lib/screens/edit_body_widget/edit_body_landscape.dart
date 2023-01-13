import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/entity/card_components.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../states.dart';
import '../../widgets.dart';

class EditBodyLandscape extends StatefulWidget {
  Image backgroundImage;
  Image customImage;

  EditBodyLandscape({this.backgroundImage, this.customImage});


  @override
  _EditBodyLandscapeState createState() => _EditBodyLandscapeState(backgroundImage, customImage);
}

class _EditBodyLandscapeState extends State<EditBodyLandscape> {
  Image backgroundImage;
  Image customImage;
  _EditBodyLandscapeState(this.backgroundImage, this.customImage);
  List<CardComponents> cardElement;

  String fontFamily = "Montserrat";
  int fontSize = 12;
  String fontTypo = 'Regular';
  Color fontColor = Colors.black;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final elementState = Provider.of<ElementProvider>(context);
    final userState = Provider.of<UserProvider>(context);
    var states = AppStates(context);

    if(cardElement == null) {
      cardElement = userState.personalCard.components;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            left: 4,
            top: 24,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ElementUtils().cardElements(
            context: context,
            elementList: cardElement,
            onSelect: () {
              print(elementState.elementKey);
              getCompanyLogo();
            },
          ).build(),
        ),
        Container(
          width: (states.width-states.cardWidth*1.4),
          color: Colors.white,
          child: editTextPanel(context)
        ),
      ],
    );
  }
  Widget editTextPanel(BuildContext context) {
    final elementState = Provider.of<ElementProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: DropdownButton<String>(
            items: fontFamilies.map((family) => DropdownMenuItem(
              child: Text(family, style: TextStyle(fontFamily: family)),
              value: family,
            )).toList(),
            onChanged: (value) {
              setState(() {
                fontFamily = value;
                for(int i = 0; i<cardElement.length; i++) {
                  if(cardElement[i].elementKey == elementState.elementKey) {
                    cardElement[i].componentStates.fontFamily = value;
                  }
                }
              });
              print(elementState.elementKey);
            },
            value: fontFamily,
            underline: SizedBox(),
            icon: dropDown(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // font family

            // font size
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )
              ),
              child: DropdownButton<int>(
                items: fontSizes.map((e) => DropdownMenuItem(
                  child: Text(e.toString()),
                  value: e,
                )).toList(),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    fontSize = value;
                    for(int i = 0; i<cardElement.length; i++) {
                      if(cardElement[i].elementKey == elementState.elementKey) {
                        cardElement[i].componentStates.fontSize = value.ceilToDouble();
                        print(elementState.elementKey);
                      }
                    }
                  });
                },
                value: fontSize,
                underline: SizedBox(),
                icon: dropDown(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            // font typo
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )
              ),
              child: DropdownButton<String>(
                items: fontTypes
                    .entries
                    .firstWhere((element) => element.key == fontFamily)
                    .value.map((typo)  => DropdownMenuItem(
                  child: Text(typo.toString()),
                  value: typo,
                )).toList(),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    fontTypo = value;
                  });
                },
                value: fontTypo,
                //hint: Text('RegularItalic'),
                icon: dropDown(),
                underline: SizedBox(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        // Color
        Container(
          child: Wrap(
            children: colors.map((color) => colorBox(
                color: color,
                onSelectColor: () {
                  setState(() {
                    for(int i = 0; i<cardElement.length; i++) {
                      if(cardElement[i].elementKey == elementState.elementKey) {
                        cardElement[i].componentStates.color = color;
                        print(elementState.elementKey);
                      }
                    }
                  });
                }
            )).toList(),
          ),
        ),
        AccentButton(
          label: 'Done',
          onPressed: () {
            print(cardElement);
          },
        )
      ],
    );
  }

  Widget editImagePanel(BuildContext context) {
    final elementState = Provider.of<ElementProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WhiteButton(
          label: 'Upload image',
          onPressed: () {},
        ),
        AccentButton(
          label: 'Done',
          onPressed: () {
            print(cardElement);
          },
        )
      ],
    );
  }

  Future getCompanyLogo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
  }
}
