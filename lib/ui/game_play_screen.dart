import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/controller/game_play_controller.dart';
import 'package:kidsflix_flutter/models/game_link_request.dart';
import 'package:kidsflix_flutter/models/game_link_response.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class GamePlayScreen extends StatefulWidget {

  String id;
  GamePlayScreen(this.id, {super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();

}

class _GamePlayScreenState extends State<GamePlayScreen> {

  GamePlayController controllerGame = Get.find<GamePlayController>();

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    getGameData(widget.id);

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Progress $progress");
          },
          onPageStarted: (String url) {
            print("Started");
          },
          onPageFinished: (String url) {
            print("Finished");
            controllerGame.showLoader.value = false;
          },
          onHttpError: (HttpResponseError error) {
            print("Erreoer");
          },
          onWebResourceError: (WebResourceError error) {
            print(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              WebViewWidget(controller: controller),
              Obx(() {
                return (controllerGame.showLoader.value == true)
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
              }),
              Padding(
                padding: EdgeInsets.only(top: 60,left: 20),
                child: GestureDetector(
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
              )
            ],
          ),
        ),
        onWillPop: () async {
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
                        Image.asset(ImageConstants.pop_item_exit_game),
                        Container(
                          width: double.maxFinite,
                          margin:
                              EdgeInsets.only(bottom: 50, left: 30, right: 60),
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
                                    SystemChrome.setPreferredOrientations(
                                        [DeviceOrientation.portraitUp]);
                                    Navigator.pop(context);
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

          return true;
        });
  }

  Future<GameLinkResponse> getGameData(String id) async {

    try {

      SharedPreferences sp = SharedPrefsService.prefs!;

      GameLinkRequest model = GameLinkRequest();
      model.portalId = sp.getString("portalId").toString();
      model.contentId = id;

      final response = await http.post(Uri.parse(Constants.BASE_URL + Constants.GAME_LINK),
              headers: <String, String>{
                "accessToken": sp.getString("token").toString(),
                "userId": sp.getString("userId").toString(),
                "source": "app",
                'Content-Type': "application/json",
              },
              body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        GameLinkResponse result = GameLinkResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        controller.loadRequest(
            Uri.parse(result.gamesAccess!.gameAccessUrl.toString()));

        if (result.gamesAccess?.orientation != "portrait") {
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.landscapeLeft]
          );
        }

        return result;

      } else {
        throw Exception("Failed to load ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to load ");
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
  }
}
