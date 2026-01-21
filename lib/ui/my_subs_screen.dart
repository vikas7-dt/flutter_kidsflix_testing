import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/my_account_response.dart';
import 'package:kidsflix_flutter/ui/buy_subs_screen.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/in_app_purchase_util.dart';

class MySubsScreen extends StatefulWidget {

  MySubsScreen({super.key});

  var inAppPurchaseController = Get.find<InAppPurchaseUtils>();
  var subscriptionController = Get.find<InAppPurchaseUtils>();

  @override
  State<MySubsScreen> createState() => _MySubsScreenState();

}

class _MySubsScreenState extends State<MySubsScreen> {

  var isSubsAvailable = true;
  late final AppLifecycleListener _listener;

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          if(widget.subscriptionController.checkStatus){
            widget.inAppPurchaseController.checkIfSubscribed();
            print("checked");
            widget.subscriptionController.checkStatus = false;
          }
        }
      case AppLifecycleState.detached:

      case AppLifecycleState.inactive:

      case AppLifecycleState.hidden:

      case AppLifecycleState.paused:

    }

  }

@override
  void initState() {
  // Initialize the AppLifecycleListener class and pass callbacks
  _listener = AppLifecycleListener(
    onStateChange: _onStateChanged,
  );
    super.initState();
  }

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
                      AppStrings.l10n.my_subscription,
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
              if (!(SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) != null && SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isNotEmpty))
                Expanded(
                    child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(ImageConstants.oops_img),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              AppStrings.l10n.it_seems_you_don_t_have_any_active_plan_click_below_button_to_activate_your_plan,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "moch",
                                  color: Colors.black54,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Container(
                                height: 44.0,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(colors: [
                                      ColorUtil.BUTTON_GRAD_1,
                                      ColorUtil.BUTTON_GRAD_2
                                    ])),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => BuySubsScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Text(
                                    AppStrings.l10n.activate.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "moch",
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              else
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        AppStrings.l10n.mobile_number,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        SharedPrefsService.prefs!.getString(PrefsKeys.MOBILE).toString() == "null"
                            ? AppStrings.l10n.n_a : SharedPrefsService.prefs!.getString(PrefsKeys.MOBILE).toString(),
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xffF50075),
                          Color(0xffA13A00),
                          Color(0xff740000)
                        ],
                      ),
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
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        AppStrings.l10n.started_on,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        startDate(),
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xffF50075),
                          Color(0xffA13A00),
                          Color(0xff740000)
                        ],
                      ),
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
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        AppStrings.l10n.next_billing_date,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        lastDate(),
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xffF50075),
                          Color(0xffA13A00),
                          Color(0xff740000)
                        ],
                      ),
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
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        AppStrings.l10n.subscription_status,
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GradientText(
                        "Active",
                        style: TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xffF50075),
                          Color(0xffA13A00),
                          Color(0xff740000)
                        ],
                      ),
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
                      Container(
                        width: double.maxFinite,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 30, left: 50, right: 50),
                          child: Container(
                            height: 44.0,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(colors: [
                                  ColorUtil.BUTTON_GRAD_1,
                                  ColorUtil.BUTTON_GRAD_2
                                ])),
                            child: ElevatedButton(
                              onPressed: () {
                                widget.subscriptionController.checkStatus = true;
                                launchUrl(Uri.parse("https://apps.apple.com/account/subscriptions"));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Text(
                                AppStrings.l10n.cancel_subscription.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "moch",
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  String startDate() {
    
    Subscriber subscriber = Subscriber.fromJson(jsonDecode(SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE_DATA)!));
    
    // Parse the input date string into a DateTime object
    DateTime dateTime = DateTime.parse(subscriber.subscriptionDate!);

    // Format the DateTime object into a string as "dd MMM yyyy" (e.g., "28 Dec 2023")
    return DateFormat('dd MMM yyyy').format(dateTime);

  }

  String lastDate() {

    Subscriber subscriber = Subscriber.fromJson(jsonDecode(SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE_DATA)!));

    // Parse the input date string into a DateTime object
    DateTime dateTime = DateTime.parse(subscriber.expiryDate!);

    // Format the DateTime object into a string as "dd MMM yyyy" (e.g., "28 Dec 2023")
    return DateFormat('dd MMM yyyy').format(dateTime);

  }

}
