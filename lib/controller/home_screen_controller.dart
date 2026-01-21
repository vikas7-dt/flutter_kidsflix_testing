import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kidsflix_flutter/models/add_watchlist_response.dart';
import 'package:kidsflix_flutter/models/banner_request.dart';
import 'package:kidsflix_flutter/models/banner_response.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/models/category_model.dart';
import 'package:kidsflix_flutter/models/category_request.dart';
import 'package:kidsflix_flutter/models/continue_watch_reponse.dart';
import 'package:kidsflix_flutter/models/home_data_model.dart';
import 'package:kidsflix_flutter/models/home_data_request.dart';
import 'package:kidsflix_flutter/util/app_strings.dart';
import 'package:kidsflix_flutter/util/constants.dart';
import 'package:kidsflix_flutter/util/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/my_account_response.dart';
import '../util/prefs_keys.dart';

class HomeScreenController extends GetxController {
  var categoryIndex = 0.obs;
  List<AppCategories> categoryList = [];

  Future<List<PortalBanners>> getBanners(int value) async {

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();

      Constants.IMAGE_BASE_URL = sp.getString("imageBaseUrl")!;

      final model = BannerRequest();

      model.pageId = "1";
      // model.language = Get.locale!.languageCode.toString();

      if (categoryList.isEmpty) {
        model.pageName = "HOME";
      } else {
        model.pageName = categoryList[categoryIndex.value].pageName.toString();
      }

      model.portalId = sp.getString("portalId").toString();
      model.scheme = "Banner";

      print(model.toJson());

      final response =
          await http.post(Uri.parse(Constants.BASE_URL + Constants.BANNERS),
              headers: <String, String>{
                "accessToken": sp.getString("token").toString(),
                "userId": sp.getString("userId").toString(),
                "source": "app",
                'Content-Type': "application/json",
              },
              body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        BannerResponse model =
            BannerResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        print(jsonDecode(response.body));
        // return result.map((e) => BannerResponse.fromJson(e)).toList();
        return model.portalBanners!.toList();
      } else {
        throw Exception('Failed to load' + response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load');
    }
  }

  Future<MyAccountResponse> getAccount() async {

    try {

      var sp = SharedPrefsService.prefs!;

      var response = await http.get(
          Uri.parse(Constants.BASE_URL + Constants.MY_ACCOUNT),
          headers: <String, String>{
            "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
            "userId": sp.getString(PrefsKeys.USER_ID).toString(),
            "source": "app",
            'Content-Type': "application/json",
          });

      if (response.statusCode == 200) {
        var result = MyAccountResponse.fromJson(jsonDecode(response.body));
        if(result.users!.subscriber != null){
          sp.setString(PrefsKeys.SUBSCRIBE_DATA, jsonEncode(result.users!.subscriber!.toJson()));
          sp.setString(PrefsKeys.SUBSCRIBE, "true");
        }
        return result;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Failed to load");
    }
  }

  Future<List<AppCategories>> getCategories() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    CategoryRequest model = CategoryRequest();

    model.portalId = sp.getString("portalId").toString();
    model.language = AppStrings.locale;
    // model.language = Get.locale?.languageCode == "null" ? "en" : Get.locale!.languageCode.toString();

    print(model.toJson());

    final response =
        await http.post(Uri.parse(Constants.BASE_URL + Constants.CATEGORY),
            headers: <String, String>{
              "accessToken": sp.getString("token").toString(),
              "userId": sp.getString("userId").toString(),
              "source": "app",
              "charset": "utf-8",
              'Content-Type': "application/json",
            },
            body: jsonEncode(model.toJson()));

     if (response.statusCode == 200) {
      CategoryModel result = CategoryModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      categoryList.addAll(result.appCategories!.toList());
      return result.appCategories!.toList();
    } else {
      throw Exception("Failed to load cat ${response.statusCode}");
    }
  }

  Future<AddWatchListResponse> addWatchList(String contentId) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();

      final response = await http.post(
          Uri.parse(Constants.BASE_URL + Constants.ADD_WATCHLIST),
          headers: <String, String>{
            "accessToken": sp.getString("token").toString(),
            "userId": sp.getString("userId").toString(),
            "source": "app",
            'Content-Type': "application/json",
          },
          body: jsonEncode(
              <String, String>{"contentId": contentId, "source": "app"}));

      if (response.statusCode == 200) {
        AddWatchListResponse result =
            AddWatchListResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

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

  Future<List<PublishMasters>> getHomeData(int value) async {

    SharedPreferences sp = await SharedPreferences.getInstance();

    HomeDataRequest model = HomeDataRequest();

    model.portalId = sp.getString("portalId").toString();
    model.pageId = "1";
    model.language = Get.locale!.languageCode.toString();
    if (categoryList.isEmpty) {
      model.pageName = "HOME";
    } else {
      model.pageName = categoryList[value].pageName.toString();
    }
    model.scheme = "HomeContent";

    final response =
        await http.post(Uri.parse(Constants.BASE_URL + Constants.HOME_DATA),
            headers: <String, String>{
              "accessToken": sp.getString("token").toString(),
              "userId": sp.getString("userId").toString(),
              "source": "app",
              'Content-Type': "application/json",
            },
            body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      HomeDataModel result = HomeDataModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return result.publishMasters!.toList();
    } else {
      throw Exception("Failed to load ${response.statusCode}");
    }
  }

  Future<ContinueWatchResponse> getContinueWatch() async {

    SharedPreferences sp = await SharedPreferences.getInstance();

    final response =
    await http.get(Uri.parse(Constants.BASE_URL + Constants.GET_CONTINUE_WATCHING),
        headers: <String, String>{
          "accessToken": sp.getString("token").toString(),
          "userId": sp.getString("userId").toString(),
          "source": "app",
          'Content-Type': "application/json",
        });

    if (response.statusCode == 200) {
      ContinueWatchResponse result = ContinueWatchResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return result;
    } else {
      throw Exception("Failed to load ${response.statusCode}");
    }
  }

}
