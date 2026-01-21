import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kidsflix_flutter/ui/register_screen.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import '../util/app_strings.dart';

class LetsGoScreen extends StatefulWidget {
  const LetsGoScreen({super.key});

  @override
  State<LetsGoScreen> createState() => _LetsGoState();

}

class _LetsGoState extends State<LetsGoScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child:
                Image.asset("assets/images/letsgo_bg.png", fit: BoxFit.cover),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: 150,
            height: 100,
            margin: const EdgeInsets.all(20),
            child: Image.asset("assets/images/applogo_cloud.png"),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 330,
              width: 300,
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        child: Image.asset("assets/images/ic_board.png",
                            fit: BoxFit.fill,
                            height: double.maxFinite, width: double.maxFinite),
                      )),
                  Column(children: [
                    SizedBox(height: 20,),
                    Transform.rotate(
                        angle: -pi / 60.0,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 45),
                            child: Text(AppStrings.l10n.choose_nlanguage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: "luckiest")
                            )
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            SharedPrefsService.prefs!.setString(PrefsKeys.LANGUAGE, "en");
                            Get.updateLocale(const Locale("en"));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Image.asset("assets/images/english_lang.png",
                              height: 50),
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: () {
                            SharedPrefsService.prefs!.setString(PrefsKeys.LANGUAGE, "ar");
                            Get.updateLocale(const Locale("ar"));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Image.asset("assets/images/ar_lang.png",
                              height: 50),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            SharedPrefsService.prefs!.setString(PrefsKeys.LANGUAGE, "fr");
                            Get.updateLocale(const Locale("fr"));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const RegisterScreen()));
                          },
                          child: Image.asset("assets/images/french.png",
                              height: 50),
                        ),

                      ],
                    )
                  ])
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Image.asset("assets/images/alifiya.png",
                height: 150, width: 200),
          )
        ],
      ),
    ));
  }
}
