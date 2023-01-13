import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pairit/card_utils/card_element_utils.dart';
import 'package:pairit/entity/card.dart';
import 'package:pairit/entity/card_components.dart';
import 'package:pairit/entity/card_element_key.dart';
import 'package:pairit/entity/card_templates.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/services/api_service.dart';
import 'package:pairit/widgets.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../states.dart';
import '../card_editor.dart';
import '../edit_image_elements/photo_editor.dart';

class SelectCardTemplatePortrait extends StatefulWidget {
  @override
  _SelectCardTemplatePortraitState createState() => _SelectCardTemplatePortraitState();
}

class _SelectCardTemplatePortraitState extends State<SelectCardTemplatePortrait> {

  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  int _selectedTemplate = 0;

  @override
  Widget build(BuildContext context) {
    final elementState = Provider.of<ElementProvider>(context);
    final userStates = Provider.of<UserProvider>(context);

    var _states = AppStates(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          backgroundColor: accentColor,
          elevation: 6,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 8),
            alignment: Alignment.topCenter,
            child: ElementUtils()
                .cardElements(
              viewOnly: true,
              context: context,
              elementList: elementState.templates[_selectedTemplate].components,
              onSelect: () {},
            )
                .build(),
          ),

          elementState.templates[_selectedTemplate].isFree ? Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: _states.cardHeight + 36),
            child: GestureDetector(
              onTap: () {
                List<CardComponents> components = [];
                List<CardComponents> selectTemplate = elementState.templates[_selectedTemplate].components;

                for(CardComponents element in selectTemplate) {
                  if(element.elementKey == ElementKey.logo
                      && userStates.user.companyLogo != null
                      && userStates.user.companyLogo.trim() != '') {
                    element.componentStates.value = userStates.user.companyLogo;
                  }
                  if(element.elementKey == ElementKey.name
                      && userStates.user.firstName != null
                      && userStates.user.firstName.trim() != ''
                      && userStates.user.lastName != null
                      && userStates.user.lastName.trim() != '') {
                    element.componentStates.value =
                    "${userStates.user.firstName} "
                        "${userStates.user.lastName}";
                  }
                  if(element.elementKey == ElementKey.companyInfo
                      && userStates.user.company != null
                      && userStates.user.company.trim() != ''
                      && userStates.user.position != null
                      && userStates.user.position.trim() != '') {
                    element.componentStates.value =
                    "${userStates.user.company} "
                        "${userStates.user.position}";
                  }
                  if(element.elementKey == ElementKey.phoneNumber1
                      && userStates.user.phoneNumber1 != null
                      && userStates.user.phoneNumber1.trim() != '') {
                    element.componentStates.value = userStates.user.phoneNumber1;
                  }
                  if(element.elementKey == ElementKey.phoneNumber2
                      && userStates.user.phoneNumber2 != null
                      && userStates.user.phoneNumber2.trim() != '') {
                    element.componentStates.value = userStates.user.phoneNumber2;
                  }
                  if(element.elementKey == ElementKey.facebook
                      && userStates.user.socialLink1 != null
                      && userStates.user.socialLink1.trim() != '') {
                    element.componentStates.value = userStates.user.socialLink1;
                  }
                  if(element.elementKey == ElementKey.instaLink
                      && userStates.user.socialLink2 != null
                      && userStates.user.socialLink2.trim() != '') {
                    element.componentStates.value = userStates.user.socialLink2;
                  }

                  components.add(element);
                }



                userStates.editCard = BusinessCard(
                  cardOwnerId: userStates.user.id,
                  components: components,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardEditor(),
                  ),
                );
              },
              child: Text(
                'Select Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ),
          ) : Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: _states.cardHeight + 36),
            child: GestureDetector(
              onTap: () {
                print('by it');
              },
              child: Text(
                'Select Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: _states.cardHeight + 72),
            child: Stack(
              children: [
                ScrollablePositionedList.separated(
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1, color: Colors.black,),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  itemCount: elementState.templates.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ElementUtils()
                            .cardElements(
                              viewOnly: true,
                              context: context,
                              elementList: elementState.templates[index].components,
                              onSelect: () {},
                            )
                            .build(),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTemplate = index;
                            });
                          },
                          child: Container(
                            height: _states.cardHeight,
                            width: _states.cardWidth,
                            decoration: BoxDecoration(
                              border: _selectedTemplate == index ? Border.all(
                                color: accentColor,
                                width: 3,
                              ) : Border.all(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(_states.cardRadius),
                            ),
                          ),
                        ),
                      ),
                      !elementState.templates[index].isFree ? Positioned(
                        top: 16,
                        right: 0,
                        child: Container(
                          width: 42,
                          height: 24,
                          decoration: BoxDecoration(
                            color: accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 3,
                              )
                            ]
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '\$${elementState.templates[index].price}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ) : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

