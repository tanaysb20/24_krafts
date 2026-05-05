import 'package:flutter/material.dart';

/// Lightweight adaptive sizing based on a 390x844 design baseline.
extension ResponsiveContext on BuildContext {
  static const double _designWidth = 390;
  static const double _designHeight = 844;

  Size get screenSize => MediaQuery.sizeOf(this);

  double get widthScale => (screenSize.width / _designWidth).clamp(0.85, 1.35);

  double get heightScale =>
      (screenSize.height / _designHeight).clamp(0.85, 1.25);

  double get scale => ((widthScale + heightScale) / 2).clamp(0.85, 1.3);

  bool get isCompactWidth => screenSize.width < 360;
  bool get isTabletWidth => screenSize.width >= 700;

  double rs(double value) => value * scale;
  double rw(double value) => value * widthScale;
  double rh(double value) => value * heightScale;
}
