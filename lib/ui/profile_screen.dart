import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/profile_controller.dart';
import 'package:kidsflix_flutter/ui/link_portal_screen.dart';
import 'package:kidsflix_flutter/ui/my_account_screen.dart';
import 'package:kidsflix_flutter/ui/my_subs_screen.dart';
import 'package:kidsflix_flutter/ui/notifications_screen.dart';
import 'package:kidsflix_flutter/ui/privacy_policy_screen.dart';
import 'package:kidsflix_flutter/ui/register_screen.dart';
import 'package:kidsflix_flutter/ui/settings_screen.dart';
import 'package:kidsflix_flutter/util/app_image.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_strings.dart';

class ProfileScreen extends StatefulWidget {

  String? id;
  ProfileScreen({this.id, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    controller.getAccount();

    return Scaffold(
      body: Stack(
        children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff7CA9FF), Color(0xffffffff)])),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                height: 220,
                child: Image.asset(
                  "assets/images/rainbow_waterfall.png",
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(0.5),
                ),
              ),
            ),
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: 100,
                      child: Image.asset(ImageConstants.applogo_cloud),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      child: GestureDetector(
                        child: Lottie.asset('assets/lottie/noti_icon.json'),
                        onTap: () {
                          Get.to(() => NotificationsScreen());
                        },
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Obx(() {
                        print(controller.avatarUrl.value);
                        return Container(
                          height: 80,
                          width: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: AppImage(controller.avatarUrl.value),
                          ),
                        );
                      }),
                      SizedBox(width: 10),
                      GradientText(
                        AppStrings.l10n.my_account,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(ImageConstants.ic_edit,
                            height: 20, width: 20),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                onTap: () {
                  // Get.to(MyAccountScreen());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAccountScreen()));
                },
              ),

              InkWell(
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(ImageConstants.profile_sub,
                          height: 30, width: 30),
                      SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.my_subscription,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(ImageConstants.arrow_grad,
                          height: 30, width: 30),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(MySubsScreen());
                },
              ),
              Visibility(
                  visible: (!(SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) !=null && SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isNotEmpty)),
                  child: InkWell(
                    child: Container(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(ImageConstants.profile_link_portal,
                              height: 30, width: 30),
                          SizedBox(
                            width: 10,
                          ),
                          GradientText(
                            AppStrings.l10n.link_portal_subscription,
                            style: TextStyle(fontSize: 18, fontFamily: "moch"),
                            colors: const [
                              Color(0xff002274),
                              Color(0xff6F1CC3),
                              Color(0xff195AF6)
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset(ImageConstants.arrow_grad,
                              height: 30, width: 30),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(LinkPortalScreen());
                    },
                  ),
                ),
              InkWell(
                child: Container(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(ImageConstants.profile_settings,
                          height: 30, width: 30),
                      SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.settings,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(ImageConstants.arrow_grad,
                          height: 30, width: 30),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(SettingsScreen());
                },
              ),
              InkWell(
                child: Container(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(ImageConstants.profile_logout,
                          height: 30, width: 30),
                      SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.logout,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(ImageConstants.arrow_grad,
                          height: 30, width: 30),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(40),
                          width: double.maxFinite,
                          child: AspectRatio(
                            aspectRatio: 353 / 409,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image.asset(AppStrings.l10n.logout_account_pop),
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(
                                      bottom: 50, left: 30, right: 60),
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          child: Container(),
                                          onTap: () {
                                            Navigator.pop(dialogContext);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          child: Container(),
                                          onTap: () async {

                                            Navigator.pop(dialogContext);

                                            controller.showLoader.value = true;

                                            var result = await controller.logout();

                                            controller.showLoader.value = false;

                                            // if (result.responseDescription
                                            //         ?.errorCode ==
                                            //     0) {
                                              controller.sp.clear();
                                              Get.offAll(
                                                  () => RegisterScreen()
                                              );
                                            // }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  child: Text(
                    AppStrings.l10n.i_am_18_or_above_and_i_agree_to_terms_conditions,
                    style: TextStyle(fontSize: 14, fontFamily: "moch",color: ColorUtil.TEXT_BLUE),
                  ),
                  onTap: () {
                      Get.to(PrivacyPolicyScreen());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  child: GradientText(
                    SharedPrefsService.appVersion,
                    style: TextStyle(fontSize: 12, fontFamily: "moch"),
                    colors: const [
                      Color(0xff002274),
                      Color(0xff6F1CC3),
                      Color(0xff195AF6)
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ],
          )),
          Obx(() {
            return (controller.showLoader.isTrue)
                ? AbsorbPointer(
                    child: Container(
                      height: double.maxFinite,
                      color: const Color(0xff000000).withOpacity(0.3),
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
