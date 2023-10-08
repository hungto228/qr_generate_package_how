import 'dart:ui';

import 'package:custom_qr_generator/util.dart';

import '../../neighbors.dart';

abstract class QrElementShape {

  Path createPath(Offset offset, double size, Neighbors neighbors);

  const QrElementShape();
}

mixin ShapeRect implements QrElementShape {

  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) => Path()
    ..addRect(Rect.fromLTWH(offset.dx, offset.dy, size, size));
}


mixin ShapeCircle implements QrElementShape {

  abstract final double radiusFraction;

  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) {
    double cSizeFraction = radiusFraction.coerceIn(0.0, 1.0);
    double padding = size * (1 - cSizeFraction)/2;
    var sSize = size - 2*padding;
    return Path()
        ..addOval(Rect.fromLTWH(offset.dx + padding, offset.dy + padding,sSize, sSize));
  }
}

mixin ShapeRoundCorners implements QrElementShape {

    abstract final double cornerFraction;


    @override
    Path createPath(Offset offset, double size, Neighbors neighbors) {
      Path path = Path();
      double corner = cornerFraction.coerceIn(0, .5) * size;

      if (!neighbors.hasAny()){
        path.addRRect(RRect.fromLTRBR(
            offset.dx, offset.dy,
            offset.dx + size, offset.dy + size,
            Radius.circular(corner))
        );
      } else {

        double topLeft =0;
        double topRight=0;
        double bottomLeft=0;
        double bottomRight=0;

        if (!neighbors.top && !neighbors.left) {
          topLeft = corner;
        }
        if (!neighbors.top && !neighbors.right) {
          topRight = corner;
        }
        if (!neighbors.bottom && !neighbors.left) {
          bottomLeft = corner;
        }
        if (!neighbors.bottom && !neighbors.right) {
          bottomRight = corner;
        }

        path.addRRect(RRect.fromLTRBAndCorners(
          offset.dx, offset.dy, offset.dx + size, offset.dy + size,
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
        ));
      }

      return path;
    }
}
mixin ShapeRoundCornersBall implements QrElementShape {

  abstract final double cornerFraction;
abstract  final double widthFraction;
abstract  final bool topLeft;
abstract  final bool topRight;
abstract  final bool bottomLeft;
abstract  final bool bottomRight;

  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) {
    final cf = cornerFraction.coerceIn(0, 0.5);
    final cTopLeft = topLeft ? cf : 0;
    final cTopRight = topRight ? cf : 0;
    final cBottomLeft = bottomLeft ? cf : 0;
    final cBottomRight = bottomRight ? cf : 0;
    final w = size / 7 * widthFraction.coerceIn(0, 2);

    return Path()
      ..fillType=PathFillType.nonZero
      ..addRRect(
        RRect.fromLTRBAndCorners(
          offset.dx, offset.dy,
          offset.dx + size, offset.dy + size,
          topLeft: Radius.circular(size * cTopLeft),
          topRight: Radius.circular(size * cTopRight),
          bottomLeft: Radius.circular(size * cBottomLeft),
          bottomRight: Radius.circular(size * cBottomRight),
        ),
      );
  }
}

mixin SquareRotatedVertically implements QrElementShape {
  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) {
    return Path()
      ..moveTo(size / 2, 0)
      ..quadraticBezierTo(size / 2, 0, 0, size / 2)
      ..quadraticBezierTo(size / 2, size, size / 2, size)
      ..quadraticBezierTo(size / 2, size, size, size / 2)
      ..quadraticBezierTo(size / 2, size / 2, size, size / 2)
      ..close();
  }
}
mixin TriangleVertically implements QrElementShape {
  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) {
    return Path()
      ..moveTo(size / 2, 0)
      ..quadraticBezierTo(size / 2, 0, 0, size / 2)
      ..quadraticBezierTo(size / 2, size, size / 2, size)
      ..quadraticBezierTo(size / 2, size, size, size / 2)
      ..quadraticBezierTo(size / 2, size / 2, size, size / 2)
      ..close();
  }
}
mixin ShapeDarts implements QrElementShape {

  abstract final double cornerFraction;

  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) {
    return Path() ..moveTo(size / 2, 0)
      ..cubicTo(size * (0.5+offset.dx), size * (0.5+offset.dy), size * (0.5+offset.dy) , size * (0.5-offset.dx), size, size / 2)
      ..cubicTo(size * (0.5+offset.dy), size * (0.5+offset.dx), size * (0.5+offset.dx) , size * (0.5+offset.dy), size / 2, size)
      ..cubicTo(size * (0.5-offset.dx), size * (0.5+offset.dy), size * (0.5-offset.dy) , size * (0.5+offset.dx), 0, size / 2)
      ..cubicTo(size * (0.5-offset.dy), size * (0.5-offset.dx), size * (0.5-offset.dx) , size * (0.5-offset.dy), size / 2, 0);
  }
}