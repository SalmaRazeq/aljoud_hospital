import 'package:aljoud_hospital/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/routes_manager.dart';
import 'l10n/app_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: RoutesManager.router,
        initialRoute: RoutesManager.seeAll,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [Locale("ar"), Locale("en")],
        locale: const Locale('en'),
      ),
    );
  }
}
