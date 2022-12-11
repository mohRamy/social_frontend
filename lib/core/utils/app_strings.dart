class AppString {
  //app
  static const String APP_NAME = 'RAMY APP';
  static const int APP_V = 1;

  //api
  static const String BASE_URL = "http://192.168.225.79:8000";
  static const String SIGN_UP_URL = "$BASE_URL/api/signup";
  static const String SIGN_IN_URL = "$BASE_URL/api/signin";
  static const String TOKEN_IS_VALID_URL = "$BASE_URL/tokenIsValid";

  //token
  static const String TOKEN = 'x-auth-token';


  
  //assets
  static const String IMG_PATH = 'assets/images';
  static const String ASSETS_MOBILES = '$IMG_PATH/mobiles.png';
  static const String ASSETS_ESSENTIALS = '$IMG_PATH/essentials.jpg';
  static const String ASSETS_APPLIANCES = '$IMG_PATH/appliances.jpg';
  static const String ASSETS_BOOKS = '$IMG_PATH/books.jpg';
  static const String ASSETS_FASHION = '$IMG_PATH/fashion.webp';
  static const String ASSETS_EMPTY = '$IMG_PATH/empty-box.png';
  static const String ASSETS_FOOD = '$IMG_PATH/food.png';

  //get argument
  static const String ARGUMENT_PRODUCT = 'product';
  static const String ARGUMENT_RATINGS = 'ratings';

  //sign
  static const String SIGN_IN = 'Sign In';
  static const String SIGN_UP = 'Sign UP';
  static const String SIGN_OUT = 'Sign Out';

  //keys sharedPreference
  static const String CART_KEY = 'cashe-cart';
  static const String CART_HISTORY_KEY = 'cashe-cart-history';
  static const String TOKEN_KEY = 'token-key';
  static const String TYPE_KEY = 'type-key';
}
