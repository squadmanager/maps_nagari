// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DailyTaskMsModel dailyTaskMsModelFromJson(String str) =>
    DailyTaskMsModel.fromJson(json.decode(str));

String dailyTaskMsModelToJson(DailyTaskMsModel data) =>
    json.encode(data.toJson());

class DailyTaskMsModel {
  bool status;
  String message;
  List<DataDailyTaskMsModel> data;

  DailyTaskMsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DailyTaskMsModel.fromJson(Map<String, dynamic> json) =>
      DailyTaskMsModel(
        status: json["status"],
        message: json["message"],
        data: List<DataDailyTaskMsModel>.from(
            json["data"].map((x) => DataDailyTaskMsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataDailyTaskMsModel {
  int dailytaskScId;
  int projectId;
  dynamic projectName;
  int userId;
  dynamic userName;
  dynamic fullName;
  dynamic colourUser;
  dynamic taskName;
  dynamic category;
  dynamic nameDays;
  dynamic taskDesc;
  int detailDailytaskId;
  String locationStart;
  String locationEnd;
  String latStart;
  String latFinish;
  String lngStart;
  String lngFinish;
  String sequence;
  dynamic transDtscId;
  dynamic status;
  dynamic descStatus;
  dynamic type;
  dynamic lat;
  dynamic lang;
  dynamic description;
  dynamic createdBy;
  dynamic dateTransaction;
  dynamic createdAt;
  dynamic updatedAt;

  DataDailyTaskMsModel({
    required this.dailytaskScId,
    required this.projectId,
    required this.projectName,
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.colourUser,
    required this.taskName,
    required this.category,
    required this.nameDays,
    required this.taskDesc,
    required this.detailDailytaskId,
    required this.locationStart,
    required this.locationEnd,
    required this.latStart,
    required this.latFinish,
    required this.lngStart,
    required this.lngFinish,
    required this.sequence,
    required this.transDtscId,
    required this.status,
    required this.descStatus,
    required this.type,
    required this.lat,
    required this.lang,
    required this.description,
    required this.createdBy,
    required this.dateTransaction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataDailyTaskMsModel.fromJson(Map<String, dynamic> json) =>
      DataDailyTaskMsModel(
        dailytaskScId: json["dailytask_sc_id"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        userId: json["user_id"],
        userName: json["user_name"],
        fullName: json["full_name"],
        colourUser: json["colour_user"],
        taskName: json["task_name"],
        category: json["category"],
        nameDays: json["name_days"],
        taskDesc: json["task_desc"],
        detailDailytaskId: json["detail_dailytask_id"],
        locationStart: json["location_start"],
        locationEnd: json["location_end"],
        latStart: json["lat_start"],
        latFinish: json["lat_finish"],
        lngStart: json["lng_start"],
        lngFinish: json["lng_finish"],
        sequence: json["sequence"],
        transDtscId: json["trans_dtsc_id"],
        status: json["status"],
        descStatus: json["desc_status"],
        type: json["type"],
        lat: json["lat"],
        lang: json["lang"],
        description: json["description"],
        createdBy: json["created_by"],
        dateTransaction: json["date_transaction"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "dailytask_sc_id": dailytaskScId,
        "project_id": projectId,
        "project_name": projectName,
        "user_id": userId,
        "user_name": userName,
        "full_name": fullName,
        "colour_user": colourUser,
        "task_name": taskName,
        "category": category,
        "name_days": nameDays,
        "task_desc": taskDesc,
        "detail_dailytask_id": detailDailytaskId,
        "location_start": locationStart,
        "location_end": locationEnd,
        "lat_start": latStart,
        "lat_finish": latFinish,
        "lng_start": lngStart,
        "lng_finish": lngFinish,
        "sequence": sequence,
        "trans_dtsc_id": transDtscId,
        "status": status,
        "desc_status": descStatus,
        "type": type,
        "lat": lat,
        "lang": lang,
        "description": description,
        "created_by": createdBy,
        "date_transaction": dateTransaction,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
