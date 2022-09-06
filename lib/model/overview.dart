// To parse this JSON data, do
//
//     final general = generalFromJson(jsonString);

import 'dart:convert';

Overview overviewFromJson(String str) => Overview.fromJson(json.decode(str));

String overviewToJson(Overview data) => json.encode(data.toJson());

class Overview {
  Overview({
    required this.id,
    required this.security,
    required this.industryId,
    required this.industry,
    required this.sectorId,
    required this.sector,
    required this.mcap,
    required this.ev,
    required this.evDateEnd,
    required this.bookNavPerShare,
    required this.ttmpe,
    required this.ttmYearEnd,
    required this.generalYield,
    required this.yearEnd,
    required this.sectorSlug,
    required this.industrySlug,
    required this.securitySlug,
    required this.pegRatio,
  });

  int id;
  String security;
  int industryId;
  String industry;
  int sectorId;
  String sector;
  double mcap;
  double ev;
  int evDateEnd;
  double bookNavPerShare;
  double ttmpe;
  int ttmYearEnd;
  double generalYield;
  int yearEnd;
  String sectorSlug;
  String industrySlug;
  String securitySlug;
  double pegRatio;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        id: json["ID"] as int,
        security: json["Security"] as String,
        industryId: json["IndustryID"] as int,
        industry: json["Industry"] as String,
        sectorId: json["SectorID"] as int,
        sector: json["Sector"] as String,
        mcap: json["MCAP"].toDouble(),
        ev: json["EV"] ?? 0.0,
        evDateEnd: json["EVDateEnd"] ?? 0,
        bookNavPerShare: json["BookNavPerShare"].toDouble(),
        ttmpe: json["TTMPE"].toDouble(),
        ttmYearEnd: json["TTMYearEnd"] as int,
        generalYield: json["Yield"].toDouble(),
        yearEnd: json["YearEnd"] as int,
        sectorSlug: json["SectorSlug"] as String,
        industrySlug: json["IndustrySlug"] as String,
        securitySlug: json["SecuritySlug"] as String,
        pegRatio: json["PEGRatio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Security": security,
        "IndustryID": industryId,
        "Industry": industry,
        "SectorID": sectorId,
        "Sector": sector,
        "MCAP": mcap,
        "EV": ev,
        "EVDateEnd": evDateEnd,
        "BookNavPerShare": bookNavPerShare,
        "TTMPE": ttmpe,
        "TTMYearEnd": ttmYearEnd,
        "Yield": generalYield,
        "YearEnd": yearEnd,
        "SectorSlug": sectorSlug,
        "IndustrySlug": industrySlug,
        "SecuritySlug": securitySlug,
        "PEGRatio": pegRatio,
      };
}
