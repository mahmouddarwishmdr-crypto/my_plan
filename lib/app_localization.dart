import 'package:flutter/material.dart';

final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

class AppLocalization {
  static bool isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar';

  static String text(BuildContext context, String english, String arabic) {
    return isArabic(context) ? arabic : english;
  }

  static TextDirection direction(BuildContext context) =>
      isArabic(context) ? TextDirection.rtl : TextDirection.ltr;
}

class AppLanguageScope extends StatelessWidget {
  final Widget child;

  const AppLanguageScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nutrition',
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFF7F8FC),
            fontFamily: 'Arial',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF5B35F5),
              brightness: Brightness.light,
            ),
          ),
          builder: (context, child) {
            return Directionality(
              textDirection: locale.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child!,
            );
          },
          home: child,
        );
      },
    );
  }
}

String appText(BuildContext context, String english, String arabic) =>
    AppLocalization.text(context, english, arabic);
