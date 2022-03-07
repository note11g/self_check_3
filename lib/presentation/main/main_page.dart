import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:self_check_3/data/enums.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/presentation/webview/webview_controller.dart';
import 'package:self_check_3/resource/theme/app_color.dart';
import 'package:self_check_3/resource/values/links.dart';
import 'package:self_check_3/route/routes.dart';
import 'package:self_check_3/util/screen_util.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main_controller.dart';

class MainPage extends GetView<MainController> {
  MainPage({Key? key}) : super(key: key);
  final wpc = Get.find<WebviewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColor.darkBackground,
          body: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 20),
            child: Obx(
              () => Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: _topSection()),
                      const SizedBox(height: 16),
                      Expanded(flex: 5, child: _midSection()),
                      const SizedBox(height: 16),
                      Expanded(flex: 3, child: _bottomSection())
                    ],
                  ),
                  if (controller.submittingStatus.value != -1)
                    Positioned(child: _statusSection(), bottom: 12)
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return false;
        });
  }

  // ---- Section Widget Start ----

  Widget _topSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _logoWidget(),
            _appSettingButtonsWidget(),
          ],
        ),
        SizedBox(height: ScreenUtil.selectByRatio(24, 20)),
        Obx(() => HtmlWidget(controller.frontNotice.value))
      ],
    );
  }

  Widget _midSection() {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Obx(() => ListView.separated(
                    itemCount: controller.doneSurveyList.length,
                    controller: controller.doneListViewController,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final survey = controller.doneSurveyList[index];
                      return _subQuestionTextWidget(
                          question: "${survey.number}. ${survey.question}",
                          subQuestion: survey.description);
                    }))),
            if (wpc.rejectBy3m.value != -1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "마지막 설문결과 ${wpc.rejectBy3m.value}분후 재설문이 가능합니다.",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            if (!controller.nowSurvey.value.isEmpty())
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.nowSurvey.value.number != 1)
                            _goPreviousButton(
                                controller.nowSurvey.value.number - 1,
                                onTap: controller.backQuestion),
                          _questionTextWidget(
                            question:
                                "${controller.nowSurvey.value.number}. ${controller.nowSurvey.value.question}",
                            subQuestion: controller.nowSurvey.value.description,
                          )
                        ],
                      )),
                  Obx(() => _answerButtonSet(
                      noText: controller.nowSurvey.value.no,
                      answerNo: wpc.rejectBy3m.value == -1
                          ? () => controller.answer(SurveyAnswer.no)
                          : null,
                      yesText: controller.nowSurvey.value.yes,
                      answerYes: wpc.rejectBy3m.value == -1
                          ? () => controller.answer(SurveyAnswer.yes)
                          : null)),
                  SizedBox(
                      height: MediaQuery.of(Get.context!).size.height / 14),
                ],
              )
          ],
        ));
  }

  Widget _bottomSection() {
    return Obx(() => ListView.separated(
        itemCount: controller.willSurveyList.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          final survey = controller.willSurveyList[index];
          return _subQuestionTextWidget(
              question: "${survey.number}. ${survey.question}",
              subQuestion: survey.description);
        }));
  }

  Widget _statusSection() {
    return Obx(() => Text(
        "제출 중입니다. ${controller.submittingStatus.value}% 진행 중...",
        style:
            TextStyle(fontWeight: FontWeight.w500, color: AppColor.primary)));
  }

  // ---- Section Widget End ----

  // ---- Local Widget Start ----

  /* top section start */

  Widget _logoWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GlobalWidgets.alignText(tr("title_1"),
          style: TextStyle(
              fontWeight: FontWeight.w200,
              color: AppColor.secondary,
              fontSize: ScreenUtil.selectByRatio(36, 28))),
      GlobalWidgets.alignText(tr("title_2"),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.secondary,
              fontSize: ScreenUtil.selectByRatio(36, 28))),
      GlobalWidgets.alignText(tr("title_3"),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
              fontSize: ScreenUtil.selectByRatio(36, 28)))
    ]);
  }

  Widget _appSettingButtonsWidget() {
    return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _textButtonWidget("앱 설정 >", onTap: () {
              Get.toNamed(Routes.setting);
            }),
            _textButtonWidget("자가진단 키트 사용법 >", onTap: () {
              launch(Links.recommendVideoUrl);
            }),
            _textButtonWidget("교육부 자가진단으로 가기 >", onTap: () {
              wpc.goHome();
              Get.back();
            }),
          ],
        ));
  }

  Widget _textButtonWidget(String text, {required Function() onTap}) {
    return GlobalWidgets.rButton(
        onTap: onTap,
        edgeInsets: EdgeInsets.symmetric(vertical: ScreenUtil.selectByRatio(12, 8), horizontal: 12),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColor.secondary),
        ));
  }

  /* top section end */

  /* question and answer start */

  Widget _questionTextWidget({required String question, String? subQuestion}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(question,
            style: TextStyle(
                color: AppColor.secondary,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        GlobalWidgets.koreanBreakText(subQuestion ?? "\n",
            style: TextStyle(
                color: AppColor.subText,
                fontWeight: FontWeight.w500,
                fontSize: 11)),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _subQuestionTextWidget(
      {required String question, String? subQuestion}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(question,
          style: TextStyle(
              color: AppColor.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 11)),
      if (subQuestion != null) const SizedBox(height: 2),
      if (subQuestion != null)
        Text(subQuestion,
            style: TextStyle(
                color: AppColor.subText,
                fontWeight: FontWeight.w500,
                fontSize: 10))
    ]);
  }

  Widget _goPreviousButton(int previousQuestionNumber, {Function()? onTap}) {
    return FittedBox(
        child: GlobalWidgets.rButton(
            onTap: onTap,
            edgeInsets: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/image/arrow_up.svg", width: 8),
                  const SizedBox(width: 6),
                  Text("$previousQuestionNumber번으로 돌아가기",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColor.subText)),
                ])));
  }

  Widget _answerButtonSet(
      {required String noText,
      required String yesText,
      Function()? answerNo,
      Function()? answerYes}) {
    return Row(children: [
      Expanded(
          child: GlobalWidgets.rButton(
              onTap: answerNo,
              color: AppColor.secondary,
              edgeInsets: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                noText,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.onSecondary),
                textAlign: TextAlign.center,
              ))),
      const SizedBox(width: 10),
      Expanded(
          child: GlobalWidgets.rButton(
              onTap: answerYes,
              color: AppColor.secondary,
              edgeInsets: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                yesText,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.onSecondary),
                textAlign: TextAlign.center,
              ))),
      const SizedBox(width: 20),
    ]);
  }
/* question and answer end */

// ---- Local Widget End ----
}
