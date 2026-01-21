import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/link_portal_controller.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../util/app_strings.dart';

class LinkPortalScreen extends StatefulWidget {
  const LinkPortalScreen({super.key});

  @override
  State<LinkPortalScreen> createState() => _LinkPortalScreenState();
}

class _LinkPortalScreenState extends State<LinkPortalScreen> {
  Country country = CountryParser.parseCountryCode("IN");
  TextEditingController phoneFieldController = TextEditingController();
  LinkPortalController controller = Get.find<LinkPortalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                opacity: const AlwaysStoppedAnimation(0.5),
              ),
            ),
          ),
          SafeArea(child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only( left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        ImageConstants.back_white_img,
                        width: 40,
                        height: 40,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GradientText(
                      AppStrings.l10n.link_portal_subscription,
                      style: const TextStyle(fontSize: 18, fontFamily: "moch"),
                      colors: const [
                        Color(0xff002274),
                        Color(0xff6F1CC3),
                        Color(0xff195AF6)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 50, right: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: GradientText(
                          AppStrings.l10n.enter_mobile_number,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "moch",
                            fontSize: 18,
                          ),
                          colors: const [
                            Color(0xff002274),
                            Color(0xff6F1CC3),
                            Color(0xff195AF6)
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: phoneFieldController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: showCountryCodePicker,
                                  child: Container(
                                    height: 60,
                                    width: 80,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${country.flagEmoji} +${country.phoneCode}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "moch",
                                          fontSize: 18),
                                    ),
                                  ),
                                )),
                            keyboardType: TextInputType.number,
                            maxLength: 14,
                            validator: (value) {
                              phoneFieldController.text = value.toString();
                            },
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "moch",
                                fontSize: 20),
                          )),
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
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (phoneFieldController.text.length < 8) {
                                var snackdemo = SnackBar(
                                  content: Text(AppStrings.l10n.please_enter_valid_number),
                                  backgroundColor: Colors.red,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackdemo);
                              } else {
                                controller.showLoader.value = true;
                                ServerResponseModel model =
                                await controller.linkSub(country.phoneCode +
                                    phoneFieldController.text.toString());

                                controller.showLoader.value = false;

                                if (model.responseDescription?.errorCode == 0) {
                                  var snackdemo =  SnackBar(
                                    content: Text(AppStrings.l10n.you_have_successfully_linked_your_portal_subscription),
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackdemo);

                                  Navigator.pop(context);
                                } else {
                                  var snackdemo = SnackBar(
                                    content: Text(model
                                        .responseDescription!.errorMessage
                                        .toString()),
                                    backgroundColor: Colors.red,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackdemo);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: Text(
                              AppStrings.l10n.link.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "moch",
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
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

  void showCountryCodePicker() {
    showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.blueGrey, fontFamily: "moch"),
          bottomSheetHeight: 500,
          // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: AppStrings.l10n.search,
            hintText: AppStrings.l10n.search,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country) => setState(() {
              this.country = country;
            }));
  }
}
