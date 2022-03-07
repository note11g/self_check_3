import 'package:self_check_3/data/enums.dart';

class SurveyAnswerModel {
  final int number;
  final SurveyAnswer answer;

  SurveyAnswerModel({required this.number, required this.answer});

  @override
  String toString() {
    return "Answer($number : $answer)";
  }

  static List<int> toSubmitList(List<SurveyAnswerModel> answers) {
    final List<int> submitList = [];

    for (final a in answers)
      submitList.add(a.answer == SurveyAnswer.no ? 1 : 2);

    return submitList;
  }
}
