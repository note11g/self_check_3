import 'package:self_check_3/data/model/state/state_model.dart';
import 'package:self_check_3/data/model/survey/survey_model.dart';
import 'package:self_check_3/data/source/local_data_source.dart';
import 'package:self_check_3/data/source/remote_data_source.dart';

class AppRepository {
  static Future<List<SurveyModel>> getSurveyList() async {
    return await RemoteDataSource.getSurveys();
  }

  static Future<StatusModel> getAppStatus() async {
    return await RemoteDataSource.getAppStatus();
  }

  static Future<bool> setPassword(String password) async {
    return await LocalDataSource.savePW(password);
  }

  static Future<String?> getPassword() async {
    return await LocalDataSource.getPw();
  }
}
