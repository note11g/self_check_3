import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/data/enums.dart';
import 'package:self_check_3/data/model/state/state_model.dart';
import 'package:self_check_3/data/model/survey/survey_answer_model.dart';
import 'package:self_check_3/data/model/survey/survey_model.dart';
import 'package:self_check_3/data/repository/app_repository.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/presentation/webview/webview_controller.dart';

class MainController extends GetxController {
  final doneListViewController = ScrollController();

  final surveyList = <SurveyModel>[].obs;
  final Rx<StatusModel> appStatus = StatusModel.none.obs;

  final nowSurvey = SurveyModel.none.obs;
  final doneSurveyList = <SurveyModel>[].obs;
  final willSurveyList = <SurveyModel>[].obs;
  final surveyAnswerList = <SurveyAnswerModel>[].obs;

  final submittingStatus = (-1).obs;

  final frontNotice = "".obs;

  @override
  void onInit() {
    update();

    once(appStatus, (StatusModel? status) {
      if (status != null) _onStatusLoaded(status);
    });

    once(surveyList, (List<SurveyModel> list) {
      if (list.isNotEmpty) _onSurveyListLoaded(list);
    });

    _load();
    super.onInit();
  }

  void _load() {
    AppRepository.getSurveyList().then((list) {
      surveyList.assignAll(list);
    });
    AppRepository.getAppStatus().then((StatusModel status) {
      appStatus(status);
    });
  }

  void _onStatusLoaded(StatusModel status) async {
    print("_onStatusLoaded : $status");

    frontNotice.value = status.frontNotice;
    if (status.showNotice) {
      Get.bottomSheet(GlobalWidgets.noticeBottomSheet(status.notice));
    }
    if (Platform.isIOS) {
      // todo : update
    }
  }

  void _onSurveyListLoaded(List<SurveyModel> list) {
    print("_onSurveyListLoaded : $list");
    willSurveyList.assignAll(list);
    final now = willSurveyList.removeAt(0);
    nowSurvey(now);
  }

  void backQuestion() {
    surveyAnswerList.removeLast();
    willSurveyList.insert(0, nowSurvey.value);
    nowSurvey(doneSurveyList.removeLast());
  }

  void answer(SurveyAnswer answer) {
    doneSurveyList.add(nowSurvey.value);
    surveyAnswerList
        .add(SurveyAnswerModel(number: nowSurvey.value.number, answer: answer));

    if (willSurveyList.length == 0) {
      nowSurvey(SurveyModel.none);
      _submit(surveyAnswerList);
    } else {
      final now = willSurveyList.removeAt(0);
      nowSurvey(now);
    }

    Future.delayed(
        const Duration(milliseconds: 50),
        () => doneListViewController.animateTo(
            doneListViewController.position.maxScrollExtent,
            curve: Curves.linearToEaseOut,
            duration: const Duration(milliseconds: 800)));
  }

  Future _submit(List<SurveyAnswerModel> answers) async {
    print("submitting start...");
    final webviewController = Get.find<WebviewController>();
    submittingStatus(0);
    await (webviewController.isSurveyLoaded.future);
    submittingStatus(80);
    await webviewController.submit(answers);
    submittingStatus(100);
    Get.back();
  }
}
