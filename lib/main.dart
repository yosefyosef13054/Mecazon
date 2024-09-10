import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/controller/connection_controller.dart';
import 'package:mecazone/view/Category/subcateory_controller.dart';
import 'package:mecazone/view/Menu/menu_controller.dart';
import 'package:mecazone/view/splash_screen.dart';
import 'package:mecazone/routes.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/localization/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  var controller = Get.put(MenusController());
  ThemeMode themeMode = ThemeMode.light;
  setLocale(Locale locale) {
    if (mounted) {
      setState(() {
          _locale = locale;
        }
      );
    }
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
        if (mounted) {
          setState(() {
              _locale = locale;
            },
          );
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    getLocale();
    getThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mecazon',
      onInit: () {
        Get.put(ConnectionService(), permanent: true);
        Get.create(() => SubCategoryController());
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: Routes.pages,
      navigatorKey: navigatorKey,
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }

  Future<void> getThemeMode() async {
    var controller  = Get.put(MenusController());
    themeMode = await controller.getThemeMode();
    setState(() {});
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
