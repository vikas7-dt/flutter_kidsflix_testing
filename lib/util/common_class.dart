import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:kidsflix_flutter/models/banner_response.dart';
import 'package:share_plus/share_plus.dart';

class CommonClass {
  static String getCheckSumPreflight(String line) {
    String code = sha512.convert(utf8.encode("${line}54IzSRi")).toString();
    return code;
  }

  static shareApp() {
    Share.share("CheckOut this cool App on AppStore called Kidsflix Club");
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRequestId() => String.fromCharCodes(Iterable.generate(
      12, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String findCorrectImageUrl(
      String key, List<ContentImages> list, String imageUrl) {
    for (var item in list) {
      if (item.layoutName == key) {
        return item.contextPath.toString();
      }
    }
    return imageUrl;
  }
}
