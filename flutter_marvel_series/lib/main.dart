import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

import 'app/data/constants/locales.dart';
import 'app/presentation/pages/splash/splash_page.dart';
import 'app/presentation/utils/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales.map(localeFromIsoCode).toList(),
      path: 'assets/locales',
      fallbackLocale: localeFromIsoCode(fallbackLocale),
      assetLoader: YamlAssetLoader(), //RootBundleAssetLoader(),
      //fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            headline6: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            bodyText1: TextStyle(
              fontFamily: 'Montserrat',
            ),
            bodyText2: TextStyle(
              fontFamily: 'Montserrat',
            )),
      ),
      home: SplashPage(),
    );
  }
}
