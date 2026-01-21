import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/app_strings.dart';
import '../util/image_constatnts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    controller.loadRequest(
        Uri.parse("https://uae.kidflix.club/#/app/v2/privacy-policy"));

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
          SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          ImageConstants.back_white_img,
                          width: 40,
                          height: 40,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GradientText(
                        AppStrings.l10n.privacy_and_t_amp_c,
                        style: const TextStyle(fontSize: 18, fontFamily: "moch"),
                        colors: const [
                          Color(0xff002274),
                          Color(0xff6F1CC3),
                          Color(0xff195AF6)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: WebViewWidget(controller: controller),
                  ),
                ],
              )),
        ]
      ),
    );
  }
}
