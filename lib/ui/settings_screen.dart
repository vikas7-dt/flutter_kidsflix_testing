import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/settings_controller.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/ui/change_language_screen.dart';
import 'package:kidsflix_flutter/ui/video_quality_screen.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
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
          SafeArea(child: Column(
            children: [
              Container(
                margin: EdgeInsets.only( left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        child: Image.asset(
                          ImageConstants.back_white_img,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GradientText(
                      AppStrings.l10n.settings,
                      style: TextStyle(fontSize: 18, fontFamily: "moch"),
                      colors: const [
                        Color(0xff002274),
                        Color(0xff6F1CC3),
                        Color(0xff195AF6)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.notification,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Obx(() {
                          print("Received");
                          return controller.notiStatus.value == true
                              ? Image.asset(
                            ImageConstants.noti_on,
                            width: 60,
                          )
                              : Image.asset(
                            ImageConstants.noti_off,
                            width: 60,
                          );
                        }),
                        onTap: () async {
                          controller.showLoader.value = true;
                          ServerResponseModel result = await controller.setNoti(
                              controller.notiStatus.isTrue ? "1" : "0");
                          if (result.responseDescription?.errorCode == 0) {
                            controller.notiStatus.value =
                            !controller.notiStatus.value;
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar( SnackBar(
                              content: Text(AppStrings.l10n.something_went_wrong),
                              backgroundColor: Colors.red,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            ));
                          }
                          controller.showLoader.value = false;
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              InkWell(
                child: Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.video_quality,
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
                  Get.to(() => VideoQualityScreen());
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
                      SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.change_language,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset(ImageConstants.arrow_grad,
                          height: 30, width: 30),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(() => const ChangeLanguageScreen());
                },
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
