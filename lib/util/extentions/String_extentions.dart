import 'dart:ui';

extension ColorParsing on String? {
  Color parstoColor() {
    String colortext = 'ff${this}';
    int hexColor = int.parse(colortext, radix: 16);

    return Color(hexColor);
  }
}
