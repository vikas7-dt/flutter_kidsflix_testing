import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/banner_response.dart';
import 'package:kidsflix_flutter/models/game_content_info.dart';
import 'package:kidsflix_flutter/models/game_content_request.dart';
import 'package:kidsflix_flutter/models/home_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/models/home_data_request.dart';
import 'package:kidsflix_flutter/ui/game_play_screen.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/common_class.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_image.dart';

class GamesScreen extends StatefulWidget {
  String contentId;

  GamesScreen(this.contentId, {super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  String id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: const BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xff7CA9FF), Color(0xffffffff)])),
              child: SingleChildScrollView(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: getGameData(widget.contentId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return videoShimmer();
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 200,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    child: Card(
                                      child: AppImage(
                                        Constants.IMAGE_BASE_URL +
                                            data.portalSubContent!.imagepage!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: const Icon(Icons.cancel,
                                          size: 25, color: Colors.white),
                                    ),
                                    onTap: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(colors: [
                                          ColorUtil.BUTTON_GRAD_1,
                                          ColorUtil.BUTTON_GRAD_2
                                        ])),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Play Game',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "moch",
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            ImageConstants.game,
                                            height: 20,
                                          )
                                        ]),
                                  ),
                                  onTap: () {
                                    Get.to(() =>
                                        GamePlayScreen(widget.contentId));
                                  },
                                )),
                                GestureDetector(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 10, right: 10),
                                    child: Column(children: [
                                      SvgPicture.asset(
                                          ImageConstants.share_grad),
                                      GradientText(
                                        "Share",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: "moch",
                                            color: Colors.black),
                                        colors: [
                                          Color(0xff002274),
                                          Color(0xff6F1CC3),
                                          Color(0xff195AF6)
                                        ],
                                      )
                                    ]),
                                  ),
                                  onTap: () {
                                    CommonClass.shareApp();
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 10),
                              child: GradientText(
                                data.portalSubContent!.content!.titleDisplay
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "moch",
                                    color: Colors.black),
                                colors: const [
                                  Color(0xff002274),
                                  Color(0xff6F1CC3),
                                  Color(0xff195AF6)
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 10),
                              child: GradientText(
                                data.portalSubContent!.content!
                                    .titledescDisplay
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "moch",
                                  color: Colors.black,
                                ),
                                colors: const [
                                  Color(0xffF50075),
                                  Color(0xffA13A00),
                                  Color(0xff740000)
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text("No data available");
                      }
                    }),
                FutureBuilder<List<PublishMasters>>(
                  future: getHomeData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return dataShimmer();
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!;
                      return buildHomeData(posts);
                    } else {
                      return const Text("No data available");
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
              ),
            ),
    );
  }

  Widget buildHomeData(List<PublishMasters> list) {
    return ListView.builder(
      shrinkWrap: true,
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
                            setState(() {
                              widget.contentId = list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString();
                            });
                          } else {}
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
                                  GestureDetector(
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    onTap: () {},
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (list[index].portalContents![innerIndex].album ==
                              "Games") {
                            setState(() {
                              widget.contentId = list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString();
                            });
                          } else {}
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
                              setState(() {
                                widget.contentId = list[index]
                                    .portalContents![innerIndex]
                                    .id
                                    .toString();
                              });
                            } else {}
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
                            setState(() {
                              widget.contentId = list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString();
                            });
                          } else {}
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
                            setState(() {
                              widget.contentId = list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString();
                            });
                          } else {}
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
                            setState(() {
                              widget.contentId = list[index]
                                  .portalContents![innerIndex]
                                  .id
                                  .toString();
                            });
                          } else {}
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

  Future<List<PublishMasters>> getHomeData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    HomeDataRequest model = HomeDataRequest();

    model.portalId = sp.getString("portalId").toString();
    model.pageId = "1";
    model.pageName = "StreamingGames";
    model.scheme = "HomeContent";

    final response =
        await http.post(Uri.parse(Constants.BASE_URL + Constants.HOME_DATA),
            headers: <String, String>{
              "accessToken": sp.getString("token").toString(),
              "userId": sp.getString("userId").toString(),
              "source": "app",
              'Content-Type': "application/json",
            },
            body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      HomeDataModel result = HomeDataModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return result.publishMasters!.toList();
    } else {
      throw Exception("Failed to load ${response.statusCode}");
    }
  }

  String findUrl(String key, List<ContentImages> list, String imageUrl) {
    for (var item in list) {
      if (item.layoutName == key) {
        return item.contextPath.toString();
      }
    }
    return imageUrl;
  }

  Future<GameContentInfo> getGameData(String id) async {

    try {
      SharedPreferences sp = SharedPrefsService.prefs!;

      GameContentRequest model = GameContentRequest();

      model.portalId = sp.getString("portalId").toString();
      model.id = id;

      final response =
          await http.post(Uri.parse(Constants.BASE_URL + Constants.GAME_INFO),
              headers: <String, String>{
                "accessToken": sp.getString("token").toString(),
                "userId": sp.getString("userId").toString(),
                "source": "app",
                'Content-Type': "application/json",
              },
              body: jsonEncode(model.toJson()));

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        GameContentInfo result =
            GameContentInfo.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        id = result.portalSubContent!.id.toString();
        return result;
      } else {
        throw Exception("Failed to load ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to load ");
    }
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

  Widget videoShimmer() {
    return Container(
      width: double.maxFinite,
      height: 200,
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 500),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Card(),
      ),
    );
  }
}
