import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:kidsflix_flutter/ui/home_parent_screen.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/my_account_response.dart';
import '../models/product_reponse.dart';
import '../models/server_response_model.dart';
import '../util/constants.dart';
import '../util/prefs_keys.dart';
import '../util/shared_prefs_service.dart';

class InAppPurchaseUtils extends GetxController {

  var showLoader = false.obs;
  var checkStatus = false;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }

  Future<ProductsResponse> getProducts() async {

    SharedPreferences sp = await SharedPreferences.getInstance();

    final response = await http.get(Uri.parse(Constants.BASE_URL + Constants.GET_PRODUCTS),
        headers: <String, String>{
          "accessToken": sp.getString("token").toString(),
          "userId": sp.getString("userId").toString(),
          "source": "app",
          'Content-Type': "application/json",
        }
        );

    if (response.statusCode == 200) {
      ProductsResponse result = ProductsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return result;
    } else {
      throw Exception("Failed to load ${response.statusCode}");
    }

  }

  syncProduct(Map<String, Map<String, String>> request) async {

    var sp = SharedPrefsService.prefs!;

    try {

      var response = await http.post(
          Uri.parse(Constants.BASE_URL + Constants.SYNC_PRODUCTS),
          headers: <String, String> {
            "accessToken": sp.getString(PrefsKeys.TOKEN).toString(),
            "userId": sp.getString(PrefsKeys.USER_ID).toString(),
            "source": "app",
            'Content-Type': "application/json",
          },
          body: jsonEncode(request)
      );

      if (response.statusCode == 200) {

        var result = ServerResponseModel.fromJson(jsonDecode(response.body));

        getAccount();

        return result;

      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Failed to load");
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
        if(result.users!.subscriber != null) {
          sp.setString(PrefsKeys.SUBSCRIBE_DATA, jsonEncode(result.users!.subscriber!.toJson()));
          sp.setString(PrefsKeys.SUBSCRIBE, "true");
        } else {
          sp.setString(PrefsKeys.SUBSCRIBE_DATA, "");
          sp.setString(PrefsKeys.SUBSCRIBE, "");
        }
        Get.off(HomeParentScreen());
        return result;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("Failed to load");
    }
  }

  Future<void> initPlatformState() async {

    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration("appl_ItECrCHobsCKOHqfzKgceJALQCx");
      await Purchases.configure(configuration);
    }
    // await Purchases.configure(configuration);
  }

  // makePurchase(String productId) async {
  //
  //   showLoader.value = true;
  //
  //   List<StoreProduct> productList = await Purchases.getProducts([productId]);
  //
  //   try {
  //
  //     CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(productList.first);
  //
  //     showLoader.value = false;
  //
  //               var map = <String,String>{
  //                 "acknowledged" : "true",
  //                 "autoRenewing" : "true",
  //                 "orderId" : customerInfo.originalAppUserId.toString(),
  //                 "packageName" : customerInfo.allPurchasedProductIdentifiers.first.replaceAll("_apple", ""),
  //                 "productId" : productId.replaceAll("_apple", ""),
  //                 "purchaseState" : "Purchased",
  //                 "purchaseTime" : customerInfo.originalPurchaseDate.toString(),
  //                 "purchaseToken" : customerInfo.originalAppUserId.toString(),
  //                 "quantity" : "1",
  //                 "syncType" : "active",
  //               };
  //
  //               var parentMap = <String,Map<String,String>>{
  //                 "playStoreSubscription" : map
  //               };
  //
  //     syncProduct(parentMap);
  //
  //     if (customerInfo.entitlements.all["my_entitlement_identifier"]!.isActive) {
  //       // Unlock that great "pro" content
  //     }
  //
  //   } on PlatformException catch (e) {
  //     showLoader.value = false;
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
  //       // showError(e);
  //     }
  //   }
  // }

  checkIfSubscribed() async {
    try {
      var sp = SharedPrefsService.prefs!;
      await initPlatformState();
      await Purchases.invalidateCustomerInfoCache();
      await Purchases.syncPurchases();
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();

      print(customerInfo.entitlements.all["PRO"]!.isActive);
      print(customerInfo.activeSubscriptions.length);

      if ((!customerInfo.entitlements.all["PRO"]!.isActive) && ((SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) !=null && SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isNotEmpty))) {

        // User is not subscribed but local subscription available
        print("case 1");

        var map = <String,String>{
          "syncType" : "cancelpurchase"
        };

        var parentMap = <String,Map<String,String>>{
          "playStoreSubscription" : map
        };

        syncProduct(parentMap);

      }

      if(customerInfo.entitlements.all["PRO"]!.isActive && ((SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE) == null || SharedPrefsService.prefs!.getString(PrefsKeys.SUBSCRIBE)!.isEmpty)))
      {

        // User is subscribed but local subscription not available
        print("case 2");

        var map = <String,String>{
          "acknowledged" : "true",
          "autoRenewing" : "true",
          "orderId" : customerInfo.originalAppUserId.toString(),
          "packageName" : customerInfo.allPurchasedProductIdentifiers.first.replaceAll("_apple", ""),
          "productId" : customerInfo.allPurchasedProductIdentifiers.first.replaceAll("_apple", ""),
          "purchaseState" : "Purchased",
          "purchaseTime" : customerInfo.originalPurchaseDate.toString(),
          "purchaseToken" : customerInfo.originalAppUserId.toString(),
          "quantity" : "1",
          "syncType" : "active",
        };

        var parentMap = <String,Map<String,String>>{
          "playStoreSubscription" : map
        };

        syncProduct(parentMap);
      }
      // print(customerInfo.originalAppUserId);
      // access latest customerInfo
    }  catch (e) {
      // Error fetching customer info
      print(e);
    }
  }

}