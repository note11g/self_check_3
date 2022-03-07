import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CheckUtil {
  static Future<bool> isInternetConnected() async {
    final result = await (Connectivity().checkConnectivity());
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet;
  }

  static Future update() async {
    final updateInfo = await InAppUpdate.checkForUpdate();
    print("[Android PlayStore] update Info : $updateInfo");
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate();
    }
  }

  static Future<String> getNowVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
