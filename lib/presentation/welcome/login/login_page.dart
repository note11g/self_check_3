import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/resource/theme/app_color.dart';
import 'package:self_check_3/util/snackbar_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../resource/values/links.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              if (MediaQuery.of(context).viewInsets.bottom <=
                  MediaQuery.of(context).padding.bottom)
                _bannerSection(),
              Expanded(
                  child: WebView(
                      initialUrl: Links.basedUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: true,
                      onWebViewCreated: controller.onWebviewCreated,
                      onPageFinished: controller.onPageFinished,
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: 'alertCustom',
                            onMessageReceived: (jsMessage) => Snack.show(jsMessage.message,
                                color: AppColor.secondary,
                                backgroundColor: Colors.black87)),
                      ]))),
            ])));
  }

  Widget _bannerSection() => Container(
      padding: Platform.isIOS
          ? const EdgeInsets.fromLTRB(24, 8, 24, 8)
          : const EdgeInsets.fromLTRB(24, 40, 24, 40),
      color: Colors.black87,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(tr("login_induction"),
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15)),
              Padding(padding: const EdgeInsets.only(top: 1)),
                  GlobalWidgets.alignText(tr("secondary_login_induction"),
                  style: TextStyle(
                      color: AppColor.subText, fontWeight: FontWeight.w500)),
            ])),
        if (Platform.isIOS)
          GlobalWidgets.rButton(
              onTap: controller.goNextPage,
              edgeInsets: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              cornerRadius: 6,
              color: Colors.white30,
              child: Text(tr("end_login_btn"),
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: AppColor.secondary)))
      ]));
}
