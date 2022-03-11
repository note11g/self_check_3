import 'package:get/get.dart';
import 'package:self_check_3/route/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../resource/values/js_querys.dart';
import '../../../resource/values/links.dart';

class LoginController extends GetxController {
  late final WebViewController _webViewController;

  onWebviewCreated(WebViewController controller) {
    _webViewController = controller;
  }

  Future onPageFinished(String url) async {
    print("[onPageFinished] $url");
    await _webViewController.runJavascript(JsQuery.changeAlertForSnackbar);
    if (url == Links.mainUrl) goNextPage();
  }

  goNextPage() => Get.offNamed(Routes.setPassword);
}
