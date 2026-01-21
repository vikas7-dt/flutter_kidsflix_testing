import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/models/stream_request.dart';
import 'package:kidsflix_flutter/models/stream_response.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../util/prefs_keys.dart';

class HomeParentController extends GetxController {
  var playVisibility = false.obs;
  StreamResponse? result = null;
  final MiniplayerController miniController = MiniplayerController();
  late VideoPlayerController controller;
  late ChewieController chewieController;
  late Future<void> initializeVideoPlayerFuture;
  bool isMaxScreen = true;

  sendUpdateLog(String contentId,String duration) async {

    var sp = SharedPrefsService.prefs!;

    var model = <String,String>{
      "contentId" : contentId,
      "durationElapsed" : duration
    };

    try {
      var response = await http.post(
          Uri.parse(Constants.BASE_URL + Constants.UPDATE_DATA),
          headers: <String, String>{
            "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
            "userId": sp.getString(PrefsKeys.USER_ID).toString(),
            "source": "app",
            'Content-Type': "application/json",
          },
           body: jsonEncode(model)
      );


      if (response.statusCode == 200) {
        var result = ServerResponseModel.fromJson(jsonDecode(response.body));
        return result;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Failed to load");
    }
  }

  Future<StreamResponse> getStreamData(String contentId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var model = StreamRequest();
    model.portalId = sharedPreferences.getString("portalId");
    model.contentId = contentId;
    model.language = "en";
    model.os = "Apple";
    model.osVersion = "13";
    model.browser = "";
    model.browserVersion = "";
    model.device = "Mobile";
    model.deviceType = "Apple";
    model.orientation = "landscape";
    model.isTablet = false;
    model.isMobile = true;
    model.isDesktop = false;
    model.userAgent =
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0";

    var response =
        await http.post(Uri.parse(Constants.BASE_URL + Constants.STREAM_DATA),
            headers: <String, String>{
              "accessToken": sharedPreferences.getString("token").toString(),
              "userId": sharedPreferences.getString("userId").toString(),
              "source": "app",
              'Content-Type': "application/json",
            },
            body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      try {
        result = StreamResponse.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));

        controller = VideoPlayerController.networkUrl(Uri.parse(result!
            .content!.streamWrapper!.play!.progressive!.last.link
            .toString()));
        initializeVideoPlayerFuture = controller.initialize();

        // chewieController = ChewieController(
        //   videoPlayerController: controller,
        //   autoPlay: true,
        //   looping: false,
        //   allowedScreenSleep: false,
        //   showControlsOnInitialize: false,
        //   autoInitialize: true,
        //   allowPlaybackSpeedChanging: false,
        //   showOptions: false,
        //   showControls: true,
        //   allowMuting: false,
        //   materialProgressColors: ChewieProgressColors(playedColor: Colors.red),
        // );
        return result!;
      } catch (e) {
        print(e);
        throw Exception("Failed to load ${response.statusCode}");
      }
    } else {
      throw Exception("Failed to load ${response.statusCode}");
    }
  }
}
