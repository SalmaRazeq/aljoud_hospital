import 'package:aljoud_hospital/providers/firebase_notification.dart';
import 'package:aljoud_hospital/providers/language_provider.dart';
import 'package:aljoud_hospital/providers/notification_provider.dart';
import 'package:aljoud_hospital/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/firebase_options.dart';
import 'my_app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LanguageProvider(),),
      ChangeNotifierProvider(create: (_) => ThemeProvider(),),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
  ],
      child: const MyApp())
  );
}