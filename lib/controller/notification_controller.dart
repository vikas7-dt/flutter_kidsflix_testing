import 'dart:convert';

import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/notification_response.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/prefs_keys.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';

class NotificationController extends GetxController {

  Future<NotificationResponse> getNotifications() async {
    var sp = SharedPrefsService.prefs!;

    var response = await http.get(
        Uri.parse(Constants.BASE_URL + Constants.NOTIFICATION_LIST),
        headers: <String, String>{
          "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
          "userId": sp.getString(PrefsKeys.USER_ID).toString(),
          "source": "app",
          'Content-Type': "application/json",
        });

    if (response.statusCode == 200) {
      NotificationResponse notiResponse =
          NotificationResponse.fromJson(jsonDecode(response.body));
      return notiResponse;
    } else {
      throw Exception("Failed to load");
    }
  }
}
