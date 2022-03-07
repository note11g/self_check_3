class SurveyModel {
  final int number;
  final String question;
  final String? description;
  final String no;
  final String yes;

  SurveyModel(
      {required this.number,
      required this.question,
      this.description,
      required this.no,
      required this.yes});

  static SurveyModel fromJson(dynamic json) {
    return SurveyModel(
        number: json["number"],
        question: json["question"],
        description: json["description"],
        no: json["no"],
        yes: json["yes"]);
  }

  static List<SurveyModel> fromJsonList(dynamic json) {
    if (json is List) {
      final res = <SurveyModel>[];
      for (var v in json) res.add(fromJson(v));
      return res;
    } else {
      return [];
    }
  }

  static final none = SurveyModel(number: -1, question: "", no: "", yes: "");

  @override
  String toString() {
    return "SurveyModel($number : $question, description : $description, ($no, $yes))";
  }

  bool isEmpty() =>
      this.number == -1 && this.question == "" && this.no == "" && this.yes == "";
}
