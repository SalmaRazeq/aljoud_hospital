import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @splashText.
  ///
  /// In en, this message translates to:
  /// **'Your Health, Our priority'**
  String get splashText;

  /// No description provided for @yourDoctor.
  ///
  /// In en, this message translates to:
  /// **'Your Doctor,'**
  String get yourDoctor;

  /// No description provided for @anyTime.
  ///
  /// In en, this message translates to:
  /// **'Any time.'**
  String get anyTime;

  /// No description provided for @anyWhere.
  ///
  /// In en, this message translates to:
  /// **'Any Where.'**
  String get anyWhere;

  /// No description provided for @startText.
  ///
  /// In en, this message translates to:
  /// **'More than 100 doctors are ready to answer all your questions.'**
  String get startText;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @loginText1.
  ///
  /// In en, this message translates to:
  /// **'We are happy to see you again.'**
  String get loginText1;

  /// No description provided for @loginText2.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter your details.'**
  String get loginText2;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have account!'**
  String get haveAccount;

  /// No description provided for @notHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get notHaveAccount;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @plzEmail.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter email address'**
  String get plzEmail;

  /// No description provided for @wrongFormat.
  ///
  /// In en, this message translates to:
  /// **'Email wrong format'**
  String get wrongFormat;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @plzPassword.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter password'**
  String get plzPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @plzFullName.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter full name'**
  String get plzFullName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhone;

  /// No description provided for @plzPhone.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter phone number'**
  String get plzPhone;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @enterPassAgain.
  ///
  /// In en, this message translates to:
  /// **'Enter the password again'**
  String get enterPassAgain;

  /// No description provided for @password11digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 11 digits'**
  String get password11digits;

  /// No description provided for @notMatch.
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t match'**
  String get notMatch;

  /// No description provided for @password6Char.
  ///
  /// In en, this message translates to:
  /// **'Password should be at least 6 characters'**
  String get password6Char;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, '**
  String get hello;

  /// No description provided for @findYourDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find your doctor'**
  String get findYourDoctor;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @onlineConsultation.
  ///
  /// In en, this message translates to:
  /// **'Online Consultation'**
  String get onlineConsultation;

  /// No description provided for @bookOnline.
  ///
  /// In en, this message translates to:
  /// **'Book your online video consultation'**
  String get bookOnline;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book appointment'**
  String get bookAppointment;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @providingSupport.
  ///
  /// In en, this message translates to:
  /// **'Providing direct support with the customer service team'**
  String get providingSupport;

  /// No description provided for @medicalRecords.
  ///
  /// In en, this message translates to:
  /// **'Medical Records'**
  String get medicalRecords;

  /// No description provided for @patientInformation.
  ///
  /// In en, this message translates to:
  /// **'It provides the patient with information about his medical history'**
  String get patientInformation;

  /// No description provided for @cardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get cardiology;

  /// No description provided for @pulmonology.
  ///
  /// In en, this message translates to:
  /// **'Pulmonology'**
  String get pulmonology;

  /// No description provided for @dentistry.
  ///
  /// In en, this message translates to:
  /// **'Dentistry'**
  String get dentistry;

  /// No description provided for @dermatology.
  ///
  /// In en, this message translates to:
  /// **'Dermatology'**
  String get dermatology;

  /// No description provided for @eNT.
  ///
  /// In en, this message translates to:
  /// **'ENT'**
  String get eNT;

  /// No description provided for @internalMedicine.
  ///
  /// In en, this message translates to:
  /// **'Internal Medicine'**
  String get internalMedicine;

  /// No description provided for @neurology.
  ///
  /// In en, this message translates to:
  /// **'Neurology'**
  String get neurology;

  /// No description provided for @oBGYN.
  ///
  /// In en, this message translates to:
  /// **'OB-GYN'**
  String get oBGYN;

  /// No description provided for @oncology.
  ///
  /// In en, this message translates to:
  /// **'Oncology'**
  String get oncology;

  /// No description provided for @ophthalmology.
  ///
  /// In en, this message translates to:
  /// **'Ophthalmology'**
  String get ophthalmology;

  /// No description provided for @orthopedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopedics'**
  String get orthopedics;

  /// No description provided for @pediatrics.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics'**
  String get pediatrics;

  /// No description provided for @physicalTherapy.
  ///
  /// In en, this message translates to:
  /// **'Physical Therapy'**
  String get physicalTherapy;

  /// No description provided for @surgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery'**
  String get surgery;

  /// No description provided for @psychiatry.
  ///
  /// In en, this message translates to:
  /// **'Psychiatry'**
  String get psychiatry;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myBooking.
  ///
  /// In en, this message translates to:
  /// **'My Booking'**
  String get myBooking;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live chat'**
  String get liveChat;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @visitor.
  ///
  /// In en, this message translates to:
  /// **'Visitor'**
  String get visitor;

  /// No description provided for @bookHospitalVisit.
  ///
  /// In en, this message translates to:
  /// **'Book Hospital Visit'**
  String get bookHospitalVisit;

  /// No description provided for @contactHospital.
  ///
  /// In en, this message translates to:
  /// **'Contact Hospital'**
  String get contactHospital;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Years of experience'**
  String get yearsOfExperience;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @registeredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'You\'ve registered successfully.'**
  String get registeredSuccessfully;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @passwordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Sorry, your password is too weak.'**
  String get passwordTooWeak;

  /// No description provided for @accountAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'The account already exists for that email.'**
  String get accountAlreadyExists;

  /// No description provided for @wrongEorP.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password'**
  String get wrongEorP;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
