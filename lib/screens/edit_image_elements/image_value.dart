
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:bitmap/transformations.dart';
import 'package:flutter/material.dart';

class ImageValueNotifier extends ValueNotifier<Bitmap> {
  ImageValueNotifier() : super(null);

  Bitmap initial;

  double contrast;
  double brightness;
  double color;

  void reset() {
    value = initial;
  }

  void loadImage() async {
    const ImageProvider imageProvider = const AssetImage("assets/images/test.jpeg");

    value = await Bitmap.fromProvider(imageProvider);
    initial = value;

    contrast = 1.0;
    brightness = 0;
    color = 1.0;
  }

  void uploadImage(ImageProvider imageProvider) async {
    value = await Bitmap.fromProvider(imageProvider);
    initial = value;

    contrast = 1.0;
    brightness = 0;
    color = 1.0;
  }

  void setContrast(double value) async {
    contrast = value;
  }

  void setBrightness(double value) async {
    brightness = value;
  }

  void setColor(double value) async {
    color = value;
  }

  void imageStates() async {
    final temp = initial;
    value = null;

    final Uint8List converted = await updateImageElements(
      [temp.content, temp.width, temp.height, color, brightness, contrast],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
  }
}

Future<Uint8List> updateImageElements(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  Bitmap brightnessBitmap = brightness(bigBitmap, imageData[4]);

  Bitmap contrastBitmap = contrast(brightnessBitmap, imageData[5]);

  Bitmap returnBitmap = adjustColor(
    contrastBitmap,
    blacks: 0x00000000,
    whites: null,
    saturation: imageData[3], // 0 and 5 mid 1.0
    exposure: null, // 0 and 0.5 no mid
  );

  return returnBitmap.content;
}