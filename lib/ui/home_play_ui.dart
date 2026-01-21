import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/controller/home_parent_controller.dart';
import 'package:kidsflix_flutter/controller/home_screen_controller.dart';
import 'package:kidsflix_flutter/models/add_watchlist_response.dart';
import 'package:kidsflix_flutter/models/banner_response.dart';
import 'package:kidsflix_flutter/models/home_data_model.dart';
import 'package:kidsflix_flutter/models/home_data_request.dart';
import 'package:kidsflix_flutter/models/stream_request.dart';
import 'package:kidsflix_flutter/models/stream_response.dart';
import 'package:kidsflix_flutter/ui/games_screen.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/common_class.dart';
import 'package:kidsflix_flutter/util/common_getters.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

import '../util/prefs_keys.dart';
import '../util/shared_prefs_service.dart';

class HomePlayUi extends StatefulWidget {

  var contentId = "";
  void Function() callbackPlayUi;
  var myController = Get.find<HomeParentController>();
  final HomeScreenController _homeController = Get.find<HomeScreenController>();

  HomePlayUi(this.contentId, this.callbackPlayUi, {super.key});



  @override
  State<HomePlayUi> createState() => _HomePlayUiState();

}

class _HomePlayUiState extends State<HomePlayUi> with SingleTickerProviderStateMixin {
  // late VideoPlayerController _controller;
  // late ChewieController chewieController;
  // late Future<void> _initializeVideoPlayerFuture;
  // bool isMaxScreen = true;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  playContent(String s) {
    setState(() {
      widget.myController.controller.dispose();
      widget.myController.chewieController.dispose();
      widget.contentId = s;
    });

  }

  @override
  void initState() {
    super.initState();
    if((SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) == null || SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isEmpty)){
      _createInterstitialAd();
    }
    // Tween animation
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7319269804560504/6941421099'
            : 'ca-app-pub-4865900610463415/4305955757',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            _showInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 5) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {

    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        // _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7319269804560504/6645907620'
            : 'ca-app-pub-7319269804560504/2207757133',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
            _showRewardedAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < 2) {
              _createRewardedAd();
            }
          },
        )
    );
  }

  void _showRewardedAd() {

    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        // _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);

    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        });

    _rewardedAd = null;

  }

  @override
  void dispose() {
    widget.myController.controller.dispose();
    widget.myController.chewieController.dispose();
    super.dispose();
  }

  timer() async {
    await Future.delayed(const Duration(seconds: 5));
    print("Timer");
    Duration? s = await widget.myController.controller.position;
    if(widget.myController.chewieController.isPlaying){
      print(s!.inSeconds);
      widget.myController.sendUpdateLog(widget.contentId, s!.inSeconds.toString());
    }
    if((SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) == null || SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isEmpty)){
    if(s!.inSeconds>60 && s!.inSeconds<65){
      _createRewardedAd();
    }
    }
    if(mounted){
      timer();
    }

  }

@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff7CA9FF), Color(0xffffffff)],begin: Alignment.topCenter)
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future: widget.myController.getStreamData(widget.contentId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return videoShimmer();
                        } else if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return Column(
                            children: [
                              FutureBuilder(
                                future: widget
                                    .myController.initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    widget.myController.chewieController = ChewieController(
                                      videoPlayerController: widget.myController.controller,
                                      autoPlay: true,
                                      looping: false,
                                      allowedScreenSleep: false,
                                      showControlsOnInitialize: false,
                                      autoInitialize: true,
                                      allowPlaybackSpeedChanging: false,
                                      showOptions: false,
                                      showControls: true,
                                      allowMuting: false,
                                      materialProgressColors: ChewieProgressColors(playedColor: Colors.red),
                                    );
                                    timer();
                                    widget.myController.chewieController.play();
                                    return AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Stack(
                                            children: [
                                          Chewie(
                                              controller: widget.myController.chewieController
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                // GestureDetector(
                                                //   child: const Icon(
                                                //       Icons.expand,
                                                //       size: 20,
                                                //       color: Colors.white),
                                                //   onTap: () {
                                                //     // setState(() {
                                                //     //   isMaxScreen = false;
                                                //     // });
                                                //     // widget.myController
                                                //     //     .miniController
                                                //     //     .animateToHeight(
                                                //     //         state:
                                                //     //             PanelState.MIN);
                                                //   },
                                                // ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  child: const Icon(
                                                      Icons.cancel,
                                                      size: 20,
                                                      color: Colors.white),
                                                  onTap: () {
                                                    widget.callbackPlayUi();
                                                    dispose();
                                                  },
                                                ),
                                                SizedBox(width: 20),
                                              ],
                                            ),
                                          )
                                        ]));
                                  } else {
                                    return const Center(
                                        child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Card(
                                        elevation: 0,
                                      ),
                                    ));
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: Column(children: [
                                      SvgPicture.asset(
                                          ImageConstants.watchlist_grad),
                                      GradientText(
                                        AppStrings.l10n.watchlist,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: "moch",
                                            color: Colors.black),
                                        colors: const [
                                          Color(0xff002274),
                                          Color(0xff6F1CC3),
                                          Color(0xff195AF6)
                                        ],
                                      )
                                    ]),
                                    onTap: () async {
                                      AddWatchListResponse response = await widget
                                          ._homeController
                                          .addWatchList(widget.contentId);

                                      if (response.responseDescription?.errorCode == 0 ||
                                          response.responseDescription?.errorCode ==
                                              1200) {
                                        showSnackBar(AppStrings.l10n.added_to_watchlist);
                                      }
                                    },
                                  ),
                                  GestureDetector(
                                    child: Column(children: [
                                      SvgPicture.asset(
                                          ImageConstants.share_grad),
                                      GradientText(
                                        AppStrings.l10n.share,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: "moch",
                                            color: Colors.black),
                                        colors: const [
                                          Color(0xff002274),
                                          Color(0xff6F1CC3),
                                          Color(0xff195AF6)
                                        ],
                                      )
                                    ]),
                                    onTap: () {
                                      CommonClass.shareApp();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(left: 10),
                                child: GradientText(
                                  data.content!.titleDisplay.toString(),
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
                              const SizedBox(height: 5),
                              Container(
                                width: double.maxFinite,
                                margin: const EdgeInsets.only(left: 10),
                                child: GradientText(
                                  data.content!.titledescDisplay.toString(),
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
                  SizedBox(height: 20),
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
                                child: Image.network(Constants.IMAGE_BASE_URL +
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
                              child: Image.network(Constants.IMAGE_BASE_URL +
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
                            playContent(list[index]
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
                                  Image.network(Constants.IMAGE_BASE_URL +
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
                            playContent(list[index]
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
                                child: Image.network(Constants.IMAGE_BASE_URL +
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
                              playContent(list[index]
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
                              child: Image.network(Constants.IMAGE_BASE_URL +
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
                            playContent(list[index]
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
                              child: Image.network(Constants.IMAGE_BASE_URL +
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
                            playContent(list[index]
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
                              child: Image.network(Constants.IMAGE_BASE_URL +
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
                            playContent(list[index]
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

  Future<List<PublishMasters>> getHomeData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    HomeDataRequest model = HomeDataRequest();

    model.portalId = sp.getString("portalId").toString();
    model.pageId = "1";
    model.pageName = "Streaming";
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
      HomeDataModel result =
          HomeDataModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
        child: Card(
          elevation: 0,
        ),
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
                          onTap: () {},
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
