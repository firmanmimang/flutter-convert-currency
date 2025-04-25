import 'package:flutter/material.dart';

class KConstants {
  static const String themeModeKey = 'themeModeKey';
}

class KButtonStyle {
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        Theme.of(context).primaryColor,
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.white,
      ),
    );
  }
}
