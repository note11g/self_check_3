import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/util/check_util.dart';
import 'package:self_check_3/util/delete_util.dart';

import '../../resource/theme/app_color.dart';
import '../global_widgets.dart';

class SettingController extends GetxController {
  final versionName = "".obs;

  deleteAllData() {
    DeleteUtil.deleteAppDir();
  }

  @override
  void onInit() async {
    versionName.value = await CheckUtil.getNowVersion();
    super.onInit();
  }
}
