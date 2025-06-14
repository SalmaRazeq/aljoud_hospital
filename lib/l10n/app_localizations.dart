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
  /// **'Your Health, Our Priority'**
  String get splashText;

  /// No description provided for @yourDoctor.
  ///
  /// In en, this message translates to:
  /// **'Your Doctor,'**
  String get yourDoctor;

  /// No description provided for @anyTime.
  ///
  /// In en, this message translates to:
  /// **'Anytime.'**
  String get anyTime;

  /// No description provided for @anyWhere.
  ///
  /// In en, this message translates to:
  /// **'Anywhere.'**
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
  /// **'Already have an account!'**
  String get haveAccount;

  /// No description provided for @notHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get notHaveAccount;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @plzEmail.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter email address'**
  String get plzEmail;

  /// No description provided for @wrongFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
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
  /// **'Please, Enter the password again'**
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

  /// No description provided for @aboutHospital.
  ///
  /// In en, this message translates to:
  /// **'About Hospital'**
  String get aboutHospital;

  /// No description provided for @aboutHospitalText.
  ///
  /// In en, this message translates to:
  /// **'Read information about the hospital'**
  String get aboutHospitalText;

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

  /// No description provided for @chatBot.
  ///
  /// In en, this message translates to:
  /// **'Chat Bot'**
  String get chatBot;

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

  /// No description provided for @slotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Slots available'**
  String get slotsAvailable;

  /// No description provided for @slots.
  ///
  /// In en, this message translates to:
  /// **'Slots'**
  String get slots;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @night.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get night;

  /// No description provided for @appointmentType.
  ///
  /// In en, this message translates to:
  /// **'Appointment Type'**
  String get appointmentType;

  /// No description provided for @hospitalVisitSchedule.
  ///
  /// In en, this message translates to:
  /// **'Hospital Visit Schedule'**
  String get hospitalVisitSchedule;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @inPerson.
  ///
  /// In en, this message translates to:
  /// **'In-Person'**
  String get inPerson;

  /// No description provided for @patientDetails.
  ///
  /// In en, this message translates to:
  /// **'Patient Details'**
  String get patientDetails;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Patient name'**
  String get patientName;

  /// No description provided for @selectYourAgeRange.
  ///
  /// In en, this message translates to:
  /// **'Select your age range'**
  String get selectYourAgeRange;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @problem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get problem;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @tellTheDrYourProblem.
  ///
  /// In en, this message translates to:
  /// **'Tell the doctor about your problem'**
  String get tellTheDrYourProblem;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @addNewCard.
  ///
  /// In en, this message translates to:
  /// **'Add new card'**
  String get addNewCard;

  /// No description provided for @payWith.
  ///
  /// In en, this message translates to:
  /// **'Pay with'**
  String get payWith;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @paymentAndBookingCompleted.
  ///
  /// In en, this message translates to:
  /// **'Payment and Booking completed'**
  String get paymentAndBookingCompleted;

  /// No description provided for @failedToBook.
  ///
  /// In en, this message translates to:
  /// **'Failed to book'**
  String get failedToBook;

  /// No description provided for @upComing.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upComing;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @upComingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointment'**
  String get upComingAppointment;

  /// No description provided for @noBookingsFound.
  ///
  /// In en, this message translates to:
  /// **'No bookings found'**
  String get noBookingsFound;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @jan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get jan;

  /// No description provided for @feb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get feb;

  /// No description provided for @mar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get mar;

  /// No description provided for @apr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get apr;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @jun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get jun;

  /// No description provided for @jul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get jul;

  /// No description provided for @aug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get aug;

  /// No description provided for @sep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get sep;

  /// No description provided for @oct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get oct;

  /// No description provided for @nov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get nov;

  /// No description provided for @dec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get dec;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @plzEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter your name'**
  String get plzEnterName;

  /// No description provided for @enterHeight.
  ///
  /// In en, this message translates to:
  /// **'Enter your height'**
  String get enterHeight;

  /// No description provided for @enterWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter your weight'**
  String get enterWeight;

  /// No description provided for @doctorProfile.
  ///
  /// In en, this message translates to:
  /// **'Doctor Profile'**
  String get doctorProfile;

  /// No description provided for @yearsOf.
  ///
  /// In en, this message translates to:
  /// **'Years of'**
  String get yearsOf;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'experience'**
  String get experience;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @workingTime.
  ///
  /// In en, this message translates to:
  /// **'Working time'**
  String get workingTime;

  /// No description provided for @aboutText1.
  ///
  /// In en, this message translates to:
  /// **'Consultant of'**
  String get aboutText1;

  /// No description provided for @aboutText2.
  ///
  /// In en, this message translates to:
  /// **'at Smouha Hospital, More than 30 years of experience'**
  String get aboutText2;

  /// No description provided for @workingTimeText.
  ///
  /// In en, this message translates to:
  /// **'Tuesday - Sunday'**
  String get workingTimeText;

  /// No description provided for @voiceCall.
  ///
  /// In en, this message translates to:
  /// **'VoiceCall'**
  String get voiceCall;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'(Cm)'**
  String get cm;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'(Kg)'**
  String get kg;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed!'**
  String get confirmed;

  /// No description provided for @hospitalName.
  ///
  /// In en, this message translates to:
  /// **'Hospital name:  AlJoud'**
  String get hospitalName;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid:'**
  String get paid;

  /// No description provided for @bookingText.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been successfully booked. Please arrive 10 minutes early.'**
  String get bookingText;

  /// No description provided for @viewMyBooking.
  ///
  /// In en, this message translates to:
  /// **'View my bookings'**
  String get viewMyBooking;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backHome;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @medicalLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Medical License Number'**
  String get medicalLicenseNumber;

  /// No description provided for @plzEnterMedicalLicence.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter your medical license number'**
  String get plzEnterMedicalLicence;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// No description provided for @plzEnterSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Please, Enter your specialization'**
  String get plzEnterSpecialization;

  /// No description provided for @iAgreeToTheTermsConditions.
  ///
  /// In en, this message translates to:
  /// **'I Agree To The Terms & Conditions'**
  String get iAgreeToTheTermsConditions;

  /// No description provided for @enterEmailToReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to reset your password.'**
  String get enterEmailToReset;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @hint_type_message.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get hint_type_message;

  /// No description provided for @bot_greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello! How can I help you today?'**
  String get bot_greeting;

  /// No description provided for @bot_feeling.
  ///
  /// In en, this message translates to:
  /// **'I\'m doing great! How about you?'**
  String get bot_feeling;

  /// No description provided for @bot_glad_response.
  ///
  /// In en, this message translates to:
  /// **'That\'s great to hear! How can I assist you today?'**
  String get bot_glad_response;

  /// No description provided for @bot_booking_prompt.
  ///
  /// In en, this message translates to:
  /// **'Of course! We have excellent doctors. Which specialty would you like to book? You can choose from:\n1. Internal Medicine\n2. Pediatrics\n3. Orthopedics\n4. Dentistry\n5. Pulmonology\n6. Cardiology\n7. Physical Therapy\n8. OB-GYN'**
  String get bot_booking_prompt;

  /// No description provided for @bot_unknown.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I didn\'t understand that. Could you please rephrase?'**
  String get bot_unknown;

  /// No description provided for @bot_chosen_specialty.
  ///
  /// In en, this message translates to:
  /// **'You chose {specialty}. Click below to continue.'**
  String bot_chosen_specialty(Object specialty);

  /// No description provided for @button_view_doctors.
  ///
  /// In en, this message translates to:
  /// **'View Doctors'**
  String get button_view_doctors;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'hi'**
  String get hi;

  /// No description provided for @helloo.
  ///
  /// In en, this message translates to:
  /// **'hello'**
  String get helloo;

  /// No description provided for @howAreU.
  ///
  /// In en, this message translates to:
  /// **'how are you'**
  String get howAreU;

  /// No description provided for @iAmGood.
  ///
  /// In en, this message translates to:
  /// **'i am good'**
  String get iAmGood;

  /// No description provided for @doingGreat.
  ///
  /// In en, this message translates to:
  /// **'doing great'**
  String get doingGreat;

  /// No description provided for @fine.
  ///
  /// In en, this message translates to:
  /// **'fine'**
  String get fine;

  /// No description provided for @wantToBookAppoi.
  ///
  /// In en, this message translates to:
  /// **'i want to book an appointment'**
  String get wantToBookAppoi;

  /// No description provided for @wantToBook.
  ///
  /// In en, this message translates to:
  /// **'i want to book'**
  String get wantToBook;

  /// No description provided for @ourHospitalDescription.
  ///
  /// In en, this message translates to:
  /// **'Our hospital has been dedicated to providing high-quality, compassionate care since its founding in 2016. We are committed to improving the health of our community by offering a wide range of medical services and state-of-the-art facilities.'**
  String get ourHospitalDescription;

  /// No description provided for @ourVision.
  ///
  /// In en, this message translates to:
  /// **'Our Vision'**
  String get ourVision;

  /// No description provided for @visionText.
  ///
  /// In en, this message translates to:
  /// **'To be a leading healthcare provider'**
  String get visionText;

  /// No description provided for @ourMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get ourMission;

  /// No description provided for @missionText.
  ///
  /// In en, this message translates to:
  /// **'Delivering exceptional patient care'**
  String get missionText;

  /// No description provided for @ourValues.
  ///
  /// In en, this message translates to:
  /// **'Our Values'**
  String get ourValues;

  /// No description provided for @valuesText.
  ///
  /// In en, this message translates to:
  /// **'Compassion, quality, safety'**
  String get valuesText;

  /// No description provided for @supportSystem.
  ///
  /// In en, this message translates to:
  /// **'Support System'**
  String get supportSystem;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// No description provided for @trackTicketStatus.
  ///
  /// In en, this message translates to:
  /// **'Track Ticket Status'**
  String get trackTicketStatus;

  /// No description provided for @systemGuide.
  ///
  /// In en, this message translates to:
  /// **'System Guide'**
  String get systemGuide;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been successfully processed. Thank you!'**
  String get paymentSuccessMessage;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data updated successfully'**
  String get updateSuccess;

  /// No description provided for @noChanges.
  ///
  /// In en, this message translates to:
  /// **'No changes detected'**
  String get noChanges;

  /// No description provided for @updateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update data'**
  String get updateFailed;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading, please wait...'**
  String get loading;

  /// No description provided for @birthdate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthdate;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @medicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Medical History'**
  String get medicalHistory;

  /// No description provided for @medications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get medications;

  /// No description provided for @labResults.
  ///
  /// In en, this message translates to:
  /// **'Lab Results'**
  String get labResults;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis'**
  String get diagnosis;

  /// No description provided for @medication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get medication;

  /// No description provided for @dosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get dosage;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @editProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Picture'**
  String get editProfilePicture;

  /// No description provided for @removeImage.
  ///
  /// In en, this message translates to:
  /// **'Remove Image'**
  String get removeImage;

  /// No description provided for @pickFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from Gallery'**
  String get pickFromGallery;
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
