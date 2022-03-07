import 'package:get/get.dart';
import 'package:self_check_3/presentation/main/main_controller.dart';
import 'package:self_check_3/presentation/main/main_page.dart';
import 'package:self_check_3/presentation/setting/setting_controller.dart';
import 'package:self_check_3/presentation/setting/setting_page.dart';
import 'package:self_check_3/presentation/webview/webview_controller.dart';
import 'package:self_check_3/presentation/webview/webview_page.dart';
import 'package:self_check_3/presentation/welcome/login/login_controller.dart';
import 'package:self_check_3/presentation/welcome/login/login_page.dart';
import 'package:self_check_3/presentation/welcome/set_password/set_password_controller.dart';
import 'package:self_check_3/presentation/welcome/set_password/set_password_page.dart';
import 'package:self_check_3/presentation/welcome/welcome/welcome_page.dart';
import 'package:self_check_3/route/routes.dart';

class ApplicationPages {
  static final pages = [
    GetPage(
        name: Routes.main,
        page: () => MainPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MainController());
        })),
    GetPage(
        name: Routes.webview,
        page: () => const WebviewPage(),
        binding: BindingsBuilder(() {
          Get.put(WebviewController());
        })),
    GetPage(name: Routes.welcome, page: () => const WelcomePage()),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
        })),
    GetPage(
        name: Routes.setPassword,
        page: () => const SetPasswordPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SetPasswordController());
        })),
    GetPage(
        name: Routes.setting,
        page: () => const SettingPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SettingController());
        })),
  ];
}
