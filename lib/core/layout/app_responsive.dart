import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class AppBreakpoints {
  const AppBreakpoints._();

  static const double compact = 600;
  static const double medium = 840;
  static const double expanded = 1200;
}

class AppResponsive {
  const AppResponsive._();

  static bool isCompact(BuildContext context) {
    return MediaQuery.sizeOf(context).width < AppBreakpoints.compact;
  }

  static bool isMedium(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppBreakpoints.compact && width < AppBreakpoints.medium;
  }

  static bool isExpanded(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= AppBreakpoints.medium;
  }

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppBreakpoints.expanded) {
      return 1120;
    }
    if (width >= AppBreakpoints.medium) {
      return 920;
    }
    return width;
  }

  static double centeredContentWidth(
    BuildContext context, {
    required double horizontalPadding,
  }) {
    final maxWidth = contentMaxWidth(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    return math.min(
      maxWidth,
      math.max(0, screenWidth - (horizontalPadding * 2)),
    );
  }
}
