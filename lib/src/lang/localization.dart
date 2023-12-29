// import 'package:i18n_extension/i18n_extension.dart';

// const loginHello = 'loginHello';
// const loginDis = 'loginDis';
// const loginAccount = 'loginAccount';

// extension Localization on String {
//   static final _t = Translations.from("en_us", {
//     loginHello: {
//       "en_us": "Hello",
//       "ar_sa": "مرحبا",
//     },
//     loginDis: {
//       "en_us": "An application that contains everything you desire",
//       "ar_sa": "مطعم متكامل يحتوي على جميع الأكلات الشرقية والغربية",
//     },
//     loginAccount: {
//       "en_us": "Sign into your account",
//       "ar_sa": "سجل الدخول عبر حسابك",
//     }
//   });

//   String get i18n => localize(this, _t);

//   String fill(List<Object> params) => localizeFill(this, params);

//   String plural(int value) => localizePlural(value, this, _t);

//   String version(Object modifier) => localizeVersion(modifier, this, _t);
// }

import 'package:get/get.dart';

class Messages extends Translations{
  final Map<String, Map<String, String>> languages;
  Messages({required this.languages});

  @override
  Map<String , Map<String, String>> get keys {
    return languages;
  }
}
