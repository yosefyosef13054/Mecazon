import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const bool DEVELOPER_MODE = true;

const String BASE_URL = DEVELOPER_MODE
    ? "http://mecazonapi.infibrain.com/api/"
    : "http://mecazonapi.infibrain.com/api/";

const String TECDOC_BASE_URL = "https://webservice.tecalliance.services/pegasus-3-0/services/TecdocToCatDLB.jsonEndpoint";

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

DateFormat viewFormat = DateFormat("EEE. dd MMM, yyyy");
DateFormat viewFormatDate = DateFormat("dd");
DateFormat viewFormatYear = DateFormat("yyyy");
DateFormat viewFormatMonth = DateFormat("MMM");
DateFormat viewFormatFullMonth = DateFormat("MMMM");
DateFormat viewFormatDay = DateFormat("EEE");
DateFormat viewFormatTime = DateFormat("hh:mm a");
DateFormat apiFormat = DateFormat("dd/MM/yyyy");
DateFormat apiFormatDateTime = DateFormat("dd/MM/yyyy HH:mm");
DateFormat apiFormatTime = DateFormat("HH:mm");
DateFormat viewFormatDateTime = DateFormat("dd MMM, yyyy, hh:mm a");
DateFormat viewFormatMonthYearDateTime = DateFormat("MMM yyyy");
DateFormat apiResponseFormat = DateFormat("EEEE, MMMM dd, yyyy");

//=========ALL CONSTANTS VALUE FOR THE CODING===========

const String kUserModelKey = 'prefUserModel';
const String kSettingModelKey = 'prefSettingModel';
const String kPrefKeyMobileNo = 'prefMobileno';
const String kPrefKeyEmail = 'prefEmail';
const String kPrefKeyPassword = 'prefPassword';
const String kPrefKeyDarkMode = 'prefDarkMode';
const String kPrefKeyIsNotification = 'prefIsNotification';
const String kPrefKeyPairId = 'prefKeyPairId';
const String isLogin = 'isLogin';
const String isFirstTime = 'isFirstTime';

const String LAGUAGE_CODE = 'languageCode';

double appbarHeight = AppBar().preferredSize.height;
double screenHeight = Get.height;
double screenWidth = Get.width;

const double ASPECT_RATIO_16_9 = 16 / 9;
const double TOP_CURVE_MARGIN = 45.0;

const int USER_TYPE_1056_CUSTOMER = 1056;
const int USER_TYPE_1057_PROFESSIONAL = 1057;

const double MAIN_PADDING = 20.0;
const double CARD_PADDING = 20.0;
const double SMALL_PADDING_12 = 12.0;
const double SMALL_PADDING_15 = 15.0;
const double SMALL_PADDING = 8.0;

const double CARD_RADIUS_NORMAL = 8.0;
const double CARD_RADIUS_LARGE = 15.0;
const double CARD_CURVE_RADIUS = 30.0;

const String CMS_TYPE_ID_1099_ABOUT = "1099"; // About us - 1099
const String CMS_TYPE_ID_1100_CONTACT = "1100"; // Contact Us - 1100
const String CMS_TYPE_ID_1101_PRIVACY_POLICY = "1101"; // Privacy Policy -1101
const String CMS_TYPE_ID_1102_RATE_APP = "1102"; // Rate the app -1102

const String ONE_SIGNAL_KEY = "1a9a6031-348c-446b-ba04-3b8becfb8ec6";
const String GOOGLE_STORE_LINK = "https://play.google.com/store/apps/details?id=com.mecazon";
const String APPLE_STORE_LINK = "https://developer.apple.com";

const int LOGIN_TYPE_1 = 1; // LOGIN WITH EMAIL
const int LOGIN_TYPE_2 = 2; // LOGIN WITH MOBILE NO


String selectedLanguageCode = "en";
String acceptLangCode = "fr-FR";
String verificationId = "";
String bearerToken = "";
String pairId = "";

//API LIST
const String TOKEN = "${BASE_URL}authentication/token";
const String LOGIN = "${BASE_URL}account/signin";
const String DISCONNECT_USER = "${BASE_URL}account/disconnectUser";
const String SIGNUP = "${BASE_URL}account/signup";
const String SEND_OTP = "${BASE_URL}account/sendOTP";
const String COUNTRY_LIST = "${BASE_URL}account/countryList";
const String SETTINGS = "${BASE_URL}contentmanagement/commonsettings";

const String CMS_DATA = "${BASE_URL}contentmanagement/GetById?id=";
const String ENUM = "${BASE_URL}enum/list";
const String PROFILE_DETAILS = "${BASE_URL}frontuser/details";
const String UPDATE_PROFILE = "${BASE_URL}frontuser/updateprofile";
const String VERIFY = "${BASE_URL}frontuser/verify";
const String FORGOT_PASSWORD = "${BASE_URL}frontuser/forgotpassword";
const String FORGOT_PASSWORD_OTP_VERIFY =
    "${BASE_URL}frontuser/forgotpasswordotpverify";
const String CREATE_PASSWORD = "${BASE_URL}frontuser/createnewpassword";

const String BRAND_LIST = "${BASE_URL}brand/list";
const String MANUFACTURER_LIST = "${BASE_URL}Manufacturer/List";
const String ASSEMBLY_GROUP_LIST = "${BASE_URL}filter/assemblyGroup";

// const String CATEGORY_LIST = "${BASE_URL}category/list";
const String CATEGORY_LIST = "${BASE_URL}filter/categoryList";
const String SUBCATEGORY_LIST = "${BASE_URL}filter/subCategoryData";
const String MODEL_LIST = "${BASE_URL}home/modellist";
const String MODEL_TYPE_LIST = "${BASE_URL}home/modeltypelist";
const String HOME_PAGE_LIST = "${BASE_URL}home/homepagelist";
const String CAR_LIST = "${BASE_URL}home/carlist";
const String ADD_CAR = "${BASE_URL}home/addcar";
const String DELETE_CAR = "${BASE_URL}home/removecar";

/// : STORE
const String STORE_LIST = "${BASE_URL}storemanagement/StoreList?size=";
const String STORE_DETAILS = "${BASE_URL}storemanagement/StoreDetail?storeId=";
const String ADD_STORE = "${BASE_URL}storemanagement/addStore";
const String EDIT_STORE = "${BASE_URL}storemanagement/editStore";
const String VISIT_STORE = "${BASE_URL}storemanagement/StoreVisit?userId=";
const String DELETE_STORE_IMAGE = "${BASE_URL}storemanagement/storeImageDelete";
const String PROVINCE_LIST = "${BASE_URL}province/ProvinceList";
const String MUNICIPALITY_LIST = "${BASE_URL}municipality/MunicipalityList?provinceId=";

/// : WISHLIST STORE , PRODUCT
const String ADD_WISHLIST_STORE = "${BASE_URL}wishlist/wishlistStore/add";
const String ADD_WISHLIST_PRODUCT = "${BASE_URL}wishlist/wishlistProduct/add";
const String WISHLIST_STORE = "${BASE_URL}wishlist/wishlistStore/list?size=";
const String WISHLIST_PRODUCT = "${BASE_URL}wishlist/wishlistProduct/list?size=";

/// : PRODUCT REQUEST
const String ADD_REQUEST = "${BASE_URL}productRequest/add";
const String EDIT_REQUEST = "${BASE_URL}productRequest/update";
const String DELETE_REQUEST = "${BASE_URL}productRequest/Delete";
const String REQUEST_LIST = "${BASE_URL}productRequest/ProductRequestList?size=";
const String REQUEST_DETAILS = "${BASE_URL}productRequest/ProductDetails?requestID=";

/// : NOTIFICATION REQUEST
// const String NOTIFICATION_LIST = "${BASE_URL}notification/List?size=";
const String NOTIFICATION_LIST = "${BASE_URL}notification/List";

