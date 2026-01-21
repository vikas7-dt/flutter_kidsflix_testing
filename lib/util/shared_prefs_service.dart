import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {

  static SharedPreferences? _prefs;
  static String appVersion = "";

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "v_"+packageInfo.version;
  }

  static SharedPreferences? get prefs => _prefs;

}
