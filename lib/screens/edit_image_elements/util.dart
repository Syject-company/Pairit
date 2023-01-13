
import 'dart:typed_data';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:image/image.dart';
import 'package:isolate/isolate.dart';
import 'package:isolate/load_balancer.dart';

final Future<LoadBalancer> loadBalancer =
LoadBalancer.create(1, IsolateRunner.spawn);

Future<List<int>> cropImageDataWithDartLibrary(
    {ExtendedImageEditorState state}) async {
  print('dart library start cropping');

  ///crop rect base on raw image
  final Rect cropRect = state.getCropRect();

  // in web, we can't get rawImageData due to .
  // using following code to get imageCodec without download it.
  // final Uri resolved = Uri.base.resolve(key.url);
  // // This API only exists in the web engine implementation and is not
  // // contained in the analyzer summary for Flutter.
  // return ui.webOnlyInstantiateImageCodecFromUrl(
  //     resolved); //

  final Uint8List data = state.rawImageData;

  final EditActionDetails editAction = state.editAction;

  final DateTime time1 = DateTime.now();

  /// it costs much time and blocks ui.
  //Image src = decodeImage(data);

  /// it will not block ui with using isolate.
  //Image src = await compute(decodeImage, data);
  //Image src = await isolateDecodeImage(data);
  Image src;
  LoadBalancer lb;
  lb = await loadBalancer;
  src = await lb.run<Image, List<int>>(decodeImage, data);

  final DateTime time2 = DateTime.now();

  print('${time2.difference(time1)} : decode');

  //clear orientation
  src = bakeOrientation(src);

  if (editAction.needCrop) {
    src = copyCrop(src, cropRect.left.toInt(), cropRect.top.toInt(),
        cropRect.width.toInt(), cropRect.height.toInt());
  }

  if (editAction.needFlip) {
    Flip mode;
    if (editAction.flipY && editAction.flipX) {
      mode = Flip.both;
    } else if (editAction.flipY) {
      mode = Flip.horizontal;
    } else if (editAction.flipX) {
      mode = Flip.vertical;
    }
    src = flip(src, mode);
  }

  if (editAction.hasRotateAngle) {
    src = copyRotate(src, editAction.rotateAngle);
  }

  final DateTime time3 = DateTime.now();
  print('${time3.difference(time2)} : crop/flip/rotate');

  /// you can encode your image
  ///
  /// it costs much time and blocks ui.
  //var fileData = encodeJpg(src);

  /// it will not block ui with using isolate.
  //var fileData = await compute(encodeJpg, src);
  //var fileData = await isolateEncodeImage(src);
  List<int> fileData;
  fileData = await lb.run<List<int>, Image>(encodeJpg, src);

  final DateTime time4 = DateTime.now();
  print('${time4.difference(time3)} : encode');
  print('${time4.difference(time1)} : total time');
  return fileData;
}