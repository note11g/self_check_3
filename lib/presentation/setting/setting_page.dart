import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/presentation/setting/setting_controller.dart';
import 'package:self_check_3/resource/theme/app_color.dart';
import 'package:self_check_3/resource/values/colors.dart';
import 'package:self_check_3/route/routes.dart';
import 'package:self_check_3/util/check_util.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("설정",
                style: TextStyle(color: AppColor.onSecondary, fontSize: 18))),
        body: ListView(children: [
          _settingItem(
              onTap: () => Get.toNamed(Routes.setPassword),
              child: Text("비밀번호 변경하기",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: AppColor.onSecondary))),
          _settingItem(
              onTap: _clearAllData,
              child: Text("앱 초기화하기",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: ColorPalette.redDark))),
          Obx(() => _settingItem(
              child: Text("현재 버전 : ${controller.versionName}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: AppColor.subText))))
        ]));
  }

  Widget _settingItem({required Widget child, Function()? onTap}) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: GlobalWidgets.button(
                onTap: onTap,
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: child)),
        Divider(height: 1, color: ColorPalette.gray28)
      ],
    );
  }

  _clearAllData() {
    Get.dialog(Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "정말 초기화하시겠습니까?\n앱에 저장된 모든 데이터가 삭제됩니다.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColor.onSecondary),
            ),
          ),
          const Divider(height: 1, color: ColorPalette.gray28),
          SizedBox(
              width: double.infinity,
              child: GlobalWidgets.button(
                  onTap: controller.deleteAllData,
                  edgeInsets: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "예",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorPalette.redDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ))),
          const Divider(height: 1, color: ColorPalette.gray28),
          SizedBox(
              width: double.infinity,
              child: GlobalWidgets.button(
                  onTap: Get.back,
                  edgeInsets: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "아니오",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.onSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ))),
        ],
      ),
    ));
  }
}
