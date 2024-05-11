import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyality_cashier/core/localization/ar/ar_translations.dart';
import 'package:loyality_cashier/core/localization/en_us/en_us_translations.dart';

class AppLocalizationController extends GetxController {
  late Locale locale;

  final Map<String, Map<String, String>> _localizedValues = {
    'ar': arAr,
    'en': enUs,
  };

  static AppLocalizationController get to => Get.find();

  void changeLocale(Locale newLocale) {
    locale = newLocale;
    update();
  }

  static List<String> languages() => ['ar', 'en'];

  String getString(String text) =>
      _localizedValues[locale.languageCode]![text] ?? text;
}

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'app_title': 'NCEJ',

    },
    'ar': {
      'app_title': 'NCEJ', 
     
    },
  };
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizationController> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizationController.languages().contains(locale.languageCode);

  @override
  Future<AppLocalizationController> load(Locale locale) {
    final localization = AppLocalizationController();
    localization.locale = locale;
    return Future.value(localization);
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

extension LocalizationExtension on String {
  String get tr {
    final localization = AppLocalizationController.to;
    return localization.getString(this);
  }
}