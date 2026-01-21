import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kidsflix_flutter/models/product_reponse.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../controller/in_app_purchase_util.dart';

class BuySubsScreen extends StatefulWidget {

  BuySubsScreen({super.key});

  @override
  State<BuySubsScreen> createState() => _BuySubsScreenState();

  var inAppPurchaseController = Get.find<InAppPurchaseUtils>();

}

class _BuySubsScreenState extends State<BuySubsScreen> {

  @override
  Widget build(BuildContext context) {
    widget.inAppPurchaseController.showLoader.value = false;
    // widget.inAppPurchaseController.initialize();

    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff7CA9FF), Color(0xffffffff)])
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10, top: 50),
                    child: AspectRatio(
                      aspectRatio: 748 / 486,
                      child: Image.asset(ImageConstants.sub_banner),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GradientText(
                    AppStrings.l10n.kidsflix_premium.toUpperCase(),
                    style: const TextStyle(fontSize: 36, fontFamily: "luckiest"),
                    colors: const [
                      Color(0xff002274),
                      Color(0xff6F1CC3),
                      Color(0xff195AF6)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GradientText(
                      AppStrings.l10n.welcome_to_the_new_home_of_all_your_favourite_kids_content_full_with_learnings_entertainment_amp_premium_content,
                      style: const TextStyle(fontSize: 15, fontFamily: "moch"),
                      textAlign: TextAlign.center,
                      colors: const [
                        Color(0xff002274),
                        Color(0xff6F1CC3),
                        Color(0xff195AF6)
                      ],
                    ),
                  ),
                  FutureBuilder<ProductsResponse>(
                    future: widget.inAppPurchaseController.getProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return buildPlans(snapshot.data!);
                      } else {
                        return const Text("No data available");
                      }
                    },
                  ),
                  GradientText(
                    AppStrings.l10n.i_am_18_or_above_and_i_agree_to_terms_conditions.toUpperCase(),
                    style: const TextStyle(fontSize: 20, fontFamily: "luckiest"),
                    colors: const [
                      Color(0xffF50075),
                      Color(0xffA13A00),
                      Color(0xff740000)
                    ],
                  ),
                   Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      AppStrings.l10n.your_kidsflix_membership_renews_each_month_or_after_6_months_depending_on_the_billing_cycle_you_choose_you_can_manage_your_subscription_and_turn_off_auto_renew_at_any_time_through_the_play_store_your_kidsflix_membership_will_be_billed_in_your_local_currency_using_exchange_rates_set_by_google_play_your_payments_will_be_processed_by_google_play_within_24_hours_of_the_end_of_the_current_billing_cycle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "moch", fontSize: 12, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60,right: 20),
              width: double.maxFinite,
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: const Icon(Icons.cancel, color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Obx(() {
              return (widget.inAppPurchaseController.showLoader.isTrue)
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
        ));
  }

  Widget buildPlans(ProductsResponse data) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          itemCount: data.productMetas!.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 211 / 235,
              child: Stack(
                children: [
                  Image.asset(ImageConstants.monkey),
                  SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientText(
                          index == 0 ? AppStrings.l10n.one_month_plan : AppStrings.l10n.six_months_plan,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "luckiest",
                          ),
                          colors: const [
                            Color(0xff002274),
                            Color(0xff6F1CC3),
                            Color(0xff195AF6)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                                // widget.inAppPurchaseController.makePurchase(data.productMetas![index].playStoreProductId.toString()+"_apple");
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child:  Text(
                                  data.productMetas![index].price.toString()+" "+data.productMetas![index].currency.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "luckiest",
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
