import 'package:aljoud_hospital/config/theme/app_theme.dart';
import 'package:aljoud_hospital/providers/language_provider.dart';
import 'package:aljoud_hospital/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/utils/routes_manager.dart';
import 'l10n/app_localizations.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      loadAppSettings();
      isInitialized = true;
    }
  }

  Future<void> loadAppSettings() async {
    await Provider.of<LanguageProvider>(context, listen: false).getLang();
    await Provider.of<ThemeProvider>(context, listen: false).getTheme();
  }

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.currentTheme,
        onGenerateRoute: RoutesManager.router,
        initialRoute: RoutesManager.splash,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [Locale("ar"), Locale("en")],
        locale: langProvider.locale,
      ),
    );
  }
}

