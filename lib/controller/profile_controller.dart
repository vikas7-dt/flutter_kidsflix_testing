import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/my_account_response.dart';

class ProfileController extends GetxController {

  late SharedPreferences sp;
  var showLoader = false.obs;
  var avatarUrl = "".obs;
  var model = Rxn<MyAccountResponse>();

  @override
  onInit() {
    super.onInit();
    sp = SharedPrefsService.prefs!;
    avatarUrl.value = sp.getString(PrefsKeys.AVATAR).toString();
  }

  Future<MyAccountResponse> getAccount() async {

    try {

      var response = await http.get(
          Uri.parse(Constants.BASE_URL + Constants.MY_ACCOUNT),
          headers: <String, String>{
            "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
            "userId": sp.getString(PrefsKeys.USER_ID).toString(),
            "source": "app",
            'Content-Type': "application/json",
          });

      showLoader.value = false;

      if (response.statusCode == 200) {
        var result = MyAccountResponse.fromJson(jsonDecode(response.body));
        model.value = result;
        return result;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Failed to load");
    }
  }

  Future<ServerResponseModel> logout() async {
    var response = await http.get(
        Uri.parse(Constants.BASE_URL + Constants.LOGOUT),
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
