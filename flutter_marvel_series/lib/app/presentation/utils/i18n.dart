import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_series/app/data/constants/countries.dart';
import 'package:intl/intl_standalone.dart';

export 'package:easy_localization/easy_localization.dart';

/// Obtiene una instancia de [Locale] a partir del código ISO en [isoCode]
Locale localeFromIsoCode(String isoCode) {
  if (isoCode == null ||
      (isoCode.length != 2 && isoCode.length != 5) ||
      (isoCode.length == 5 && isoCode[2] != '-' && isoCode[2] != '_')) {
    return null;
  }
  return Locale(isoCode.substring(0, 2),
      isoCode.length == 5 ? isoCode.substring(3) : null);
}

/// Obtiene una instancia de [Locale] con la localización del dispositivo
Future<Locale> getSystemLocale() async =>
    localeFromIsoCode(await findSystemLocale());

/// Obtiene una instancia de [Locale] con la localización de la app
Future<Locale> getAppLocale() async => await getSystemLocale();

/// Obtiene el nombre localizado de un país a partir de su código ISO de dos letras
String localizedCountryName(String countryIsoCode2) =>
    'country.${countryIsoCode2.toUpperCase()}'.tr();

/// Obtiene una lista localizada de los paises soportados adecuada para su uso en componentes Dropdown
final List<DropdownMenuItem> appSupportedCountryItems = appSupportedCountries
    .map((code) =>
        DropdownMenuItem(value: code, child: Text(localizedCountryName(code))))
    .toList();

/// Devuelve `true` si el código ISO de país de dos letras [countryCode] se encuentra entre los paises soportados
bool isAppSupportedCountry(String countryCode) =>
    appSupportedCountries.contains(countryCode);

/// Obtiene la ruta al archivo de terminos y condiciones según el idioma de la app
Future<String> termsPath() async {
  final locale = await getAppLocale();
  return 'assets/locales/terms_${locale.languageCode}.md';
}

/// Obtiene la ruta al archivo de recomendaciones según el idioma de la app
Future<String> suggestionsPath() async {
  final locale = await getAppLocale();
  return 'assets/locales/sugcovid_${locale.languageCode}.md';
}

extension StringTranslation on String {
  /// Obtiene el texto traducido indexado por la clave del string
  // ignore: missing_return
  String get T {
    try {
      return tr(this);
      // ignore: avoid_catching_errors
    } on NoSuchMethodError {
      return this;
    }
  }
}
