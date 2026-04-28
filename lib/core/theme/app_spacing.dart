import 'package:flutter/widgets.dart';

class AppSpacing {
  const AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(xl);
  static const EdgeInsets sectionPadding = EdgeInsets.all(lg);
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: sm,
    vertical: xs,
  );
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: sm,
  );
}
