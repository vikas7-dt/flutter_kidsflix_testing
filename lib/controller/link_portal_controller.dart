import 'dart:convert';

import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LinkPortalController extends GetxController {
  late SharedPreferences sp;
  var showLoader = false.obs;

  @override
  onInit() {
    super.onInit();
    sp = SharedPrefsService.prefs!;
  }

  Future<ServerResponseModel> linkSub(String id) async {
    var response = await http.post(
        Uri.parse(Constants.BASE_URL + Constants.LINK_PORTAL_SUBSCRIPTION),
        headers: <String, String>{
          "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
          "userId": sp.getString(PrefsKeys.USER_ID).toString(),
          "source": "app",
          'Content-Type': "application/json",
        },
        body: jsonEncode(<String, String>{"msisdn": id}));

    if (response.statusCode == 200) {
      ServerResponseModel avatarResponse =
          ServerResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return avatarResponse;
    } else {
      throw Exception("Failed to load");
    }
  }
}
