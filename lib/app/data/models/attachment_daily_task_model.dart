// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AttachmentDailyTaskModel attachmentDailyTaskModelFromJson(String str) =>
    AttachmentDailyTaskModel.fromJson(json.decode(str));

String attachmentDailyTaskModelToJson(AttachmentDailyTaskModel data) =>
    json.encode(data.toJson());

class AttachmentDailyTaskModel {
  bool status;
  String message;
  List<DataAttachmentDailyTaskModel> data;

  AttachmentDailyTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttachmentDailyTaskModel.fromJson(Map<String, dynamic> json) =>
      AttachmentDailyTaskModel(
        status: json["status"],
        message: json["message"],
        data: List<DataAttachmentDailyTaskModel>.from(
            json["data"].map((x) => DataAttachmentDailyTaskModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataAttachmentDailyTaskModel {
  int detailDailytaskId;
  int dailyTaskId;
  String taskName;
  int projectId;
  String projectName;
  int userId;
  String userAssigment;
  String locationTask;
  String latitude;
  String longititude;
  dynamic squence;
  String category;
  String transDtaId;
  String status;
  String descStatus;
  String type;
  String latitudeTask;
  String longititudeTask;
  dynamic description;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedBy;
  dynamic updatedAt;
  String idAttachment;
  String url;
  String name;

  DataAttachmentDailyTaskModel({
    required this.detailDailytaskId,
    required this.dailyTaskId,
    required this.taskName,
    required this.projectId,
    required this.projectName,
    required this.userId,
    required this.userAssigment,
    required this.locationTask,
    required this.latitude,
    required this.longititude,
    required this.squence,
    required this.category,
    required this.transDtaId,
    required this.status,
    required this.descStatus,
    required this.type,
    required this.latitudeTask,
    required this.longititudeTask,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.idAttachment,
    required this.url,
    required this.name,
  });

  factory DataAttachmentDailyTaskModel.fromJson(Map<String, dynamic> json) =>
      DataAttachmentDailyTaskModel(
        detailDailytaskId: json["detail_dailytask_id"],
        dailyTaskId: json["daily_task_id"],
        taskName: json["task_name"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        userId: json["user_id"],
        userAssigment: json["user_assigment"],
        locationTask: json["location_task"],
        latitude: json["latitude"],
        longititude: json["longititude"],
        squence: json["squence"],
        category: json["category"],
        transDtaId: json["trans_dta_id"],
        status: json["status"],
        descStatus: json["desc_status"],
        type: json["type"],
        latitudeTask: json["latitude_task"],
        longititudeTask: json["longititude_task"],
        description: json["description"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        idAttachment: json["id_attachment"],
        url: json["url"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "detail_dailytask_id": detailDailytaskId,
        "daily_task_id": dailyTaskId,
        "task_name": taskName,
        "project_id": projectId,
        "project_name": projectName,
        "user_id": userId,
        "user_assigment": userAssigment,
        "location_task": locationTask,
        "latitude": latitude,
        "longititude": longititude,
        "squence": squence,
        "category": category,
        "trans_dta_id": transDtaId,
        "status": status,
        "desc_status": descStatus,
        "type": type,
        "latitude_task": latitudeTask,
        "longititude_task": longititudeTask,
        "description": description,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
        "id_attachment": idAttachment,
        "url": url,
        "name": name,
      };
}
