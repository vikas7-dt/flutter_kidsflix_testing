import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/watchlist_controller.dart';
import 'package:kidsflix_flutter/models/watchlist_response.dart';
import 'package:kidsflix_flutter/util/app_image.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/common_class.dart';
import 'package:kidsflix_flutter/util/common_getters.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_strings.dart';

class WishListScreen extends StatefulWidget {

  dynamic function;

  WishListScreen(this.function,{super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();

  WatchlistController controller = Get.find<WatchlistController>();

}

class _WishListScreenState extends State<WishListScreen> {

  @override
  Widget build(BuildContext context) {

    widget.controller.getWatchList();

    return Container(
        decoration: BoxDecoration(gradient: bgLinearGradient),
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  GradientText(
                    AppStrings.l10n.watchlist,
                    style: const TextStyle(
                        fontSize: 16, fontFamily: "moch", color: Colors.black),
                    colors: const [
                      Color(0xff002274),
                      Color(0xff6F1CC3),
                      Color(0xff195AF6)
                    ],
                  ),
                  const SizedBox(height: 30, width: 10),
                  Lottie.asset("assets/lottie/star.json", width: 40, height: 40)
                ],
              ),
            ),
            FutureBuilder(
                future: widget.controller.getWatchList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return dataShimmer();
                  } else if (snapshot.hasData) {
                    return buildWatchList();
                  } else {
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
                  }
                })
          ],
        )));
  }

  Widget buildWatchList() {
    return Obx(() {
      return Expanded(
          child: ListView.builder(
              itemCount: widget.controller.list.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    width: double.maxFinite,
                    height: 90,
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
                                  child: AppImage(
                                    Constants.IMAGE_BASE_URL +
                                        findUrl(
                                            "h_rect_2",
                                            widget.controller.list[index]
                                                .contentImages!
                                                .toList(),
                                            widget.controller.list[index]
                                                .contentImageUrl
                                                .toString()),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.controller.list[index].contentNameDisplay
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: "moch",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.controller.list[index].contentCategory
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: "moch",
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          onTap: () {
                            showBottomSheet(
                                widget.controller.list[index].contentNameDisplay
                                    .toString(),
                                widget.controller.list[index].id.toString(),
                                index);
                          },
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    widget.function(widget.controller.list[index].contentId
                        .toString());
                  },
                );
              }));
    });
  }

  String findUrl(String key, List<ContentImages> list, String imageUrl) {
    for (var item in list) {
      if (item.layoutName == key) {
        return item.contextPath.toString();
      }
    }
    return imageUrl;
  }

  Widget dataShimmer() {
    return Expanded(
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 500),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
            shrinkWrap: true,
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

  showBottomSheet(String title, String contentId, int index) {
    showModalBottomSheet<void>(

        // context and builder are
        // required properties in this widget

        context: context,
        builder: (BuildContext context) {
          // we set up a container inside which
          // we create center column and display text
          // Returning SizedBox instead of a Container

          return Container(
            height: 200,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(gradient: bgLinearGradient),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GradientText(
                        title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 17,
                            fontFamily: "moch",
                            color: Colors.black),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageConstants.remove_watchlist,
                                  width: 40, height: 40),
                              SizedBox(height: 10),
                              GradientText(
                                AppStrings.l10n.remove_from_wishlist,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "moch",
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                                colors: const [
                                  Color(0xff002274),
                                  Color(0xff6F1CC3),
                                  Color(0xff195AF6)
                                ],
                              )
                            ],
                          ),
                          onTap: () async {
                            Navigator.pop(context);

                            WatchListResponse response = await widget.controller
                                .removeWatchList(contentId);

                            if (response.responseDescription!.errorCode == 0 ||
                                response.responseDescription!.errorCode ==
                                    1200) {
                              widget.controller.list.removeAt(index);

                              showSnackBar(
                                  AppStrings.l10n.remove_from_wishlist);
                            }
                          },
                        ),
                        GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageConstants.share_grad,
                                  width: 40, height: 40),
                              SizedBox(height: 10),
                              GradientText(
                                AppStrings.l10n.share,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "moch",
                                    color: Colors.black),
                                colors: const [
                                  Color(0xff002274),
                                  Color(0xff6F1CC3),
                                  Color(0xff195AF6)
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            CommonClass.shareApp();
                          },
                        )
                      ],
                    ))
                  ],
                )
              ],
            ),
          );
        });
  }

  showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: const TextStyle(
            color: ColorUtil.TEXT_BLUE, fontFamily: "moch", fontSize: 14),
      ),
      backgroundColor: Colors.white,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    ));
  }
}
