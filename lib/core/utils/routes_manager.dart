import 'package:aljoud_hospital/presntation/screens/auth/create_new_password/create_new_password.dart';
import 'package:aljoud_hospital/presntation/screens/auth/forget_password/forget_password.dart';
import 'package:aljoud_hospital/presntation/screens/auth/log_in/login.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/doctor_register.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/register.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/doctor_profile.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/about_hospital/about_hospital.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/edit_profile/edit_profile.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/profile.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/settings/settings.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/hospital_visit.dart';
import 'package:aljoud_hospital/presntation/screens/home/myBooking_tab/myBooking.dart';
import 'package:aljoud_hospital/presntation/screens/patient_details/patient_details.dart';
import 'package:aljoud_hospital/presntation/screens/payment/confirm_payment/confirm_payment.dart';
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
  static const String forgetPassword = '/forgetPassword';
  static const String createNewPassword = '/createNewPassword';
  static const String register = '/register';
  static const String seeAll = '/seeAll';
  static const String hospitalVisit = '/hospitalVisit';
  static const String categoryDetails = '/categoryDetails';
  static const String patientDetails = '/patientDetails';
  static const String myBooking = '/myBooking';
  static const String payment = '/payment';
  static const String confirmPayment = '/confirmPayment';
  static const String doctorProfile = '/doctorProfile';
  static const String doctorRegister = '/doctorRegister';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String settingScreen = '/settingScreen';
  static const String aboutHospital = '/aboutHospital';



  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case start:
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
        );
      case RoutesManager.home:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return Home(selectedIndex: args as int? ?? 0);
          },
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case forgetPassword:
        return MaterialPageRoute(
          builder: (context) => ForgetPasswordScreen(),
        );
      case createNewPassword:
        return MaterialPageRoute(
          builder: (context) => CreateNewPasswordScreen(),
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
      case aboutHospital:
        return MaterialPageRoute(
          builder: (context) => AboutHospitalScreen(),
        );
      case doctorRegister:
        return MaterialPageRoute(
          builder: (context) => DoctorRegisterScreen(),
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (context) => EditeProfileScreen(),
        );
      case settingScreen:
        return MaterialPageRoute(
          builder: (context) => SettingScreen(),
        );
      case payment:
        final args = settings.arguments as Map<String, dynamic>;
        final doctor = args['doctor'] as DoctorModel;
        return MaterialPageRoute(
          builder: (context) => PaymentScreen( doctor: doctor,),
        );
      case confirmPayment:
        final args = settings.arguments as Map<String, dynamic>;
        final doctor = args['doctor'] as DoctorModel;
        return MaterialPageRoute(
          builder: (context) => ConfirmPaymentScreen(doctor: doctor,),
        );

      case patientDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final doctor = args['doctor'] as DoctorModel;
        return MaterialPageRoute(
          builder: (context) => PatientDetailsScreen(
            doctor: doctor,
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