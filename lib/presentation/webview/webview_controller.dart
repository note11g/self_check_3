import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:self_check_3/data/repository/app_repository.dart';
import 'package:self_check_3/resource/values/links.dart';
import 'package:self_check_3/util/snackbar_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../data/model/survey/survey_answer_model.dart';
import '../../route/routes.dart';
import '../../resource/values/js_querys.dart';

class WebviewController extends GetxController {
  late final WebViewController _webViewController;
  final failCount = 0.obs;
  final rejectBy3m = (-1).obs;
  final Completer<bool> isSurveyLoaded = Completer();

  @override
  Future<void> onInit() async {
    final String? pw = await AppRepository.getPassword();
    if (pw == null) {
      Get.offAllNamed(Routes.welcome);
    } else {
      Get.toNamed(Routes.main);
      ever(rejectBy3m, (int v) {
        if (v != -1) {
          Future.delayed(
              v == 0 ? const Duration(seconds: 30) : const Duration(minutes: 1),
              () {
            rejectBy3m(-1);
            _webViewController.runJavascript(JsQuery.clickFirstPerson);
          });
        }
      });
      super.onInit();
    }
  }

  onWebViewCreated(WebViewController c) {
    _webViewController = c;
  }

  onPageFinished(String url) async {
    print("[url] $url");
    await _webViewController.runJavascript(JsQuery.changeAlertForSnackbar);
    switch (url) {
      case Links.reLoginUrl:
        _webViewController.runJavascript(JsQuery.checkKeypadOpened);
        break;
      case Links.mainUrl:
        _webViewController.runJavascript(JsQuery.checkMainPageLoaded);
        break;
      case Links.surveyUrl:
        _webViewController.runJavascript(JsQuery.checkSurveyLoaded);
        break;
    }
  }

  onMainPageLoaded() async {
    await _webViewController.runJavascript(JsQuery.clickFirstPerson); // 첫번째 클릭
  }

  onSurveyLoaded() async {
    print("설문 로딩됨");
    isSurveyLoaded.complete(true);
  }

  checkAlert(JavascriptMessage jsMessage) async {
    final m = jsMessage.message;
    print("checkAlert" + m);
    if (m == "올바른 비밀번호를 입력하세요" ||
        m.startsWith("사용자 비밀번호가 맞지 않습니다.") ||
        m == "비밀번호 4자리를 입력해주세요") {
      _webViewController.runJavascript(JsQuery.checkKeypadOpenedFailed);
      failCount.value++;
      print("[Webview] 검증 재 시도");
    } else if (m.indexOf("재설문이 가능합니다.") != -1) {
      rejectBy3m(int.parse(m.split("약")[1].split("분")[0]));
    }
    if (failCount.value > 1 ||
        (await _webViewController.currentUrl()) != Links.reLoginUrl)
      Snack.show(m);
  }

  runPWInput() async {
    final String pw = (await AppRepository.getPassword())!;
    await Future.delayed(const Duration(milliseconds: 500));
    await _webViewController
        .runJavascript(JsQuery.getKeypadOpenQuery(pw, Platform.isAndroid));

    await Future.delayed(const Duration(milliseconds: 100));
    await _webViewController.runJavascript(JsQuery.clickLoginBtn);

    if (Platform.isIOS)
      await _webViewController.runJavascript(JsQuery.checkMainPageLoaded);
  }

  retryPwInput(message) async {
    await _webViewController.runJavascript(JsQuery.checkFinishedLoad(message));
  }

  Future submit(List<SurveyAnswerModel> answers) async {
    final List<int> submitList = SurveyAnswerModel.toSubmitList(answers);
    await _webViewController.runJavascript(JsQuery.checkSurvey(submitList));
  }

  Future goHome() async {
    await isSurveyLoaded.future;
    await _webViewController.loadUrl(Links.mainUrl);
  }

  Future deleteWebviewData() async {
    await _webViewController.runJavascript(JsQuery.clearLocalStorage);
    final CookieManager cookieManager = CookieManager();
    await cookieManager.clearCookies();
    await _webViewController.clearCache();
  }
}
