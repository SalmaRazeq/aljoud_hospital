import 'package:aljoud_hospital/presntation/screens/see_all/view_model/doctor_view_model.dart';
import 'package:aljoud_hospital/providers/language_provider.dart';
import 'package:aljoud_hospital/providers/notification_provider.dart';
import 'package:aljoud_hospital/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final languageProvider = LanguageProvider();
  final themeProvider = ThemeProvider();

  await languageProvider.getLang();
  await themeProvider.getTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>.value(value: languageProvider),
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => DoctorViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
