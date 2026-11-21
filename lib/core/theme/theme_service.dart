import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeService extends ChangeNotifier {
  ThemeService() {
    _updateSystemUIOverlay();
  }

  ThemeMode get themeMode => ThemeMode.light;

  // Update system UI based on light theme
  void _updateSystemUIOverlay() {
    final uiStyle = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    
    SystemChrome.setSystemUIOverlayStyle(uiStyle);
  }
}