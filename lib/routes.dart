import 'package:get/get.dart';
import 'package:mecazone/view/Brand/brand_controller.dart';
import 'package:mecazone/view/Brand/brand_list_screen.dart';
import 'package:mecazone/view/CMS/cms_controller.dart';
import 'package:mecazone/view/CMS/cms_screen.dart';
import 'package:mecazone/view/Category/category_controller.dart';
import 'package:mecazone/view/Category/category_screen.dart';
import 'package:mecazone/view/Category/subcategory_screen.dart';
import 'package:mecazone/view/Category/subcateory_controller.dart';
import 'package:mecazone/view/ForgotPassword/forgot_password_controller.dart';
import 'package:mecazone/view/ForgotPassword/forgot_password_screen.dart';
import 'package:mecazone/view/ForgotPassword/opt_verification_controller.dart';
import 'package:mecazone/view/ForgotPassword/opt_verification_screen.dart';
import 'package:mecazone/view/ForgotPassword/reset_password_controller.dart';
import 'package:mecazone/view/ForgotPassword/reset_password_screen.dart';
import 'package:mecazone/view/ForgotPassword/verification_controller.dart';
import 'package:mecazone/view/ForgotPassword/verification_screen.dart';
import 'package:mecazone/view/Home/home_controller.dart';
import 'package:mecazone/view/Home/home_screen.dart';
import 'package:mecazone/view/Language/language_controller.dart';
import 'package:mecazone/view/Language/language_screen.dart';
import 'package:mecazone/view/Login/login_controller.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:mecazone/view/Menu/menu_screen.dart';
import 'package:mecazone/view/Menu/menu_controller.dart';
import 'package:mecazone/view/Notification/notification_list_controller.dart';
import 'package:mecazone/view/Notification/notification_list_screen.dart';
import 'package:mecazone/view/Product/car_details_controller.dart';
import 'package:mecazone/view/Product/car_details_screen.dart';
import 'package:mecazone/view/Product/product_controller.dart';
import 'package:mecazone/view/Product/product_details_controller.dart';
import 'package:mecazone/view/Product/product_details_screen.dart';
import 'package:mecazone/view/Product/product_screen.dart';
import 'package:mecazone/view/Product/product_search_controller.dart';
import 'package:mecazone/view/Product/product_search_screen.dart';
import 'package:mecazone/view/Profile/edit_profile_controller.dart';
import 'package:mecazone/view/Profile/edit_profile_screen.dart';
import 'package:mecazone/view/Profile/profile_controller.dart';
import 'package:mecazone/view/Profile/profile_screen.dart';
import 'package:mecazone/view/Register/register_screen.dart';
import 'package:mecazone/view/Register/register_controller.dart';
import 'package:mecazone/view/Request/add_request_controller.dart';
import 'package:mecazone/view/Request/add_request_screen.dart';
import 'package:mecazone/view/Request/edit_request_controller.dart';
import 'package:mecazone/view/Request/edit_request_screen.dart';
import 'package:mecazone/view/Request/request_list_controller.dart';
import 'package:mecazone/view/Request/request_detail_controller.dart';
import 'package:mecazone/view/Request/request_details_screen.dart';
import 'package:mecazone/view/Request/request_list_screen.dart';
import 'package:mecazone/view/Store/add_store_screen.dart';
import 'package:mecazone/view/Store/add_store_controller.dart';
import 'package:mecazone/view/Store/edit_store_controller.dart';
import 'package:mecazone/view/Store/edit_store_screen.dart';
import 'package:mecazone/view/Store/store_controller.dart';
import 'package:mecazone/view/Store/store_details_screen.dart';
import 'package:mecazone/view/Store/store_list_screen.dart';
import 'package:mecazone/view/Subscription/subscription_list_controller.dart';
import 'package:mecazone/view/Subscription/subscription_list_screen.dart';
import 'package:mecazone/view/Wishlist/wishlist_controller.dart';
import 'package:mecazone/view/Wishlist/wishlist_screen.dart';
import 'package:mecazone/view/Store/store_details_controller.dart';

class Routes {
  static final pages = [
    GetPage(
        name: RegisterScreen.route,
        page: () => const RegisterScreen(),
        binding: RegisterBinding()),

    GetPage(
        name: LoginScreen.route,
        page: () => const LoginScreen(),
        binding: LoginBinding()),

    GetPage(
        name: ForgotPasswordScreen.route,
        page: () => const ForgotPasswordScreen(),
        binding: ForgotPasswordBinding()),

    GetPage(
        name: OTPVerificationScreen.route,
        page: () => const OTPVerificationScreen(),
        binding: OTPVerificationBinding()),

    GetPage(
        name: VerificationScreen.route,
        page: () => const VerificationScreen(),
        binding: VerificationBindings()),

    GetPage(
        name: ResetPasswordScreen.route,
        page: () => const ResetPasswordScreen(),
        binding: ResetPasswordBindings()),

    GetPage(
        name: ProfileScreen.route,
        page: () => const ProfileScreen(),
        binding: ProfileBindings()),

    GetPage(
        name: EditProfileScreen.route,
        page: () => const EditProfileScreen(),
        binding: EditProfileBindings()),

    GetPage(
        name: MenuScreen.route,
        page: () => const MenuScreen(),
        binding: MenusBindings()),

    GetPage(
        name: HomeScreen.route,
        page: () => const HomeScreen(),
        binding: HomeBindings()),

    GetPage(
        name: BrandListScreen.route,
        page: () => const BrandListScreen(),
        binding: BrandBindings()),

    GetPage(
        name: CategoryListScreen.route,
        page: () => const CategoryListScreen(),
        binding: CategoryBindings()),

    GetPage(
        name: SubCategoryListScreen.route,
        preventDuplicates: false,
        page: () => const SubCategoryListScreen(),
        binding: SubCategoryBindings()),

    GetPage(
        name: AddStoreScreen.route,
        page: () => const AddStoreScreen(),
        binding: AddStoreBindings()),

    GetPage(
        name: EditStoreScreen.route,
        page: () => const EditStoreScreen(),
        binding: EditStoreBindings()),

    GetPage(
        name: StoreListScreen.route,
        page: () => const StoreListScreen(),
        binding: StoreBindings()),

    GetPage(
        name: StoreDetailsScreen.route,
        page: () => const StoreDetailsScreen(),
        binding: StoreDetailsBindings()),

    GetPage(
        name: WishlistScreen.route,
        page: () => const WishlistScreen(),
        binding: WishListBindings()),

    GetPage(
        name: RequestListScreen.route,
        page: () => const RequestListScreen(),
        binding: RequestListBindings()),

    GetPage(
        name: LanguageScreen.route,
        page: () => const LanguageScreen(),
        binding: LanguageBinding()),

    GetPage(
        name: CMSScreen.route,
        page: () => const CMSScreen(),
        binding: CMSBindings()),

    GetPage(
        name: NotificationListScreen.route,
        page: () => const NotificationListScreen(),
        binding: NotificationListBindings()),

    GetPage(
        name: AddRequestScreen.route,
        page: () => const AddRequestScreen(),
        binding: AddRequestBinding()),

    GetPage(
        name: EditRequestScreen.route,
        page: () => const EditRequestScreen(),
        binding: EditRequestBinding()),

    GetPage(
        name: RequestDetailScreen.route,
        page: () => const RequestDetailScreen(),
        binding: RequestDetailBinding()),

    GetPage(
        name: CarDetailsScreen.route,
        page: () => const CarDetailsScreen(),
        binding: CarDetailsBindings()),

    GetPage(
        name: SubscriptionListScreen.route,
        page: () => const SubscriptionListScreen(),
        binding: SubscriptionListBindings()),

    GetPage(
        name: SubscriptionListScreen.route,
        page: () => const SubscriptionListScreen(),
        binding: SubscriptionListBindings()),

    GetPage(
        name: ProductScreen.route,
        page: () => const ProductScreen(),
        binding: ProductBindings()),

    GetPage(
        name: ProductSearchScreen.route,
        page: () => const ProductSearchScreen(),
        binding: ProductSearchBindings()),

    GetPage(
        name: ProductDetailsScreen.route,
        page: () => const ProductDetailsScreen(),
        binding: ProductDetailsBindings()),
  ];
}
