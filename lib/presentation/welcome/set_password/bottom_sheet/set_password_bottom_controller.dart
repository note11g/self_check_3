import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/webview/webview_controller.dart';
import 'package:self_check_3/presentation/webview/webview_page.dart';
import 'package:self_check_3/presentation/welcome/set_password/set_password_controller.dart';
import 'package:self_check_3/util/snackbar_util.dart';

import '../../../../data/repository/app_repository.dart';
import '../../../../route/routes.dart';

class SetPasswordBottomController extends GetxController {
  final nowPassword = "".obs;
  final isRed = false.obs;

  String getPasswordWithIndex(int index) {
    return (nowPassword.value.length > index) ? nowPassword.value[index] : "";
  }

  add(String y) {
    nowPassword.value += y;
  }

  remove() {
    if (nowPassword.value.length > 0)
      nowPassword(nowPassword.substring(0, nowPassword.value.length - 1));
  }

  Future alert() async {
    isRed(true);
    await Future.delayed(const Duration(milliseconds: 600));
    isRed(false);
  }

  _savePwAndGoHome() async {
    if (await AppRepository.setPassword(nowPassword.value)) {
      onClose();
      Get.offAllNamed(Routes.webview);
    } else {
      Snack.show(tr("pw_save_errored"));
    }
  }

  @override
  void onClose() {
    nowPassword("");
    isRed(false);
    super.onClose();
  }

  @override
  void onInit() {
    ever(nowPassword, (String v) {
      if (v.length >= 4) {
        if (v == Get.find<SetPasswordController>().password) {
          _savePwAndGoHome();
        } else {
          alert().then((value) => nowPassword(""));
        }
      }
    });
    super.onInit();
  }
}
