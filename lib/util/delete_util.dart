import 'package:alert/alert.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/source/local_data_source.dart';
import '../presentation/webview/webview_controller.dart';

class DeleteUtil {
  static Future deleteAppDir() async {
    // todo : migrate to delete All App data
    await Get.find<WebviewController>().deleteWebviewData();
    await LocalDataSource.deletePw();

    Alert(message: "앱 데이터를 삭제하였습니다. 앱을 다시 실행시켜주세요.").show();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
