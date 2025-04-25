import 'package:aljoud_hospital/l10n/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String translate(String key) {
    switch (key) {
      case 'morning': return morning;
      case 'evening': return evening;
      case 'night': return night;
      case 'sun': return sun;
      case 'mon': return mon;
      case 'tue': return tue;
      case 'wed': return wed;
      case 'thu': return thu;
      case 'fri': return fri;
      case 'sat': return sat;
      case 'jan': return jan;
      case 'feb': return feb;
      case 'mar': return mar;
      case 'apr': return apr;
      case 'may': return may;
      case 'jun': return jun;
      case 'jul': return jul;
      case 'aug': return aug;
      case 'sep': return sep;
      case 'oct': return oct;
      case 'nov': return nov;
      case 'dec': return dec;
      default: return key;
    }
  }
}
