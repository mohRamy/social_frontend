class AppString {
  //app
  static const String APP_NAME = 'RAMY APP';
  static const int APP_V = 1;

  //api
  static const String BASE_URL = "http://192.168.127.79:8000";
  static const String SIGN_UP_URL = "$BASE_URL/api/signup";
  static const String SIGN_IN_URL = "$BASE_URL/api/signin";
  static const String TOKEN_IS_VALID_URL = "$BASE_URL/tokenIsValid";
  static const String USER_BY_ID_URL = "$BASE_URL/user-by-id";
  static const String POST_ADD_URL = "$BASE_URL/post/add-post";
  static const String POST_UPDATE_URL = "$BASE_URL/post/update-post";
  static const String POST_DELETE_URL = "$BASE_URL/post/delete-post";
  static const String POST_GET_URL = "$BASE_URL/post/";
  static const String PROFILE_FOLLOW_URL = "$BASE_URL/api/user/follow";
  static const String MYPOST_GET_URL = "$BASE_URL/api/user/get-mypost";
  static const String PROFILE_BGIMAGE_URL = "$BASE_URL/api/user/modify-bgimage";
  static const String PROFILE_IMAGE_URL = "$BASE_URL/api/user/modify-image";






  //token
  static const String TOKEN_KEY = 'x-auth-token';


  
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
  static const String TOKEN = '';
  static const String TYPE_KEY = 'type-key';
}
