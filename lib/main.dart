import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kidsflix_flutter/bindings/home_binding.dart';
import 'package:kidsflix_flutter/ui/firebase_options.dart';
import 'package:kidsflix_flutter/ui/home_parent_screen.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'ui/lets_go_screen.dart';
import 'package:flutter/material.dart';

main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefsService.init();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({super.key});
  static String locale = "en";

  // final InAppPurchaseUtils inAppPurchaseUtils = InAppPurchaseUtils.inAppPurchaseUtilsInstance;

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

   void setIt(){
    setState(() {
      MyApp.locale = HomeScreen.getLanguage();
    });
  }

  @override
  void initState() {
    super.initState();
    if(MyApp.locale != HomeScreen.getLanguage()){
      setIt();
    }
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        initialBinding: HomeBinding(),
        onGenerateTitle: (context) {
          AppStrings.init(context);
          return "KidsFlix";
        },
        locale: Locale(MyApp.locale),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          // 'en' is the language code. We could optionally provide a
          // country code as the second param, e.g.
          // Locale('en', 'US'). If we do that, we may want to
          // provide an additional app_en_US.arb file for
          // region-specific translations.
          Locale('en', ''),
          Locale('ar', ''),
          Locale('fr', ''),
        ],
        home: const HomeScreen(),
        builder: (context, child) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: child!,
      );
    },
      );
  }
}

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static void setLanguage(String lang){

    SharedPrefsService.prefs?.setString(PrefsKeys.LANGUAGE, lang);

  }

  static String getLanguage(){
    if(SharedPrefsService.prefs?.getString(PrefsKeys.LANGUAGE)!=null){
      return SharedPrefsService.prefs!.getString(PrefsKeys.LANGUAGE).toString();
    }else{
      return "en";
    }
  }

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    unawaited(delayedFunction());
    super.initState();
  }

  @override
  Future<void> delayedFunction() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 4));
    Get.updateLocale(Locale(SharedPrefsService.prefs!.getString(PrefsKeys.LANGUAGE).toString()));
    if (obj.getBool(PrefsKeys.IS_LOGGED_IN) == true) {
      Get.offAll(() => HomeParentScreen());
    } else {
      Get.offAll(() => const LetsGoScreen());
    }
  }



  @override
  Widget build(BuildContext context) {
    AppStrings.init(context);

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Image.asset(
            ImageConstants.splash_bg,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Image.asset('assets/images/crafted_img.png'),
        ),
        Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 50),
          child: Image.asset('assets/images/cloud_img.png'),
        ),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(100),
            child: Image.asset('assets/images/kidsflix_img.png')),
      ],
    );
  }

}
