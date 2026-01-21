import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kidsflix_flutter/controller/my_account_controller.dart';
import 'package:kidsflix_flutter/ui/avatar_screen.dart';
import 'package:kidsflix_flutter/ui/notifications_screen.dart';
import 'package:kidsflix_flutter/ui/register_screen.dart';
import 'package:kidsflix_flutter/util/app_image.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_strings.dart';

class MyAccountScreen extends StatefulWidget {

  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();

}

class _MyAccountScreenState extends State<MyAccountScreen> {

  MyAccountController controller = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    controller.onStartScreen();
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
            child:
            Column(
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(left: 10),
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
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Obx(() {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75)),
                        child: AppImage(controller.avatarUrl.value),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          AppStrings.l10n.edit_profile_picture,
                          style: TextStyle(fontSize: 18, fontFamily: "moch"),
                          colors: const [
                            Color(0xff002274),
                            Color(0xff6F1CC3),
                            Color(0xff195AF6)
                          ],
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(ImageConstants.ic_edit,
                              height: 20, width: 20),
                        )
                      ],
                    ),
                    onTap: () {
                      Get.to(() => AvatarScreen());
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            GradientText(
                              AppStrings.l10n.mobile_number,
                              style:
                              TextStyle(fontSize: 18, fontFamily: "moch"),
                              colors: const [
                                Color(0xff002274),
                                Color(0xff6F1CC3),
                                Color(0xff195AF6)
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return GradientText(
                                controller.mobile.value,
                                style:
                                TextStyle(fontSize: 18, fontFamily: "moch"),
                                colors: const [
                                  Color(0xffF50075),
                                  Color(0xffA13A00),
                                  Color(0xff740000)
                                ],
                              );
                            }),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GradientText(
                              AppStrings.l10n.email_id,
                              style:
                              TextStyle(fontSize: 18, fontFamily: "moch"),
                              colors: const [
                                Color(0xff002274),
                                Color(0xff6F1CC3),
                                Color(0xff195AF6)
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return GradientText(
                                controller.email.value,
                                style:
                                TextStyle(fontSize: 18, fontFamily: "moch"),
                                colors: const [
                                  Color(0xffF50075),
                                  Color(0xffA13A00),
                                  Color(0xff740000)
                                ],
                              );
                            }),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Container(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ImageConstants.delete,
                                        height: 30, width: 30),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GradientText(
                                      AppStrings.l10n.delete_account,
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: "moch"),
                                      colors: const [
                                        Color(0xff002274),
                                        Color(0xff6F1CC3),
                                        Color(0xff195AF6)
                                      ],
                                    ),
                                    Spacer(),
                                    SvgPicture.asset(ImageConstants.arrow_grad,
                                        height: 30, width: 30),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30),
                                        width: double.maxFinite,
                                        child: AspectRatio(
                                          aspectRatio: 707 / 820,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Image.asset(AppStrings.l10n.delete_account_pop),
                                              Container(
                                                width: double.maxFinite,
                                                margin: EdgeInsets.only(
                                                    bottom: 20,
                                                    left: 30,
                                                    right: 60),
                                                height: 50,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                        behavior:
                                                        HitTestBehavior
                                                            .translucent,
                                                        child: Container(),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              dialogContext);
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                        behavior:
                                                        HitTestBehavior
                                                            .translucent,
                                                        child: Container(),
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              dialogContext);

                                                          controller.showLoader
                                                              .value = true;

                                                          var result =
                                                          await controller
                                                              .deleteAccount();

                                                          controller.showLoader
                                                              .value = false;

                                                          if (result
                                                              .responseDescription
                                                              ?.errorCode ==
                                                              0) {
                                                            controller.sp
                                                                .clear();

                                                            Get.offAll(() =>
                                                                RegisterScreen());
                                                          }
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
                            )
                          ],
                        )),
                  )
                ],
              )
            ],
          ),),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 140, left: 20),
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
