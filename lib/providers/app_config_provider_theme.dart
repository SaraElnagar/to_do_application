import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = "en";

  void changeLanguage(String newLangauge) {
    if (appLanguage == newLangauge) {
      return;
    }
    appLanguage = newLangauge;
    notifyListeners();
  }
}
