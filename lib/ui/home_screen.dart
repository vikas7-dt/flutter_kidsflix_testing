import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/home_screen_controller.dart';
import 'package:kidsflix_flutter/controller/in_app_purchase_util.dart';
import 'package:kidsflix_flutter/models/add_watchlist_response.dart';
import 'package:kidsflix_flutter/models/banner_response.dart';
import 'package:kidsflix_flutter/models/category_model.dart';
import 'package:kidsflix_flutter/models/continue_watch_reponse.dart';
import 'package:kidsflix_flutter/models/home_data_model.dart';
import 'package:kidsflix_flutter/ui/buy_subs_screen.dart';
import 'package:kidsflix_flutter/ui/games_screen.dart';
import 'package:kidsflix_flutter/ui/notifications_screen.dart';
import 'package:kidsflix_flutter/util/app_image.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/common_class.dart';
import 'package:kidsflix_flutter/util/common_getters.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../util/prefs_keys.dart';
import '../util/shared_prefs_service.dart';

class HomeScreen extends StatefulWidget {

  dynamic function;
  HomeScreen(this.function, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  final HomeScreenController _homeController = Get.find<HomeScreenController>();
  var subscriptionController = Get.find<InAppPurchaseUtils>();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    // widget.subscriptionController.syncIfSubscribed();
    // widget.subscriptionController.getAccount();

    widget.subscriptionController.checkIfSubscribed();

    return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: [Color(0xff7CA9FF), Color(0xffffffff)]
                    )
                ),
              ),
              SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60 ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 60,
                            width: 120,
                            alignment: AlignmentDirectional.centerStart,
                            child: Image.asset(ImageConstants.applogo_cloud),
                          ),
                          ((SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) == null || SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isEmpty)) ?
                             GestureDetector(
                              child: Container(
                                height: 60,
                                width: 120,
                                child: Image.asset(AppStrings.l10n.sub_now),
                              ),
                              onTap: (){
                                Get.to(BuySubsScreen());
                              },
                            )
                          :
                          Container(
                            height: 60,
                            width: 120,
                          ),
                          // Visibility(
                          //   visible: (SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) == null || SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isEmpty),
                          //   child: GestureDetector(
                          //     child: Container(
                          //       height: 60,
                          //       width: 120,
                          //       child: Image.asset(AppStrings.l10n.sub_now),
                          //     ),
                          //     onTap: (){
                          //       Get.to(BuySubsScreen());
                          //     },
                          //   ),
                          // ),
                          Container(
                            height: 60,
                            width: 120,
                            alignment: AlignmentDirectional.centerEnd,
                            child: GestureDetector(
                              child:
                              Lottie.asset('assets/lottie/noti_icon.json'),
                              onTap: () {
                                Get.to(() => NotificationsScreen());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder(
                        future: widget._homeController.getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return categoryShimmer();
                          } else if (snapshot.hasData) {
                            final posts = snapshot.data!;
                            return buildCategories(posts);
                          } else {
                            return const Text("No data available");
                          }
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() => FutureBuilder<List<PortalBanners>>(
                      future: widget._homeController.getBanners(
                          widget._homeController.categoryIndex.value),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return bannerShimmer();
                        } else if (snapshot.hasData) {
                          final posts = snapshot.data!;
                          return buildBanners(posts);
                        } else {
                          return const Text("No data available");
                        }
                      },
                    )),
                    FutureBuilder(
                        future: widget._homeController.getContinueWatch(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return watchShimmer();
                          } else if (snapshot.hasData) {
                            final posts = snapshot.data!;
                            if(posts.watchOngoingList == null){
                              return SizedBox.shrink();
                            }else{
                              return buildContinueWatch(posts);
                            }

                          } else {
                            return const Text("No data available");
                          }
                        }),
                    Obx(() => FutureBuilder<List<PublishMasters>>(
                      future: widget._homeController.getHomeData(
                          widget._homeController.categoryIndex.value),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return dataShimmer();
                        } else if (snapshot.hasData) {
                          final posts = snapshot.data!;
                          return buildHomeData(posts);
                        } else {
                          return const Text("No data available");
                        }
                      },
                    )),
                  ],
                ),
              ))
            ],
          ),
        ),
        onWillPop: () async {
          return true;
        });
  }

  Widget buildBanners(List<PortalBanners> posts) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          aspectRatio: 390 / 152,
          autoPlayInterval: Duration(seconds: 5),
        ),
        items: posts.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                child: Card(
                  semanticContainer: true,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white38),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: AppImage(Constants.IMAGE_BASE_URL +
                          findUrl("home_banner", i.contentImages!.toList(),
                              i.imagepage.toString())),
                    ),
                  ),
                ),
                onTap: () {
                  if (i.album == "Games") {
                    Get.to(GamesScreen(i.id.toString()));
                  } else {
                    widget.function(i.contentId.toString());
                  }
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget buildCategories(List<AppCategories> list) {
    return Container(
      height: 30,
      width: double.maxFinite,
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Obx(() => Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: widget._homeController.categoryIndex.value
                                    .toInt() !=
                                index
                            ? Colors.white
                            : Colors.red[800],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      list[index].categoryDisplayName.toString(),
                      style: TextStyle(
                          fontFamily: "moch",
                          fontSize: 12,
                          color: widget._homeController.categoryIndex.value
                                      .toInt() ==
                                  index
                              ? Colors.white
                              : Colors.black),
                    ),
                  )),
              onTap: () {
                widget._homeController.categoryIndex.value = index;
              },
            );
          }),
    );
  }

  Widget buildHomeData(List<PublishMasters> list) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: GradientText(
                list[index].titleDisplay.toString(),
                style: const TextStyle(
                    fontSize: 16, fontFamily: "moch", color: Colors.black),
                colors: const [
                  Color(0xff002274),
                  Color(0xff6F1CC3),
                  Color(0xff195AF6)
                ],
              ),
            ),
            Builder(builder: (context) {
              if (list[index].layoutName == "games_slider") {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            elevation: 4,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: AppImage(Constants.IMAGE_BASE_URL +
                                    findUrl(
                                        "games_slider",
                                        list[index]
                                            .portalContents![innerIndex]
                                            .contentImages!
                                            .toList(),
                                        list[index]
                                            .portalContents![innerIndex]
                                            .imagepage
                                            .toString())),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(() => GamesScreen(list[index]
                              .portalContents![innerIndex]
                              .id
                              .toString()));
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "v_rect_3") {
                return Container(
                  height: 230,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 244 / 332,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: AppImage(Constants.IMAGE_BASE_URL +
                                  findUrl(
                                      "v_rect_3",
                                      list[index]
                                          .portalContents![innerIndex]
                                          .contentImages!
                                          .toList(),
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "h_rect_2") {
                return Container(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          color: Colors.white,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 195 / 101,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  AppImage(Constants.IMAGE_BASE_URL +
                                      findUrl(
                                          "h_rect_2",
                                          list[index]
                                              .portalContents![innerIndex]
                                              .contentImages!
                                              .toList(),
                                          list[index]
                                              .portalContents![innerIndex]
                                              .imagepage
                                              .toString())),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      onTap: () {
                                        showBottomSheet(
                                            list[index]
                                                .portalContents![innerIndex]
                                                .infoDisplay
                                                .toString(),
                                            list[index]
                                                .portalContents![innerIndex]
                                                .contentId
                                                .toString());
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "circle_4") {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(5),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: AppImage(Constants.IMAGE_BASE_URL +
                                    findUrl(
                                        "circle_4",
                                        list[index]
                                            .portalContents![innerIndex]
                                            .contentImages!
                                            .toList(),
                                        list[index]
                                            .portalContents![innerIndex]
                                            .imagepage
                                            .toString())),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (list[index].portalContents![innerIndex].album ==
                                "Games") {
                              Get.to(GamesScreen(list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString()));
                            } else {
                              widget.function(list[index]
                                  .portalContents![innerIndex]
                                  .contentId
                                  .toString());
                            }
                          });
                    },
                  ),
                );
              } else if (list[index].layoutName == "square_3") {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: AppImage(Constants.IMAGE_BASE_URL +
                                  findUrl(
                                      "square_3",
                                      list[index]
                                          .portalContents![innerIndex]
                                          .contentImages!
                                          .toList(),
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          print(list[index].portalContents![innerIndex].album);
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else if (list[index].layoutName == "body_banner") {
                return Container(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 350 / 152,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: AppImage(Constants.IMAGE_BASE_URL +
                                  findUrl(
                                      "body_banner",
                                      list[index]
                                          .portalContents![innerIndex]
                                          .contentImages!
                                          .toList(),
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  height: 230,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: list[index].portalContents!.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(5),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 244 / 332,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: AppImage(Constants.IMAGE_BASE_URL +
                                  CommonClass.findCorrectImageUrl(
                                      "v_rect_3",
                                      (list[index]
                                          .portalContents![innerIndex]
                                          .contentImages ==
                                          null)
                                          ? []
                                          : list[index]
                                          .portalContents![innerIndex]
                                          .contentImages!
                                          .toList(),
                                      list[index]
                                          .portalContents![innerIndex]
                                          .imagepage
                                          .toString())),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            Get.to(GamesScreen(list[index]
                                .portalContents![innerIndex]
                                .id
                                .toString()));
                          } else {
                            widget.function(list[index]
                                .portalContents![innerIndex]
                                .contentId
                                .toString());
                          }
                        },
                      );
                    },
                  ),
                );
              }
            })
          ],
        );
      },
    );
  }

  String findUrl(String key, List<ContentImages> list, String imageUrl) {
    for (var item in list) {
      if (item.layoutName == key) {
        return item.contextPath.toString();
      }
    }
    return imageUrl;
  }

  String findUrlContinue(String key, List<ContentImagess> list, String imageUrl) {
    for (var item in list) {
      if (item.layoutName == key) {
        return item.contextPath.toString();
      }
    }
    return imageUrl;
  }

  Widget categoryShimmer() {
    return Container(
      height: 40,
      width: double.maxFinite,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          period: Duration(milliseconds: 500),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, position) {
                return Container(
                  height: 40,
                  width: 100,
                  child: const Card(
                    child: SizedBox(
                      height: 40,
                      width: 100,
                    ),
                  ),
                );
              })),
    );
  }

  Widget watchShimmer() {
    return Container(
      height: 170,
      width: double.maxFinite,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          period: Duration(milliseconds: 500),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, position) {
                return Container(
                  height: 170,
                  width: 220,
                  child: const Card(
                    child: SizedBox(
                      height: 170,
                      width: 220,
                    ),
                  ),
                );
              })),
    );
  }

  Widget bannerShimmer() {
    return AspectRatio(
      aspectRatio: 390 / 152,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: Duration(milliseconds: 500),
        child: Card(
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }

  Widget dataShimmer() {
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 500),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const AspectRatio(
                            aspectRatio: 244 / 332,
                            child: Card(),
                          );
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }

  showBottomSheet(String title, String contentId) {
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
                              SvgPicture.asset(ImageConstants.watchlist_grad,
                                  width: 40, height: 40),
                              SizedBox(height: 10),
                              GradientText(
                                AppStrings.l10n.watchlist,
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
                          onTap: () async {
                            // FutureBuilder(
                            //   future: widget._homeController.addWatchList(contentId),
                            //   builder: (context,snapshot) {
                            //       if(snapshot.hasData){
                            //           if(snapshot.data!.responseDescription?.errorCode==0){
                            //               return
                            //           }
                            //       }
                            //   },
                            // );
                            Navigator.pop(context);

                            AddWatchListResponse response = await widget
                                ._homeController
                                .addWatchList(contentId);

                            if (response.responseDescription?.errorCode == 0 ||
                                response.responseDescription?.errorCode ==
                                    1200) {
                              showSnackBar(AppStrings.l10n.added_to_watchlist);
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

  Widget buildContinueWatch(ContinueWatchResponse posts) {

    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10,top: 10,bottom: 5),
            child: GradientText(
              AppStrings.l10n.continue_watching,
              style: const TextStyle(
                  fontSize: 16, fontFamily: "moch", color: Colors.black),
              colors: const [
                Color(0xff002274),
                Color(0xff6F1CC3),
                Color(0xff195AF6)
              ],
            ),
          ),
          Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: posts.watchOngoingList!.length,
              itemBuilder: (BuildContext context, int innerIndex) {
                return GestureDetector(
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(5),
                    color: Colors.white,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 195 / 101,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Expanded(
                                child: AppImage(Constants.IMAGE_BASE_URL +
                                    findUrlContinue(
                                        "h_rect_2",
                                        posts.watchOngoingList![innerIndex]
                                            .contentImages!
                                            .toList(),
                                        posts.watchOngoingList![innerIndex]
                                            .contentImageUrl
                                            .toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  onTap: () {
                                    showBottomSheet(
                                        posts.watchOngoingList![innerIndex]
                                            .contentName
                                            .toString(),
                                        posts.watchOngoingList![innerIndex]
                                            .contentId
                                            .toString());
                                  },
                                ),
                              ),
                              Container(
                                height: 200,
                                child: AspectRatio(
                                  aspectRatio: 195 / 101,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                    child: SizedBox(
                                      height: 5,

                                      child: LinearProgressIndicator(

                                        backgroundColor: Colors.red[60],
                                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                                        value: posts.watchOngoingList![innerIndex].durationElapsed!/posts.watchOngoingList![innerIndex].totalDuration!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
      
                      widget.function(posts.watchOngoingList![innerIndex]
                          .contentId
                          .toString());
      
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
