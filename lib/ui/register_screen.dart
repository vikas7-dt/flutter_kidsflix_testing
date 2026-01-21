import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/bindings/home_binding.dart';
import 'package:kidsflix_flutter/ui/home_parent_screen.dart';
import 'package:kidsflix_flutter/models/location_model.dart';
import 'package:kidsflix_flutter/models/gmail_register_model.dart';
import 'package:kidsflix_flutter/models/gmail_register_response.dart';
import 'package:kidsflix_flutter/models/msisdn_register_model.dart';
import 'package:kidsflix_flutter/models/msisdn_register_response.dart';
import 'package:kidsflix_flutter/ui/privacy_policy_screen.dart';
import 'package:kidsflix_flutter/util/common_class.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/models/preflight_model.dart';
import 'package:kidsflix_flutter/util/color_util.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../util/app_strings.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {

  Country country = CountryParser.parseCountryCode("IN");
  TextEditingController phoneFieldController = TextEditingController();
  bool checkedValue = true;
  String countryId = "";
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    getIp();
    HomeBinding().dependencies();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff7CA9FF), Color(0xffffffff)]
                )
            ),
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
            SafeArea(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset("assets/images/applogo_cloud.png",
                          width: double.maxFinite, height: 160)),
                  Padding(
                      padding:
                      EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(AppStrings.l10n.enter_mobile_number,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "moch",
                                  fontSize: 18,
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
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
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${country.flagEmoji} +${country.phoneCode} ",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: "moch",
                                                  fontSize: 18),
                                            ),
                                            Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                      ),
                                    )),
                                keyboardType: TextInputType.number,
                                maxLength: 14,
                                validator: (value) {
                                  phoneFieldController.text = value.toString();
                                },
                                style: const TextStyle (
                                    color: Colors.black,
                                    fontFamily: "moch",
                                    fontSize: 20
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                    value: checkedValue,
                                    onChanged: (onChanged) {
                                      setState(() {
                                        checkedValue = onChanged!;
                                      });
                                    }),
                                Text(
                                  "I agree to ",
                                  style:
                                  TextStyle(fontSize: 16, fontFamily: "moch"),
                                ),
                                GestureDetector(
                                  child: Text(
                                    AppStrings.l10n.i_am_18_or_above_and_i_agree_to_terms_conditions,
                                    style:
                                    TextStyle(fontSize: 16, fontFamily: "moch",color: ColorUtil.TEXT_BLUE),
                                  ),
                                  onTap: (){
                                    Get.to(PrivacyPolicyScreen());
                                  },
                                )
                              ],
                            ),
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
                                  if (checkedValue) {
                                    if (phoneFieldController.text.length < 8) {
                                      var snackdemo = SnackBar(
                                        content: Text(AppStrings.l10n.please_enter_valid_number),
                                        backgroundColor: Colors.red,
                                        elevation: 10,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(5),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackdemo);
                                    } else {
                                      msisdnApi(
                                          phoneFieldController.text, countryId);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                      Text(AppStrings.l10n.please_accept_terms_and_conditions),
                                      backgroundColor: Colors.red,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                child: Text(
                                  AppStrings.l10n.login_register.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "moch",
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              AppStrings.l10n.or,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: "moch"),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Platform.isIOS ?GestureDetector(
                            onTap: () => {
                              if (checkedValue)
                                {
                                  signInWithApple()
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                    Text(AppStrings.l10n.please_accept_terms_and_conditions),
                                    backgroundColor: Colors.red,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  ))
                                }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  gradient: LinearGradient(colors: [
                                    ColorUtil.BUTTON_GRAD_1,
                                    ColorUtil.BUTTON_GRAD_2
                                  ])),
                              child:  Padding(
                                padding: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.l10n.continue_with_apple,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "moch",
                                          fontSize: 18),
                                    ),
                                    Icon(Icons.apple_rounded,size: 30,color: Colors.white,)
                                  ],
                                ),
                              ),
                            ),
                          ) : SizedBox.shrink(),
                          Platform.isAndroid ?GestureDetector(
                            onTap: () => {
                              if (checkedValue)
                                {
                                  // signInWithGoogle()
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                    Text(AppStrings.l10n.please_accept_terms_and_conditions),
                                    backgroundColor: Colors.red,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  ))
                                }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.l10n.continue_with_google,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "moch",
                                      fontSize: 18),
                                ),
                                Padding(padding:const EdgeInsets.only(left: 5),child: SvgPicture.asset(ImageConstants.google,height: 20,))
                              ],
                            ),
                          ) : SizedBox.shrink(),
                        ],
                      )),
                ],
              ),
            )),
          if (showLoader)
            AbsorbPointer(
              child: Container(
                height: double.maxFinite,
                color: const Color(0xff000000).withOpacity(0.3),
                width: double.maxFinite,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
        ]
      ),
    );
  }

  Future<void> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
      ],
    );

    if(credential.email != null){
      String keyEmail = 'email';
      String valueEmail = credential.email!;

      await FlutterKeychain.put(key: keyEmail,value: valueEmail);

      gmailApi(valueEmail, countryId);

    }else{

      String keyEmail = 'email';

      String? valueEmail = await FlutterKeychain.get(key: keyEmail);

      if(valueEmail == null){
        showSnackBar(
            AppStrings.l10n.something_went_wrong);
      }else{
        gmailApi(valueEmail!, countryId);
      }

    }

    print(credential);

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

  void showCountryCodePicker() {
    showCountryPicker(
        context: context,

        countryListTheme: CountryListThemeData(
          flagSize: 25,

          backgroundColor: Colors.white,
          textStyle: TextStyle(
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

  getIp() async {
    final http.Response response =
        await http.get(Uri.parse("http://ip-api.com/json"));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      getPreflight(
          LocationModel.fromJson(json.decode(response.body)).countryCode!);
    } else {
      throw Exception('Failed to load');
    }
  }

  getPreflight(String countryId) async {
    this.countryId = countryId;

    String reqId = CommonClass.getRequestId();

    String hash = CommonClass.getCheckSumPreflight("app$reqId$countryId");

    final response = await http.post(
      Uri.parse(Constants.BASE_URL + Constants.PREFLIGHT),
      headers: <String, String>{
        'X-CHECKSUM-TOKEN': hash,
        'Content-Type': "application/json",
      },
      body: jsonEncode(<String, String>{
        "hostName": "app",
        "requestId": reqId,
        "mncCode": "",
        "mccCode": "",
        "isDebug": "true",
        "countryId": countryId
      }),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      SharedPreferences obj = await SharedPreferences.getInstance();
      PreflightModel model =
          PreflightModel.fromJson(json.decode(response.body));
      obj.setString("portalId", model.mncMccConfigs![0].portalId.toString());
      obj.setString(
          "imageBaseUrl", model.mncMccConfigs![0].imageBaseUrl.toString());
    } else {
      throw Exception('Failed to load' + response.statusCode.toString());
    }
  }
  /*
  signInWithGoogle() async {
    setState(() {
      showLoader = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      print("here");

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if(googleAuth?.accessToken==null){
        setState(() {
          showLoader = false;
        });
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String email = user.user?.email ?? "";

      print('email->$email');
      gmailApi(email, countryId);
    } on Exception catch (e) {
      print('exception->$e');
      setState(() {
        showLoader = false;
      });
    }
  }
  */

  gmailApi(String email, String countryId) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String device = "";
    String os = "";

    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
      os = "IOS";
    }else{
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.device;
      os = "Android";
    }

    String reqId = CommonClass.getRequestId();

    String hash =
        CommonClass.getCheckSumPreflight("register$reqId$email" + "app");

    GmailRegisterModel model = GmailRegisterModel();
    model.email = email;
    model.countryId = countryId;
    model.deviceType = os;
    model.isMobile = "true";
    model.language = Get.locale?.languageCode.toString();
    model.mode = "app";
    model.source = "app";
    model.requestId = reqId;
    model.fcm = "";
    model.device =device;

    final response = await http.post(
      Uri.parse(Constants.BASE_URL + Constants.REGISTER_GMAIL),
      headers: <String, String>{
        'X-CHECKSUM-TOKEN': hash,
        'Content-Type': "application/json",
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      SharedPreferences obj = await SharedPreferences.getInstance();
      GmailRegisterResponse model =
          GmailRegisterResponse.fromJson(json.decode(response.body));
      obj.setString(PrefsKeys.EMAIL, model.users!.email.toString());
      obj.setString(PrefsKeys.AVATAR, model.users!.avtarUrl.toString());
      obj.setString(PrefsKeys.FCM, "");
      obj.setBool(PrefsKeys.SUB_STATUS, false);
      obj.setString(PrefsKeys.USER_ID, model.users!.id.toString());
      obj.setBool(PrefsKeys.IS_LOGGED_IN, true);
      obj.setString(PrefsKeys.TOKEN, model.users!.userTokens![0].accessToken!);
      Get.offAll(HomeParentScreen());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => HomeParentScreen()));
    } else {
      setState(() {
        showLoader = false;
      });
      throw Exception('Failed to load' + response.statusCode.toString());
    }
  }

  msisdnApi(String phone, String countryId) async {

    setState(() {
      showLoader = true;
    });

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String device = "";
    String os = "";

    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
      os = "IOS";
    }else{
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.device;
      os = "Android";
    }

    String reqId = CommonClass.getRequestId();

    String hash = CommonClass.getCheckSumPreflight("register$reqId$phone" + "app");

    MsisdnRegisterModel model = MsisdnRegisterModel();
    model.msisdn = phone;
    model.countryId = countryId;
    model.deviceType = os;
    model.isMobile = "true";
    model.language = Get.locale?.languageCode.toString();
    model.mode = "app";
    model.source = "app";
    model.requestId = reqId;
    model.fcm = "";
    model.device = device;

    final response = await http.post(
      Uri.parse(Constants.BASE_URL + Constants.REGISTER_PHONE),
      headers: <String, String>{
        'X-CHECKSUM-TOKEN': hash,
        'Content-Type': "application/json",
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      SharedPreferences obj = await SharedPreferences.getInstance();
      MsisdnRegisterResponse model =
          MsisdnRegisterResponse.fromJson(json.decode(response.body));
      obj.setString(PrefsKeys.MOBILE, model.users!.msisdn.toString());
      obj.setString(PrefsKeys.FCM, "");
      obj.setBool(PrefsKeys.SUB_STATUS, false);
      obj.setString(PrefsKeys.USER_ID, model.users!.id.toString());
      obj.setString(PrefsKeys.TOKEN, model.users!.userTokens![0].accessToken!);
      obj.setBool(PrefsKeys.IS_LOGGED_IN, true);

      Get.offAll(HomeParentScreen());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => HomeParentScreen()));
    } else {
      setState(() {
        showLoader = false;
      });
      throw Exception('Failed to load' + response.statusCode.toString());
    }
  }
}
