import 'dart:ui';

import 'package:intl/intl.dart';

extension ColorParsing on String? {
  Color parstoColor() {
    String colortext = 'ff${this}';
    int hexColor = int.parse(colortext, radix: 16);

    return Color(hexColor);
  }
}
