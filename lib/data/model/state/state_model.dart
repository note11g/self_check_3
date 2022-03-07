class StatusModel {
  final bool alive;
  final String version;
  final String notice;
  final bool showNotice;
  final int versionCode;
  final String frontNotice;

  StatusModel(
      {required this.alive,
      required this.version,
      required this.notice,
      required this.showNotice,
      required this.versionCode,
      required this.frontNotice});

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
      alive: json['alive'],
      version: json['version'],
      notice: json['notice']['message'],
      showNotice: json['notice']['show'],
      versionCode: json['versioncode'],
      frontNotice: json['front_notice']);

  static final none = StatusModel(
      alive: true, version: "", notice: "", showNotice: false, versionCode: 0, frontNotice: "");

  @override
  String toString() =>
      "[alive: $alive, version: $version, notice: $notice, showNotice: $showNotice, versionCode: $versionCode, front_notice: $frontNotice ]";
}
