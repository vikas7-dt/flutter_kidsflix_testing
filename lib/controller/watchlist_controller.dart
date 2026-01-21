import 'dart:convert';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/watchlist_response.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistController extends GetxController {
  var list = <KidsFlixWatchLists>[].obs;

  @override
  void onInit() {
    super.onInit();
    // getWatchList();
  }

  Future<WatchListResponse> getWatchList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var response = await http.get(
      Uri.parse(Constants.BASE_URL + Constants.GET_WATCHLIST),
      headers: <String, String>{
        "accessToken": sp.getString("token").toString(),
        "userId": sp.getString("userId").toString(),
        "source": "app",
        'Content-Type': "application/json",
      },
    );

    if (response.statusCode == 200) {
      WatchListResponse result =
          WatchListResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      list.value = result.kidsFlixWatchLists!;

      return result;
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<WatchListResponse> removeWatchList(String contentId) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();

      final response = await http.post(
          Uri.parse(Constants.BASE_URL + Constants.REMOVE_WATCHLIST),
          headers: <String, String>{
            "accessToken": sp.getString("token").toString(),
            "userId": sp.getString("userId").toString(),
            "source": "app",
            'Content-Type': "application/json",
          },
          body: jsonEncode(<String, String>{"id": contentId, "source": "app"}));

      if (response.statusCode == 200) {
        WatchListResponse result =
            WatchListResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

        print(jsonEncode(result));

        return result;
      } else {
        throw Exception("Failed to load ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to load");
    }
  }
}
