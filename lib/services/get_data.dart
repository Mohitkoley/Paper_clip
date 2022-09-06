import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paper_clip/model/performance.dart';

class GetData {
  static Future<Map<String, dynamic>> fetchOverview() async {
    Uri uri = Uri.parse(
        "https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      return map;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }

  static Future<List<Performance>> fetchPerformance() async {
    Uri uri = Uri.parse(
        "https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Performance> list = (json.decode(response.body) as List)
          .map((e) => Performance.fromJson(e))
          .toList();
      return list;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}
