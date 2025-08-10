import 'package:flutter/cupertino.dart';

class CountryService {
  static final countryNamesMap = {
    "de": 'Germany',
    'pl': 'Poland',
    'it': 'Italy',
    'es': 'Spain',
    'cn': 'China',
    'tw': 'Taiwan',
    'tr': 'Turkey',
    'eu': 'European Union',
    'iq': 'Iraq',
    'se': 'Sweden',
    'gb': 'United Kingdom',
    'us': 'United States',
    'bg': 'Bulgaria',
    'at': 'Austria',
    'ba': 'Bosnia',
    'id': 'Indonesia',
    'br': 'Brazil',
    'in': 'India',
    'eg': 'Egypt',
    'ae': 'UAE',
    'fr': 'France',
    'ro': 'Romania',
    'kr': 'South Korea',
    'th': 'Thailand',
    'jp': 'Japan',
  };

  static final Map<String, String> countryNamesKurdish = {
    'de': 'ئەڵمانیا',
    'pl': 'پۆڵەندا',
    'it': 'ئیتالیا',
    'es': 'ئیسپانیا',
    'cn': 'چین',
    'tw': 'تایوان',
    'tr': 'تورکیا',
    'eu': 'یەکێتیی ئەورووپا',
    'iq': 'عێراق',
    'se': 'سوید',
    'gb': 'بریتانیا',
    'us': 'ئەمریکا',
    'bg': 'بولگاریا',
    'at': 'نەمسا',
    'ba': 'بۆسنیا',
    'id': 'ئیندۆنیزیا',
    'br': 'بەڕازیل',
    'in': 'ھیندستان',
    'eg': 'میسر',
    'ae': 'ئیمارا',
    'fr': 'فەڕەنسا',
    'ro': 'ڕۆمانیا',
    'kr': 'کۆریای باشوور',
    'th': 'تایلەند',
    'jp': 'ژاپۆن',
  };

  static final Map<String, String> countryNamesArabic = {
    'de': 'ألمانيا', // Germany
    'pl': 'بولندا', // Poland
    'it': 'إيطاليا', // Italy
    'es': 'إسبانيا', // Spain
    'cn': 'الصين', // China
    'tw': 'تايوان', // Taiwan
    'tr': 'تركيا', // Turkey
    'eu': 'الاتحاد الأوروبي', // European Union
    'iq': 'العراق', // Iraq
    'se': 'السويد', // Sweden
    'gb': 'المملكة المتحدة', // United Kingdom
    'us': 'الولايات المتحدة', // United States
    'bg': 'بلغاريا', // Bulgaria
    'at': 'النمسا', // Austria
    'ba': 'البوسنة', // Bosnia
    'id': 'إندونيسيا', // Indonesia
    'br': 'البرازيل', // Brazil
    'in': 'الهند', // India
    'eg': 'مصر', // Egypt
    'ae': 'الإمارات', // UAE
    'fr': 'فرنسا', // France
    'ro': 'رومانيا', // Romania
    'kr': 'كوريا الجنوبية', // South Korea
    'th': 'تايلاند', // Thailand
    'jp': 'اليابان', // Japan
  };

  static getCountryName(BuildContext context, String name) {
    String lang = 'en';//AppLocalizations.of(context).locale.languageCode;
    if (lang == 'ar') {
      return countryNamesArabic[name];
    } else if (lang == 'ku') {
      return countryNamesKurdish[name];
    }
    return countryNamesMap[name];
  }
}
