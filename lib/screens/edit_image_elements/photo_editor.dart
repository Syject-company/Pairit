import 'dart:io';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pairit/bloc/bloc/card_bloc.dart';
import 'package:pairit/entity/card_element_key.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:pairit/screens/card_editor.dart';
import 'package:pairit/screens/edit_body_widget/edit_body_portrait.dart';
import 'package:provider/provider.dart';

import '../../states.dart';
import '../../widgets.dart';
import 'edit_image_widgets.dart';
import 'image_value.dart';
import 'util.dart';

class PhotoEditor extends StatefulWidget {
  String imageUrl;
  ElementKey elementKey;

  PhotoEditor({this.imageUrl, this.elementKey});

  @override
  _PhotoEditorState createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  ImageValueNotifier imageValueNotifier = ImageValueNotifier();

  double _colorSliderValue = 0;
  double _brightnessSliderValue = 0;
  double _contrastSliderValue = 0;

  int selectedEditTab = 0;
  final picker = ImagePicker();
  bool isConnectedImage = false;

  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  void initState() {
    super.initState();
    if(widget.imageUrl != null && widget.imageUrl.isNotEmpty) {
      convertImage(widget.imageUrl);
    }
    // imageValueNotifier.loadImage();
  }

  void uploadImage(ImageProvider imageProvider) {
    imageValueNotifier.uploadImage(imageProvider);
    setState(() {
      isConnectedImage = true;
    });
  }

  void updateImageStates() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.imageStates();
    }
  }

  void setContrastValue(double value) {
    double contrastPoint;
    contrastPoint = 1.0 + value / 300;
    if (imageValueNotifier.value != null) {
      imageValueNotifier.setContrast(contrastPoint);
    }
  }

  void setBrightnessValue(double value) {
    double brightnessPoint;
    brightnessPoint = value / 200;
    if (imageValueNotifier.value != null) {
      imageValueNotifier.setBrightness(brightnessPoint);
    }
  }

  void setColorValue(double value) {
    double colorPoint;
    colorPoint = 1.0 + value / 50;
    if (imageValueNotifier.value != null) {
      imageValueNotifier.setColor(colorPoint);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _states = AppStates(context);
    final elementState = Provider.of<ElementProvider>(context);

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            Positioned(
              width: _states.width,
              height: _states.height * 0.08,
              top: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        if (widget.elementKey == ElementKey.background) {
                          elementState.setBackground(imageValueNotifier.value.buildHeaded());
                        }
                        if (widget.elementKey == ElementKey.logo) {
                          elementState.setLogo(imageValueNotifier.value.buildHeaded());
                        }
                        if (widget.elementKey == ElementKey.photo) {
                          elementState.setImage(imageValueNotifier.value.buildHeaded());
                        }

                        Navigator.push(context, MaterialPageRoute(builder: (_) => CardEditor()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: selectedEditTab == 3 ? () {} : addNewImage,
                onLongPressStart: selectedEditTab == 3 ? (details) {} : (details) {
                  print('start show original position '
                      + details.localPosition.toString() + ' '
                      + details.globalPosition.toString());
                },
                onLongPressEnd: selectedEditTab == 3 ? (details) {} : (details) {
                  print('end show original position '
                      + details.localPosition.toString() + ' '
                      + details.globalPosition.toString());
                },
                child: isConnectedImage
                    ? Padding(
                        padding: EdgeInsets.only(bottom: _states.height * 0.12),
                        child: ValueListenableBuilder<Bitmap>(
                          valueListenable:
                              imageValueNotifier ?? ImageValueNotifier(),
                          builder: (BuildContext context, Bitmap bitmap,
                              Widget child) {
                            if (bitmap == null) {
                              return const CircularProgressIndicator();
                            }
                            if (selectedEditTab == 3) {
                              return ExtendedImage.memory(
                                bitmap.buildHeaded(),
                                fit: BoxFit.contain,
                                mode: ExtendedImageMode.editor,
                                extendedImageEditorKey: editorKey,
                                initEditorConfigHandler: (state) {
                                  return EditorConfig(
                                      maxScale: 8.0,
                                      cropRectPadding: EdgeInsets.all(20.0),
                                      hitTestSize: 20.0,
                                      cropAspectRatio: 1);
                                },
                              );
                            } else {
                              return ExtendedImage.memory(
                                bitmap.buildHeaded(),
                              );
                            }

                          },
                        ),
                      )
                    : Text(
                        '+',
                        style: TextStyle(
                          fontSize: 120,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            isConnectedImage
                ? Positioned(
                    width: _states.width,
                    height: _states.height * 0.28,
                    bottom: 0,
                    left: 0,
                    child: bottomEditButtons(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }


  Future<void> addNewImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    ImageProvider pickedImage = Image.file(File(pickedFile.path)).image;


    uploadImage(pickedImage);
  }

  Future<void>  convertImage(String url) async {
    ImageProvider networkImage = Image.network(url).image;

    uploadImage(networkImage);
  }

  Widget bottomEditButtons() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EditActiveButton(
                icon: SvgPicture.asset('assets/images/edit_color.svg'),
                isActive: selectedEditTab == 0,
                onPressed: () {
                  setState(() {
                    selectedEditTab = 0;
                  });
                },
                label: 'Color',
              ),
              EditActiveButton(
                icon: SvgPicture.asset('assets/images/edit_brightness.svg'),
                isActive: selectedEditTab == 1,
                onPressed: () {
                  setState(() {
                    selectedEditTab = 1;
                  });
                },
                label: 'Light',
              ),
              EditActiveButton(
                icon: SvgPicture.asset('assets/images/edit_contrast.svg'),
                isActive: selectedEditTab == 2,
                onPressed: () {
                  setState(() {
                    selectedEditTab = 2;
                  });
                },
                label: 'Contrast',
              ),
              EditActiveButton(
                icon: SvgPicture.asset('assets/images/edit_cropp.svg'),
                isActive: selectedEditTab == 3,
                onPressed: () {
                  setState(() {
                    selectedEditTab = 3;
                  });
                },
                label: 'Cropp',
              ),
              EditActiveButton(
                icon: SvgPicture.asset('assets/images/edit_mask.svg'),
                isActive:selectedEditTab == 4,
                onPressed: () {
                  setState(() {
                    selectedEditTab = 4;
                  });
                },
                label: 'Mask',
              ),
            ],
          ),
          bottomEditTab(selectedEditTab),
        ],
      ),
    );
  }

  Widget bottomEditTab(int selectTab) {
    List<Widget> editTab = [
      Slider(
        value: _colorSliderValue,
        min: 0,
        max: 100,
        divisions: 100,
        activeColor: accentColor,
        inactiveColor: Colors.grey,
        label: _colorSliderValue.round().toString(),
        onChangeEnd: (double value) {
          setColorValue(value);
          updateImageStates();
        },
        onChanged: (double value) {
          setColorValue(value);
          setState(() {
            _colorSliderValue = value;
          });
        },
      ),
      Slider(
        value: _brightnessSliderValue,
        min: -100,
        max: 100,
        divisions: 200,
        activeColor: accentColor,
        inactiveColor: Colors.grey,
        label: _brightnessSliderValue.round().toString(),
        onChangeEnd: (double value) {
          setBrightnessValue(value);
          updateImageStates();
        },
        onChanged: (double value) {
          setBrightnessValue(value);
          setState(() {
            _brightnessSliderValue = value;
          });
        },
      ),
      Slider(
        value: _contrastSliderValue,
        min: -100,
        max: 100,
        divisions: 200,
        activeColor: accentColor,
        inactiveColor: Colors.grey,
        label: _contrastSliderValue.round().toString(),
        onChangeEnd: (double value) {
          setContrastValue(value);
          updateImageStates();
        },
        onChanged: (double value) {
          setState(() {
            setContrastValue(value);
            _contrastSliderValue = value;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.rotate_right),
            onPressed: () {
              editorKey.currentState.rotate(right: true);
            },
          ),
          IconButton(
            icon: Icon(Icons.flip),
            onPressed: () {
              editorKey.currentState.flip();
            },
          ),
          IconButton(
            icon: Icon(Icons.crop_free),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              cropImage();
            },
          )
        ],
      ),
      AccentButton(
        label: 'Remove background',
        onPressed: () {

        },
      )
    ];

    return editTab[selectTab];
  }

  Future<void> cropImage() async {
    final Uint8List fileData = Uint8List.fromList(
        await cropImageDataWithDartLibrary(state: editorKey.currentState));

    uploadImage(Image.memory(fileData).image);
  }
}
