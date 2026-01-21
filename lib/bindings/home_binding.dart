import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/avatar_screen_controller.dart';
import 'package:kidsflix_flutter/controller/game_play_controller.dart';
import 'package:kidsflix_flutter/controller/home_parent_controller.dart';
import 'package:kidsflix_flutter/controller/home_screen_controller.dart';
import 'package:kidsflix_flutter/controller/in_app_purchase_util.dart';
import 'package:kidsflix_flutter/controller/language_controller.dart';
import 'package:kidsflix_flutter/controller/link_portal_controller.dart';
import 'package:kidsflix_flutter/controller/locale_controller.dart';
import 'package:kidsflix_flutter/controller/my_account_controller.dart';
import 'package:kidsflix_flutter/controller/notification_controller.dart';
import 'package:kidsflix_flutter/controller/profile_controller.dart';
import 'package:kidsflix_flutter/controller/settings_controller.dart';
import 'package:kidsflix_flutter/controller/video_quality_controller.dart';
import 'package:kidsflix_flutter/controller/watchlist_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => HomeScreenController());
    // Get.lazyPut(() => WatchlistController());
    // Get.lazyPut(() => ProfileController());
    // Get.lazyPut(() => MyAccountController());
    // Get.lazyPut(() => LinkPortalController());
    // Get.lazyPut(() => AvatarScreenController());
    // Get.lazyPut(() => SettingsController());

    Get.lazyPut(() => HomeScreenController(), fenix: true);
    Get.lazyPut(() => WatchlistController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MyAccountController(), fenix: true);
    Get.lazyPut(() => LinkPortalController(), fenix: true);
    Get.lazyPut(() => AvatarScreenController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => VideoQualityController(), fenix: true);
    Get.lazyPut(() => GamePlayController(), fenix: true);
    Get.lazyPut(() => HomeParentController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => LanguageController(), fenix: true);
    Get.lazyPut(() => InAppPurchaseUtils(), fenix: true);

    // Get.put(HomeScreenController(), permanent: false);
    // Get.put(WatchlistController(), permanent: false);
    // Get.put(ProfileController(), permanent: false);
    // Get.put(MyAccountController(), permanent: false);
    // Get.put(LinkPortalController(), permanent: false);
    // Get.put(AvatarScreenController(), permanent: false);
    // Get.put(SettingsController(), permanent: false);
  }
}
