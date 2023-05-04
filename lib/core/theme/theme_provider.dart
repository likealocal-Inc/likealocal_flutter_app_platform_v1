import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/core/utils/enum_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { dark, light }

final themeProvider = StateProvider<ThemeNotifier>((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ThemeType _themeType = ThemeType.light;
  ThemeType get themeType => _themeType;

  // 테마 초기화
  init() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    var theme = sharedPreference.getString(SharedPreferencesKeys.themeKey.name);

    if (theme == null) {
      sharedPreference.setString(
          SharedPreferencesKeys.themeKey.name, _themeType.name);
    } else {
      ThemeType t = ThemeType.values
          .firstWhere((e) => e.toString() == 'ThemeType.$theme');
      _themeType = t;
    }
    notifyListeners();
  }

  // 테마 세팅
  void setTheme(ThemeType type) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString(
        SharedPreferencesKeys.themeKey.name, type.name);
    _themeType = type;

    notifyListeners();
  }
}
