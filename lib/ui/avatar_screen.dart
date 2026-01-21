import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/avatar_screen_controller.dart';
import 'package:kidsflix_flutter/controller/my_account_controller.dart';
import 'package:kidsflix_flutter/controller/profile_controller.dart';
import 'package:kidsflix_flutter/models/avatar_response.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AvatarScreen extends StatefulWidget {

  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();

}

class _AvatarScreenState extends State<AvatarScreen> {

  AvatarScreenController controller = Get.find<AvatarScreenController>();
  MyAccountController controllerAccount = Get.find<MyAccountController>();
  ProfileController controllerProfile = Get.find<ProfileController>();

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
          Container(
            width: double.maxFinite,
            child: SafeArea(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(ImageConstants.applogo_cloud),
                ),
                GradientText(
                  "Select display Picture",
                  style: TextStyle(fontSize: 18, fontFamily: "moch"),
                  colors: const [
                    Color(0xff002274),
                    Color(0xff6F1CC3),
                    Color(0xff195AF6)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<AvatarResponse>(
                    future: controller.getAvatars(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var avatarList = snapshot.data?.avtars;

                        return Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                200.0, // Maximum width of each item
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemCount: avatarList!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          child: Card(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(75))),
                                            color: Colors.white,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                    ImageConstants.avatar_rings),
                                                Image.network(avatarList[index]
                                                    .avtarUrl
                                                    .toString())
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          controller.showLoader.value = true;
                                          ServerResponseModel model =
                                          await controller.setAvatar(
                                              avatarList[index].id.toString());
                                          controller.showLoader.value = false;

                                          if (model
                                              .responseDescription?.errorCode ==
                                              0) {
                                            controller.sp.setString(
                                                PrefsKeys.AVATAR,
                                                avatarList[index]
                                                    .avtarUrl
                                                    .toString());
                                            controllerAccount.avatarUrl.value =
                                                avatarList[index]
                                                    .avtarUrl
                                                    .toString();
                                            controllerProfile.avatarUrl.value =
                                                avatarList[index]
                                                    .avtarUrl
                                                    .toString();
                                            Get.back();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Something went wrong"),
                                              backgroundColor: Colors.red,
                                              elevation: 10,
                                              behavior: SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(5),
                                            ));
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                              padding: EdgeInsets.all(10.0),
                            ));
                      } else {
                        return buildLoader();
                      }
                    })
              ],
            )),
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
          }),
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
        ],
      ),
    );
  }

  buildLoader() {
    return Expanded(
        child: Shimmer.fromColors(
            period: const Duration(milliseconds: 500),
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0, // Maximum width of each item
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75))
                          ),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                );
              },
              padding: EdgeInsets.all(10.0),
            )));
  }
}
