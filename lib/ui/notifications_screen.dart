import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kidsflix_flutter/controller/notification_controller.dart';
import 'package:kidsflix_flutter/models/notification_response.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key});

  var controller = Get.find<NotificationController>();

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, left: 20),
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
                    SizedBox(
                      width: 20,
                    ),
                    GradientText(
                      "Notifications",
                      style: TextStyle(fontSize: 20, fontFamily: "moch"),
                      colors: const [
                        Color(0xff002274),
                        Color(0xff6F1CC3),
                        Color(0xff195AF6)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              FutureBuilder(
                  future: widget.controller.getNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return dataShimmer();
                    } else if (snapshot.hasData) {
                      if(snapshot.data!.notificationHistoryList == null){
                        return Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/lottie/box.json',
                                    width: double.maxFinite, height: 200,fit: BoxFit.contain),
                                SizedBox(height: 100,),
                                Text(" ",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: "moch",
                                        color: Colors.black))
                              ]),
                        );
                      }else{
                        return buildNotifications(snapshot.data!);
                      }

                    } else {
                      return Container();
                    }
                  })
            ],
          )
        ],
      ),
    );
  }

  Widget buildNotifications(NotificationResponse data) {
    return Expanded(
        child: ListView.builder(
            itemCount: data.notificationHistoryList!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: double.maxFinite,
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                        aspectRatio: 195 / 101,
                        child: Container(
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                data.notificationHistoryList![index].imageUrl
                                    .toString(),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data.notificationHistoryList![index]
                                  .notificationBody
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "moch",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "moch",
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Widget dataShimmer() {
    return Expanded(
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 500),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: 12,
            itemBuilder: (context, index) {
              return Container(
                width: double.maxFinite,
                height: 100,
                child: Card(),
              );
            }),
      ),
    );
  }
}
