import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/entity/card.dart';
import 'package:pairit/entity/card_components.dart';
import 'package:pairit/entity/card_element_key.dart';
import 'package:pairit/entity/user_data.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/screens/edit_body_widget/edit_elements_utils.dart';
import 'package:pairit/screens/edit_image_elements/photo_editor.dart';
import 'package:pairit/screens/main_screen.dart';
import 'package:pairit/services/api_service.dart';
import 'package:pairit/widgets.dart';
import 'package:provider/provider.dart';

import '../../states.dart';

class EditBodyPortrait extends StatefulWidget {

  @override
  _EditBodyPortraitState createState() => _EditBodyPortraitState();
}

class _EditBodyPortraitState extends State<EditBodyPortrait> {
  List<CardComponents> cardElement;

  ApiService _service = ApiService();

  String fontFamily = "Montserrat";
  int fontSize = 12;
  String fontTypo = 'Regular';
  Color fontCoalor = Colors.black;
  int icon = 0;
  Color iconColor = Colors.black;
  bool connectIcon = false;

  File _companyLogo;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final elementState = Provider.of<ElementProvider>(context);
    final userState = Provider.of<UserProvider>(context);
    var states = AppStates(context);

    print('build');
    if(cardElement == null) {
      cardElement = userState.editCard.components;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
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
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Align(
            alignment: Alignment.center,
            child: ElementUtils().cardElements(
              context: context,
              elementList: cardElement,
              onSelect: () {
                print(elementState.elementKey);
                if (elementState.elementKey != ElementKey.background
                    && elementState.elementKey != ElementKey.logo
                    && elementState.elementKey != ElementKey.photo) {
                  CardComponents element;
                  for(int i = 0; i<cardElement.length; i++) {
                    if(cardElement[i].elementKey == elementState.elementKey) {
                      element = cardElement[i];
                      break;
                    }
                  }
                  setState(() {
                    fontFamily = element.componentStates.fontFamily;
                    fontSize = element.componentStates.fontSize.round();
                    fontTypo = convertFontTypo(FontTypo(
                      element.componentStates.italic ? FontStyle.italic : FontStyle.normal,
                      element.componentStates.fontWeight,
                    ));
                  });
                } else {
                  String imageUrl;
                  if(elementState.elementKey == ElementKey.background) {
                    imageUrl = cardElement.firstWhere((element) => element.elementKey == ElementKey.background).componentStates.value;
                  }

                  if(elementState.elementKey == ElementKey.logo) {
                    imageUrl = userState.user.companyLogo;
                  }
                  if(elementState.elementKey == ElementKey.photo) {
                    imageUrl = cardElement.firstWhere((element) => element.elementKey == ElementKey.photo).componentStates.value;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PhotoEditor(
                      imageUrl: imageUrl,
                      elementKey: elementState.elementKey,
                    )),
                  );
                }
              },
            ).build(),
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          color: Colors.white,
          child: editTextPanel(context),
        ),
      ],
    );
  }

  Widget editTextPanel(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
    final elementState = Provider.of<ElementProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // font family
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
                    for(int i = 0; i<cardElement.length; i++) {
                      if(cardElement[i].elementKey == elementState.elementKey) {
                        FontTypo currentTypo = parseFontTypo(value);
                        cardElement[i].componentStates.fontWeight = currentTypo.fontWeight;
                        cardElement[i].componentStates.italic = (currentTypo.fontStyle == FontStyle.italic);
                        print(elementState.elementKey);
                      }
                    }
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
        SizedBox(
          height: 8,
        ),
        // Icon prefix
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: elementState.elementKey != ElementKey.companyInfo
              && elementState.elementKey != ElementKey.name
              && elementState.elementKey != ElementKey.background
              && elementState.elementKey != ElementKey.logo
              && elementState.elementKey != ElementKey.photo ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: connectIcon,
                  onChanged: (check) {
                    setState(() {
                      connectIcon = check;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: connectIcon ? Row(
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
                      child: DropdownButton<int>(
                        items: iconIndex.map((index) => DropdownMenuItem(
                          child: Icon(cardIcons[index], size: 12, color: Colors.black),
                          value: index,
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            icon = value;
                            for(int i = 0; i<cardElement.length; i++) {
                              if(cardElement[i].elementKey == elementState.elementKey) {
                                cardElement[i].componentStates.icon = value;
                                print(elementState.elementKey);
                              }
                            }
                          });
                        },
                        value: icon,
                        underline: SizedBox(),
                        icon: dropDown(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                      child: DropdownButton<Color>(
                        items: colors.map((color) => DropdownMenuItem(
                          child: Container(
                            height: 20,
                            width: 20,
                            color: color,
                          ),
                          value: color,
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            iconColor = value;
                            for(int i = 0; i<cardElement.length; i++) {
                              if(cardElement[i].elementKey == elementState.elementKey) {
                                cardElement[i].componentStates.iconColor = value;
                                print(elementState.elementKey);
                              }
                            }
                          });
                        },
                        value: iconColor,
                        underline: SizedBox(),
                        icon: dropDown(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ) : Text(
                  'Connect icon',
                ),
              )
            ],
          ) : SizedBox(
            height: 48,
          ),
        ),
        // Color
        Container(
          height: 42,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            scrollDirection: Axis.horizontal,
            children: colors.map((color) => colorBox(
              color: color,
              onSelectColor: () {
                setState(() {
                  cardElement.firstWhere((element)
                  => element.elementKey == elementState.elementKey)
                      .componentStates.color = color;
                  /*for(int i = 0; i<cardElement.length; i++) {
                    if(cardElement[i].elementKey == elementState.elementKey) {
                      cardElement[i].componentStates.color = color;
                      print(elementState.elementKey);
                    }
                  }*/
                });
              }
            )).toList(),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        AccentButton(
          label: 'Done',
          onPressed: () async {
            BusinessCard newCard = BusinessCard(
              id: userState.personalCard?.id,
              backgroundUrl: userState.personalCard?.backgroundUrl,
              qrUrl: userState.personalCard?.qrUrl,
              cardOwnerId: userState.user.id,
              components: cardElement,
            );
            //userState.personalCard = newCard;
            //print(cardElement);

            if(userState.personalCard?.qrUrl != null && userState.personalCard.qrUrl?.trim() != '') {

              print("elementState background " + (elementState.background == null).toString());

              if(elementState.background != null) {
                print('save image start');
                _service.uploadBackgroundImage(elementState.background).then((saved) {
                  print('image uploaded');

                  if(saved) {
                    _service.getCardById(userState.personalCard.id).then((cardValue) {
                      print('card bg ' + cardValue.toString());

                      userState.personalCard.backgroundUrl = cardValue.backgroundUrl;
                      newCard.backgroundUrl = cardValue.backgroundUrl;
                      _service.updateCard(newCard).then((value) {
                        print('upload card');
                        if(value) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MainActivityScreen()));
                        }
                      });
                    });
                  }
                });
              } else {
                _service.updateCard(newCard).then((value) {
                  print('upload card');
                  print(value);
                  if(value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MainActivityScreen()));
                  }
                });
              }

            } else {
              File backgroundFile;
              if (elementState.background != null) {
                backgroundFile = File.fromRawPath(elementState.background);
              }
              _service.createCard(newCard).then((value) {
                print('create card');
                print(value);
                if(value != null) {
                  _service.saveImages(elementState.background, value.id).then((cardWithBG) {
                    userState.personalCard = cardWithBG;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MainActivityScreen()));
                  });
                }
              });
            }
          },
        )
      ],
    );
  }

}




