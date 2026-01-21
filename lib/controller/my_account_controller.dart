import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_strings.dart';

class MyAccountController extends GetxController {

  late SharedPreferences sp;
  var avatarUrl = "".obs;
  var email = "".obs;
  var mobile = "".obs;
  var showLoader = false.obs;

  onStartScreen() {
    sp = SharedPrefsService.prefs!;
    avatarUrl.value = sp.getString(PrefsKeys.AVATAR).toString();
    email.value = sp.getString(PrefsKeys.EMAIL).toString() == "null"
        ? AppStrings.l10n.n_a
          : sp.getString(PrefsKeys.EMAIL).toString();
    mobile.value = sp.getString(PrefsKeys.MOBILE).toString() == "null"
        ? AppStrings.l10n.n_a
        : sp.getString(PrefsKeys.MOBILE).toString();
    ;
  }

  Future<ServerResponseModel> deleteAccount() async {
    var response = await http.delete(
        Uri.parse(Constants.BASE_URL + Constants.DELETE_ACCOUNT),
        headers: <String, String>{
          "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
          "userId": sp.getString(PrefsKeys.USER_ID).toString(),
          "source": "app",
          'Content-Type': "application/json",
        });

    if (response.statusCode == 200) {
      ServerResponseModel model =
          ServerResponseModel.fromJson(json.decode(response.body));
      // return result.map((e) => BannerResponse.fromJson(e)).toList();
      return model;
    } else {
      throw Exception('Failed to load' + response.statusCode.toString());
    }
  }

}
