import 'package:dio/dio.dart';
import 'package:self_check_3/data/model/state/state_model.dart';
import 'package:self_check_3/data/model/survey/survey_model.dart';
import 'package:self_check_3/resource/values/links.dart';

class RemoteDataSource {
  static Future<List<SurveyModel>> getSurveys() async {
    final dio = Dio();
    final Response response = await dio.get(Links.surveyServerUrl);
    return SurveyModel.fromJsonList(response.data);
  }

  static Future<StatusModel> getAppStatus() async {
    final dio = Dio();
    final Response response = await dio.get(Links.statusServerUrl);
    return StatusModel.fromJson(response.data);
  }
}
