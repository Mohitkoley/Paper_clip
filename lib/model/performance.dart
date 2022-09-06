import 'dart:convert';

List<Performance> performanceFromJson(String str) => List<Performance>.from(
    json.decode(str).map((x) => Performance.fromJson(x)));

String performanceToJson(List<Performance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Performance {
  Performance({
    required this.id,
    required this.label,
    required this.chartPeriodCode,
    required this.changePercent,
  });

  int id;
  String label;
  String chartPeriodCode;
  double changePercent;

  factory Performance.fromJson(Map<String, dynamic> json) => Performance(
        id: json["ID"] as int,
        label: json["Label"] as String,
        chartPeriodCode: json["ChartPeriodCode"] as String,
        changePercent: json["ChangePercent"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Label": label,
        "ChartPeriodCode": chartPeriodCode,
        "ChangePercent": changePercent,
      };
}
