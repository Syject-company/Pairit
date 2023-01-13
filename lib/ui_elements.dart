
import 'package:flutter/material.dart';

import 'states.dart';

class TopMainShape extends StatelessWidget {
  Widget body;
  double height;

  TopMainShape(
      { this.body,
        this.height,
      });


  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.topCenter,
      child: CustomPaint(
        painter: BoxShadowPainter(),
        child: ClipPath(
          clipper: CurveShape(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            decoration: BoxDecoration(
              color: accentColor,
            ),
            child: Center(
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}

class CurveShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    Path path = Path()
      ..moveTo(-size.height/5, 2*size.height/3)
      ..arcToPoint(Offset(size.width/2, size.height), radius: Radius.elliptical(size.width/2+size.height/4, size.height/3), clockwise: false)
      ..arcToPoint(Offset(size.width+size.height/5, 2*size.height/3), radius: Radius.elliptical(size.width/2+size.height/4, size.height/3), clockwise: false)
      ..lineTo(size.width+size.height/5, 0)
      ..lineTo(-size.height/5, 0)
      ..lineTo(-size.height/5, 2*size.height/3)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path = Path()
      ..moveTo(-size.height/5, 2*size.height/3)
      ..arcToPoint(Offset(size.width/2, size.height), radius: Radius.elliptical(size.width/2+size.height/4, size.height/3), clockwise: false)
      ..arcToPoint(Offset(size.width+size.height/5, 2*size.height/3), radius: Radius.elliptical(size.width/2+size.height/4, size.height/3), clockwise: false)
      ..lineTo(size.width+size.height/5, 0)
      ..lineTo(-size.height/5, 0)
      ..lineTo(-size.height/5, 2*size.height/3)
      ..close();

    canvas.drawShadow(path, Colors.black54, 6, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MessageTailShape extends StatelessWidget {
  final DateTime time;
  final String text;
  final bool isSent;

  MessageTailShape(
      { this.isSent,
        this.text,
        this.time,
      });


  @override
  Widget build(BuildContext context) {

    String postTime = "${time.day}.${time.month} "
        "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}:"
        "${time.second.toString().padLeft(2, '0')}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            color: isSent ? Colors.blue[200] : Colors.grey[300],
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  postTime,
                  textAlign: isSent ? TextAlign.right :TextAlign.left,
                  style: TextStyle(
                    fontSize: 10
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  textAlign: isSent ? TextAlign.right :TextAlign.left,
                ),
              ],
            ),
          ),
          CustomPaint(
            child: ClipPath(
              clipper: isSent ? CurveSendMessageTailShape() : CurveGetMessageTailShape(),
              child: Container(
                width: 24,
                height: 12,
                decoration: BoxDecoration(
                  color: isSent ? Colors.blue[200] : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurveSendMessageTailShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width/2, size.height)
      ..lineTo(size.width/2, 0)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurveGetMessageTailShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    Path path = Path()
      ..moveTo(size.width/2, 0)
      ..lineTo(size.width/2, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}