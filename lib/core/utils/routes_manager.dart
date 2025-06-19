import 'package:aljoud_hospital/presntation/notification/notification.dart';
import 'package:aljoud_hospital/presntation/screens/auth/create_new_password/create_new_password.dart';
import 'package:aljoud_hospital/presntation/screens/auth/forget_password/forget_password.dart';
import 'package:aljoud_hospital/presntation/screens/auth/log_in/login.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/doctor_register.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/register.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/doctor_profile.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/about_hospital/about_hospital.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/medical_record/medical_record.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/online_consultation/online_consultation.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/support/admin_screen/Insert_doctor/insert_doctor.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/support/admin_screen/admin_screen.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/support/admin_screen/update_doctor/update_doctor.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/support/faq_screen/faq_screen.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/support/support.dart';
import 'package:aljoud_hospital/presntation/screens/home/myBooking_tab/myBooking.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/edit_profile/edit_profile.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/profile.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/settings/settings.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/hospital_visit.dart';
import 'package:aljoud_hospital/presntation/screens/patient_details/patient_details.dart';
import 'package:aljoud_hospital/presntation/screens/payment/confirm_payment/confirm_payment.dart';
import 'package:aljoud_hospital/presntation/screens/payment/payment.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/category_details/CategoryDetailsScreen.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/view/see_all.dart';
import 'package:aljoud_hospital/presntation/screens/start/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model_api/selectedDoctor/Data.dart';
import '../../data/models/doctor/doctor_model.dart';
import '../../presntation/screens/home/categories_item/categories_item.dart';
import '../../presntation/screens/home/home.dart';
import '../../presntation/screens/splash/splash.dart';
import '../../test.dart';

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
  static const String support = '/support';
  static const String onlineConsultation = '/onlineConsultation';
  static const String notification = '/notification';
  static const String medicalRecords = '/medicalRecords';
  static const String admin = '/admin';
  static const String insertDoctor = '/insertDoctor';
  static const String updateDoctor = '/updateDoctor';
  static const String faq = '/faq';
  static const String testApiScreen = '/TestApiScreen';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {

      case testApiScreen:
        return MaterialPageRoute(
          builder: (context) =>  const TestScreen(),
        );
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
          builder: (context) => const ForgetPasswordScreen(),
        );
      case createNewPassword:
        return MaterialPageRoute(
          builder: (context) => const CreateNewPasswordScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case seeAll:
        return MaterialPageRoute(
          builder: (context) => const SeeAllScreen(),
        );
      case admin:
        return MaterialPageRoute(
          builder: (context) => const AdminScreen(),
        );
      case insertDoctor:
        return MaterialPageRoute(
          builder: (context) => const InsertDoctorScreen(),
        );
      case faq:
        return MaterialPageRoute(
          builder: (context) => const FAQScreen(),
        );
      case updateDoctor:
        return MaterialPageRoute(
          builder: (context) => const UpdateDoctorScreen(),
        );
      case hospitalVisit:
        final doctor = settings.arguments as Data?;
        if (doctor == null) {
          // لو الـ arguments null، ارجع صفحة بديلة أو اعمل شيء تاني
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text(
                  " لانوجد داتا ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const HospitalVisitScreen(),
          settings: RouteSettings(arguments: doctor),
        );
      case RoutesManager.doctorProfile:
        final doctor = settings.arguments as Data?;
        if (doctor == null) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text(
                  " لا توجد داتا ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const DoctorProfileScreen(),
          settings: RouteSettings(arguments: doctor),
        );
      case myBooking:
        return MaterialPageRoute(
          builder: (context) => const MyBookingScreen(),
        );
      case aboutHospital:
        return MaterialPageRoute(
          builder: (context) => const AboutHospitalScreen(),
        );
      case support:
        return MaterialPageRoute(
          builder: (context) => const SupportScreen(),
        );
      case notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case onlineConsultation:
        return MaterialPageRoute(
          builder: (context) => const VideoCallScreen(),
        );
      case medicalRecords:
        return MaterialPageRoute(
          builder: (context) => const MedicalRecordsScreen(),
        );
      case doctorRegister:
        return MaterialPageRoute(
          builder: (context) => DoctorRegisterScreen(),
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (context) => EditeProfileScreen(),
        );
      case settingScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
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
        return MaterialPageRoute(
          builder: (_) => const CategoryDetailsScreen(),
          settings: RouteSettings(arguments: settings.arguments as String?), // تعديل الـ cast لـ String?
        );
      default:return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No route defined")),
          ),
        );
    }
  }
}