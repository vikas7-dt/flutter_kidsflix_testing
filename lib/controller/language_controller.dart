import 'dart:convert';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/avatar_response.dart';
import 'package:kidsflix_flutter/models/my_account_response.dart';
import 'package:kidsflix_flutter/models/server_response_model.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LanguageController extends GetxController {

  late SharedPreferences sp;
  var showLoader = false.obs;
  var groupValue = 1.obs;
  var model = Rxn<MyAccountResponse>();

  @override
  onInit() {
    super.onInit();
    sp = SharedPrefsService.prefs!;
    showLoader.value = true;
    getAccount();
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
        print("Receive " + (result.users?.notificationFlag == 1 ? true : false).toString());
        if(result.users?.language == "en"){
          groupValue.value =  1;
        }else if(result.users?.language == "ar"){
          groupValue.value =  2;
        }else{
          groupValue.value =  3;
        }
        // groupValue.value = result.users?.language == "en" ? 1 : 2;
        return result;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Failed to load");
    }
  }

  Future<ServerResponseModel> setLanguage(String id) async {
    showLoader.value = true;
    var response = await http.post(
        Uri.parse(Constants.BASE_URL + Constants.ACCOUNT_UPDATE),
        headers: <String, String>{
          "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
          "userId": sp.getString(PrefsKeys.USER_ID).toString(),
          "source": "app",
          'Content-Type': "application/json",
        },
        body: jsonEncode(<String, String>{"language": id}));
    showLoader.value = false;
    if (response.statusCode == 200) {
      ServerResponseModel avatarResponse =
          ServerResponseModel.fromJson(jsonDecode(response.body));
      print("Set " + (id == 1 ? true : false).toString());
      return avatarResponse;
    } else {
      throw Exception("Failed to load");
    }
  }
}
