import 'package:aljoud_hospital/presntation/screens/auth/log_in/login.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/doctor_register.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/patient_register.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/register.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/doctor_profile.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/hospital_visit.dart';
import 'package:aljoud_hospital/presntation/screens/home/myBooking_tab/myBooking.dart';
import 'package:aljoud_hospital/presntation/screens/patient_details/patient_details.dart';
import 'package:aljoud_hospital/presntation/screens/payment/payment.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/category_details/CategoryDetailsScreen.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/see_all.dart';
import 'package:aljoud_hospital/presntation/screens/start/start.dart';
import 'package:flutter/material.dart';
import '../../data/models/doctor_model.dart';
import '../../presntation/screens/home/categories_item/categories_item.dart';
import '../../presntation/screens/home/home.dart';
import '../../presntation/screens/splash/splash.dart';

class RoutesManager{
  static const String splash = '/splash';
  static const String home = '/home';
  static const String start = '/start';
  static const String login = '/login';
  static const String register = '/register';
  static const String seeAll = '/seeAll';
  static const String hospitalVisit = '/hospitalVisit';
  static const String categoryDetails = '/categoryDetails';
  static const String patientDetails = '/patientDetails';
  static const String myBooking = '/myBooking';
  static const String payment = '/payment';
  static const String doctorProfile = '/doctorProfile';
  static const String doctorRegister = '/doctorRegister';




  static Route? router(RouteSettings settings) {
    final CategoriesItem category;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case start:
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => Home(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case seeAll:
        return MaterialPageRoute(
          builder: (context) => SeeAllScreen(),
        );
      case hospitalVisit:
        final doctor = settings.arguments as Doctor;
        return MaterialPageRoute(
          builder: (context) => HospitalVisitScreen(doctor: doctor),
        );
      case doctorProfile:
        final doctor = settings.arguments as Doctor;
        return MaterialPageRoute(
          builder: (context) => DoctorProfileScreen(doctor: doctor),
        );
      case myBooking:
        return MaterialPageRoute(
          builder: (context) => MyBookingScreen(),
        );
      case doctorRegister:
        return MaterialPageRoute(
          builder: (context) => DoctorRegisterScreen(),
        );
      case payment:
        final args = settings.arguments as Map<String, dynamic>;
        final doctor = args['doctor'] as DoctorModel;
        return MaterialPageRoute(
          builder: (context) => PaymentScreen( doctor: doctor,),
        );

      case patientDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final doctor = args['doctor'] as DoctorModel;
        final selectedTime = args['selectedTime'] as String;
        final selectedDay = args['selectedDay'] as String;
        final selectedType = args['selectedType'] as String;
        return MaterialPageRoute(
          builder: (context) => PatientDetailsScreen(
            doctor: doctor,
            selectedTime: selectedTime,
            selectedDay: selectedDay,
            selectedMeetingType: selectedType,
          ),
        );
      case categoryDetails:
        final category = settings.arguments as CategoriesItem;
        return MaterialPageRoute(
          builder: (_) => CategoryDetailsScreen(category: category),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No route defined")),
          ),
        );
    }
  }
}