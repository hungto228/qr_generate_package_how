
import 'package:custom_qr_generator/shapes/shape.dart';

abstract class QrBallShape extends QrElementShape {

  const QrBallShape();

  static const basic = QrBallShapeDefault();

  static QrBallShapeCircle circle({double radiusFraction = 1}) =>
      QrBallShapeCircle(radiusFraction: radiusFraction);

  static QrBallShapeRoundCorners roundCorners({
    required double cornerFraction
  }) => QrBallShapeRoundCorners(cornerFraction: cornerFraction);
}

class QrBallShapeDefault extends QrBallShape with ShapeRect {
  const QrBallShapeDefault();

  @override
  bool operator ==(Object other) => other is QrBallShapeDefault;

  @override
  int get hashCode => 0;
}

class QrBallShapeCircle extends QrBallShape with ShapeCircle {

  @override
  final double radiusFraction;

  const QrBallShapeCircle({this.radiusFraction = 1});

  @override
  bool operator ==(Object other) => other is QrBallShapeCircle &&
    other.radiusFraction == radiusFraction;

  @override
  int get hashCode => radiusFraction.hashCode;

}

class QrBallShapeRoundCorners extends QrBallShape with ShapeRoundCorners {

  @override
  final double cornerFraction;

  const QrBallShapeRoundCorners({required this.cornerFraction});

  @override
  bool operator ==(Object other) => other is QrBallShapeRoundCorners &&
    other.cornerFraction == cornerFraction;

  @override
  int get hashCode => cornerFraction.hashCode;

}
class QrBallShapeRoundCornersBall extends QrBallShape with ShapeRoundCorners {

  @override
  final double cornerFraction;
  final double widthFraction;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const QrBallShapeRoundCornersBall(this.widthFraction, this.topLeft, this.topRight, this.bottomLeft, this.bottomRight, {required this.cornerFraction});

  @override
  bool operator ==(Object other) =>
      other is QrBallShapeRoundCornersBall &&
          other.cornerFraction == cornerFraction &&
          other.widthFraction == widthFraction &&
          other.bottomRight == bottomRight &&
          other.bottomLeft == bottomLeft &&
          other.topLeft == topLeft &&
          other.topRight == topRight;

  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = hashCode * 31 + cornerFraction.hashCode;
    hashCode = hashCode * 31 + widthFraction.hashCode;
    hashCode = hashCode * 31 + bottomRight.hashCode;
    hashCode = hashCode * 31 + bottomLeft.hashCode;
    hashCode = hashCode * 31 + topLeft.hashCode;
    hashCode = hashCode * 31 + topRight.hashCode;
    return hashCode;
  }

}

class QrBallSquareRotatedVertically extends QrBallShape
    with SquareRotatedVertically {
  const QrBallSquareRotatedVertically();

  @override
  bool operator ==(Object other) => other is QrBallSquareRotatedVertically;

  @override
  int get hashCode => 0;
}
class QrBallTriangleVertically extends QrBallShape
    with TriangleVertically {
  const QrBallTriangleVertically();

  @override
  bool operator ==(Object other) => other is QrBallTriangleVertically;

  @override
  int get hashCode => 0;
}
class QrBallShapeDarts extends QrBallShape with ShapeDarts {

  @override
  final double cornerFraction;

  const QrBallShapeDarts({required this.cornerFraction});

  @override
  bool operator ==(Object other) => other is QrBallShapeDarts &&
      other.cornerFraction == cornerFraction;

  @override
  int get hashCode => cornerFraction.hashCode;

}