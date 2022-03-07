import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/resource/theme/app_color.dart';
import 'package:self_check_3/route/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 28, right: 28),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 4, child: _titleSection()),
                    Expanded(flex: 5, child: _contentSection()),
                    Expanded(flex: 4, child: _btnSection(context))
                  ]))));

  Widget _titleSection() =>
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        GlobalWidgets.alignText(tr("secondary_welcome"), style: TextStyle()),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GlobalWidgets.alignText(tr("app_name"), style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.onSecondary, fontSize: 36)),
          Padding(padding: const EdgeInsets.only(right: 2)),
          Text(tr("app_state"),
              style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.w700))
        ])
      ]);

  Widget _contentSection() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalWidgets.koreanBreakText(tr("legal_agreement"),
                style: TextStyle(
                    fontSize: 12,
                    color: AppColor.onSecondary,
                    fontWeight: FontWeight.normal))
          ]);

  Widget _btnSection(BuildContext context) => Column(children: [
    GlobalWidgets.roundedButtonWithShadow(
            tr("agree_and_start"), () => _goNextStep(),
            backColor: AppColor.primary,
            splashColor: AppColor.primaryAccent,
            textColor: AppColor.onPrimary)
      ]);

  _goNextStep() => Get.toNamed(Routes.login);
}
