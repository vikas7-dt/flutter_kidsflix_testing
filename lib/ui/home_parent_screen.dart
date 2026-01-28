import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kidsflix_flutter/controller/home_parent_controller.dart';
import 'package:kidsflix_flutter/ui/home_play_ui.dart';
import 'package:kidsflix_flutter/ui/home_screen.dart';
import 'package:kidsflix_flutter/ui/lets_go_screen.dart';
import 'package:kidsflix_flutter/ui/profile_screen.dart';
import 'package:kidsflix_flutter/ui/search_screen.dart';
import 'package:kidsflix_flutter/ui/slivers.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/ui/watchlist_screen.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:miniplayer/miniplayer.dart';

import '../util/app_strings.dart';

class HomeParentScreen extends StatefulWidget {
  HomeParentScreen({super.key});

  String contentId = "";
  var controller = Get.find<HomeParentController>();

  @override
  State<HomeParentScreen> createState() => _HomeParentScreenState();
}

class _HomeParentScreenState extends State<HomeParentScreen> {
  int currentIndex = 0;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7319269804560504/6941421099'
            : 'ca-app-pub-7319269804560504/3520838807',
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
        ));
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
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);

    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });

    _rewardedAd = null;
  }

  void callBackData(String contentId) {
    widget.contentId = contentId;
    widget.controller.playVisibility.value = true;
    // _createInterstitialAd();
  }

  void callBackData2(String contentId) {
    widget.contentId = contentId;
    widget.controller.playVisibility.value = true;
    // _createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              <Widget>[
                HomeScreen(callBackData),
                SearchScreen(callBackData2),
                WishListScreen(callBackData),
                ProfileScreen()
              ].elementAt(currentIndex),
              Obx(() {
                if (widget.controller.playVisibility.value) {
                  // widget.controller.miniController
                  //     .animateToHeight(state: PanelState.MAX);
                  return HomePlayUi(widget.contentId, callbackPlayUi);
                } else {
                  return Container();
                }
              }),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  textStyle: const TextStyle(
                      fontFamily: "moch", color: ColorUtil.TEXT_BLUE),
                  activeColor: ColorUtil.TEXT_BLUE,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[400]!,
                  color: ColorUtil.TEXT_BLUE,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: AppStrings.l10n.home,
                    ),
                    GButton(
                      icon: LineIcons.search,
                      text: AppStrings.l10n.search,
                    ),
                    GButton(
                      icon: LineIcons.heart,
                      text: AppStrings.l10n.watchlist,
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: AppStrings.l10n.profile,
                    ),
                  ],
                  selectedIndex: currentIndex,
                  onTabChange: (index) {
                    if (widget.controller.playVisibility.value) {
                      callbackPlayUi();
                    }
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (widget.controller.playVisibility.value) {
            widget.controller.playVisibility.value = false;
            return false;
          } else if (currentIndex != 0) {
            setState(() {
              currentIndex = 0;
            });
            return false;
          } else {
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
                          Image.asset(ImageConstants.pop_img_exit_app),
                          Container(
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(
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

                                      SystemChannels.platform
                                          .invokeMethod('SystemNavigator.pop');
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

            return false;
          }
        });
  }

  void callbackPlayUi() {
    widget.controller.playVisibility.value = false;
  }
}
