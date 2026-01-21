import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kidsflix_flutter/controller/video_quality_controller.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_strings.dart';

class VideoQualityScreen extends StatefulWidget {
  const VideoQualityScreen({super.key});

  @override
  State<VideoQualityScreen> createState() => _VideoQualityScreenState();
}

class _VideoQualityScreenState extends State<VideoQualityScreen> {
  VideoQualityController controller = Get.find<VideoQualityController>();

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
                      AppStrings.l10n.video_quality,
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
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return RadioListTile(
                    title: GradientText(
                      "SD",
                      style: TextStyle(fontSize: 18, fontFamily: "moch"),
                      colors: const [
                        Color(0xff002274),
                        Color(0xff6F1CC3),
                        Color(0xff195AF6)
                      ],
                    ),
                    value: 1,
                    groupValue: controller.groupValue.value,
                    onChanged: (value) async {
                      ServerResponseModel result =
                      await controller.setVideoQuality("SD");

                      if (result.responseDescription?.errorCode == 0) {
                        controller.groupValue.value = value as int;
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
                    });
              }),
              Obx(() {
                return RadioListTile(
                    title: GradientText(
                      "HD",
                      style: TextStyle(fontSize: 18, fontFamily: "moch"),
                      colors: const [
                        Color(0xff002274),
                        Color(0xff6F1CC3),
                        Color(0xff195AF6)
                      ],
                    ),
                    value: 2,
                    groupValue: controller.groupValue.value,
                    onChanged: (value) async {
                      ServerResponseModel result =
                      await controller.setVideoQuality("HD");

                      if (result.responseDescription?.errorCode == 0) {
                        controller.groupValue.value = value as int;
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
                    });
              })
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
