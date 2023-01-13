import 'package:flutter/material.dart';
import 'package:pairit/entity/component_states.dart';
import 'package:pairit/models/card_base.dart';
import 'package:pairit/entity/card_components.dart';
import 'package:pairit/entity/card_element_key.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:pairit/states.dart';
import 'package:pairit/widgets/card_components_view.dart';
import 'package:provider/provider.dart';


class ElementUtils {
  TextEditingController companyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController facebookController = TextEditingController();



  CardBase cardElements({BuildContext context, List<CardComponents> elementList, VoidCallback onSelect, bool viewOnly = false}) {
    final elementState = Provider.of<ElementProvider>(context);
    CardBase cardBase = CardBase(context);

    for(CardComponents element in elementList) {
      if (element.elementKey == ElementKey.background) {
        print('background in states ' + (elementState.background != null).toString());
        print('background ' + elementState.background.toString());
        cardBase.addWidget(
          size: (element.componentStates.value == null || element.componentStates.value.isEmpty)
              ? element.size : Size(900, 500),
          position: (element.componentStates.value == null || element.componentStates.value.isEmpty)
              ? element.position : Offset(0, 0),
          elementKey: element.elementKey,
          componentStates: element.componentStates,
          child: CardImageBackground(
            url: element.componentStates.value,
            onSelect: () {
              elementState.setElementKey(element.elementKey);
              onSelect();
            },
          ),
        );
      } else if (element.elementKey == ElementKey.logo) {
        print('logo in states ' + (elementState.background != null).toString());
        cardBase.addWidget(
          size: element.size,
          position: element.position,
          elementKey: element.elementKey,
          child: elementState.logo == null ? CardImageElement(
            url: element.componentStates.value,
            onSelect: () {
              elementState.setElementKey(element.elementKey);
              onSelect();
            },
          ) : GestureDetector(
            onTap: () {
              elementState.setElementKey(element.elementKey);
              onSelect();
            },
            child: Image.memory(elementState.logo, fit: BoxFit.contain),
          ),
        );
      } else if (element.elementKey == ElementKey.photo) {
        cardBase.addWidget(
          size: element.size,
          position: element.position,
          elementKey: element.elementKey,
          child: elementState.image == null ? CardImageElement(
            url: element.componentStates.value,
            onSelect: () {
              elementState.setElementKey(element.elementKey);
              onSelect();
            },
          ) : GestureDetector(
            onTap: () {
              elementState.setElementKey(element.elementKey);
              onSelect();
            },
            child: Image.memory(elementState.image),
          ),
        );
      } else if (viewOnly) {
        cardBase.addWidget(
          size: element.size,
          position: element.position,
          elementKey: element.elementKey,
          child: CardTextViewElement(
            value: getControllerByKey(element.elementKey, elementList)?.text,
            states: element.componentStates,
          ),
        );
      } else {
        cardBase.addWidget(
          size: element.size,
          position: element.position,
          elementKey: element.elementKey,
          child: CardTextElement(
            icon: (element.componentStates.icon != 0)
                ? Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    cardIcons[element.componentStates.icon],
                    color: element.componentStates.iconColor,
                    size: 8,
                  ),
                )
                : SizedBox(),
            readOnly: viewOnly,
            onSelect: () {
              elementState.setElementKey(element.elementKey);
              onSelect();
            },
            controller: getControllerByKey(element.elementKey, elementList),
            states: element.componentStates,
            onChanged: (value) => element.componentStates.value = value,
          ),
        );
      }
    }

    return cardBase;
  }

  TextEditingController getControllerByKey(ElementKey elementKey, List<CardComponents> elementList) {
    TextEditingController controller;
    switch (elementKey) {
      case ElementKey.name:
        {
          controller = nameController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.name) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.companyInfo:
        {
          controller = companyController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.companyInfo) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.phoneNumber1:
        {
          controller = phone1Controller;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.phoneNumber1) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.phoneNumber2:
        {
          controller = phone2Controller;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.phoneNumber2) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.address:
        {
          controller = addressController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.address) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.web:
        {
          controller = webController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.web) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.instaLink:
        {
          controller = instaController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.instaLink) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.email:
        {
          controller = emailController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.email) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
      case ElementKey.facebook:
        {
          controller = facebookController;
          for(CardComponents element in elementList) {
            if (element.elementKey == ElementKey.facebook) {
              controller.text = element.componentStates.value;
            }
          }
        }
        break;
    }

    return controller;
  }

}

