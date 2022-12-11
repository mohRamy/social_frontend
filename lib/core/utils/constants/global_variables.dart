
import '../app_strings.dart';

String uri = 'https://obscure-mesa-54807.herokuapp.com';

class GlobalVariables{

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': AppString.ASSETS_MOBILES,
    },
    {
      'title': 'Essentials',
      'image': AppString.ASSETS_ESSENTIALS,
    },
    {
      'title': 'Appliances',
      'image': AppString.ASSETS_APPLIANCES,
    },
    {
      'title': 'Books',
      'image': AppString.ASSETS_BOOKS,
    },
    {
      'title': 'Fashion',
      'image': AppString.ASSETS_FASHION,
    },
  ];
}