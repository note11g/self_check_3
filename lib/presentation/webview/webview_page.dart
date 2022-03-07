import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:self_check_3/util/snackbar_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../resource/values/links.dart';
import 'webview_controller.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SafeArea(
              bottom: false,
              child: WebView(
                initialUrl: Links.basedUrl,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                javascriptChannels: Set.from([
                  JavascriptChannel(
                      name: 'toView',
                      onMessageReceived: (jsMessage) {
                        // channel protocol : '[type]^[message]'
                        // e.g : toView.postMessage('kp^end');
                        final type = jsMessage.message.split("^")[0];
                        final message = jsMessage.message.split("^")[1];

                        switch (type) {
                          case "kp": // 1. kp : virtual keypad open check
                            controller.runPWInput();
                            break;
                          case "kf": // 2. kf : virtual keypad open failed check (again trying get keypad set)
                            controller.retryPwInput(message);
                            break;
                          case "ml": // 3. ml : main page loaded
                            controller.onMainPageLoaded();
                            break;
                          case "sl": // 5. sl : survey loaded
                            controller.onSurveyLoaded();
                            break;
                          default:
                            print("js channel not found on 'toView'");
                            break;
                        }
                      }),
                  JavascriptChannel(
                      name: 'alertCustom',
                      onMessageReceived: controller.checkAlert)
                ]),
                onWebViewCreated: controller.onWebViewCreated,
                onPageFinished: controller.onPageFinished,
                navigationDelegate: (nr) {
                  controller.onPageFinished(nr.url);
                  return NavigationDecision.navigate;
                },
                onWebResourceError: (e) =>
                    Snack.show("네트워크가 연결되지 않았거나, 너무 느립니다.\n${e.description}"),
              ),
            )),
        onWillPop: () async {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return false;
        });
  }
}
