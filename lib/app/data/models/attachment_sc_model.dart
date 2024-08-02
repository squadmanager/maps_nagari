// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AttachmentScModel attachmentScModelFromJson(String str) =>
    AttachmentScModel.fromJson(json.decode(str));

String attachmentScModelToJson(AttachmentScModel data) =>
    json.encode(data.toJson());

class AttachmentScModel {
  bool status;
  String message;
  List<DataAttachmentScModel> data;

  AttachmentScModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttachmentScModel.fromJson(Map<String, dynamic> json) =>
      AttachmentScModel(
        status: json["status"],
        message: json["message"],
        data: List<DataAttachmentScModel>.from(
            json["data"].map((x) => DataAttachmentScModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataAttachmentScModel {
  int dailytaskScId;
  int projectId;
  String projectName;
  int userId;
  String userName;
  String fullName;
  String colourUser;
  String taskName;
  String category;
  String nameDays;
  String taskDesc;
  int detailDailytaskId;
  String locationStart;
  String locationEnd;
  String latStart;
  String latFinish;
  String lngStart;
  String lngFinish;
  String sequence;
  String transDtscId;
  String status;
  String descStatus;
  String type;
  String lat;
  String lang;
  dynamic description;
  String createdBy;
  dynamic dateTransaction;
  String idAttachment;
  String url;
  String name;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  DataAttachmentScModel({
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
    required this.idAttachment,
    required this.url,
    required this.name,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataAttachmentScModel.fromJson(Map<String, dynamic> json) =>
      DataAttachmentScModel(
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
        idAttachment: json["id_attachment"],
        url: json["url"],
        name: json["name"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "id_attachment": idAttachment,
        "url": url,
        "name": name,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
