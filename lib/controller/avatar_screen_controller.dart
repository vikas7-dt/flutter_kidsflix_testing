import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/models/avatar_response.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarScreenController extends GetxController {
  late SharedPreferences sp;
  var showLoader = false.obs;

  @override
  onInit() {
    super.onInit();
    sp = SharedPrefsService.prefs!;
  }

  Future<AvatarResponse> getAvatars() async {
    var response =
        await http.post(Uri.parse(Constants.BASE_URL + Constants.AVATAR_DATA),
            headers: <String, String>{
              "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
              "userId": sp.getString(PrefsKeys.USER_ID).toString(),
              "source": "app",
              'Content-Type': "application/json",
            },
            body: jsonEncode(<String, String>{"status": "1"}));

    if (response.statusCode == 200) {
      AvatarResponse avatarResponse =
          AvatarResponse.fromJson(jsonDecode(response.body));
      return avatarResponse;
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<ServerResponseModel> setAvatar(String id) async {
    var response = await http.post(
        Uri.parse(Constants.BASE_URL + Constants.ACCOUNT_UPDATE),
        headers: <String, String>{
          "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
          "userId": sp.getString(PrefsKeys.USER_ID).toString(),
          "source": "app",
          'Content-Type': "application/json",
        },
        body: jsonEncode(<String, String>{"avtarId": id}));

    if (response.statusCode == 200) {
      ServerResponseModel avatarResponse =
          ServerResponseModel.fromJson(jsonDecode(response.body));
      return avatarResponse;
    } else {
      throw Exception("Failed to load");
    }
  }
}
