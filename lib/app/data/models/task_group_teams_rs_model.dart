// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TaskGroupTeamsRsModel taskGroupTeamsRsModelFromJson(String str) =>
    TaskGroupTeamsRsModel.fromJson(json.decode(str));

String taskGroupTeamsRsModelToJson(TaskGroupTeamsRsModel data) =>
    json.encode(data.toJson());

class TaskGroupTeamsRsModel {
  bool status;
  String message;
  List<DataTaskGroupTeamsRsModel> data;

  TaskGroupTeamsRsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TaskGroupTeamsRsModel.fromJson(Map<String, dynamic> json) =>
      TaskGroupTeamsRsModel(
        status: json["status"],
        message: json["message"],
        data: List<DataTaskGroupTeamsRsModel>.from(
            json["data"].map((x) => DataTaskGroupTeamsRsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataTaskGroupTeamsRsModel {
  int detailDailytaskId;
  int dailytaskScId;
  int userId;
  String taskName;
  String taskDesc;
  String fullName;
  String category;
  int totalTask;
  int taskDone;
  int taskDraft;
  String statusTask;

  DataTaskGroupTeamsRsModel({
    required this.detailDailytaskId,
    required this.dailytaskScId,
    required this.userId,
    required this.taskName,
    required this.taskDesc,
    required this.fullName,
    required this.category,
    required this.totalTask,
    required this.taskDone,
    required this.taskDraft,
    required this.statusTask,
  });

  factory DataTaskGroupTeamsRsModel.fromJson(Map<String, dynamic> json) =>
      DataTaskGroupTeamsRsModel(
        detailDailytaskId: json["detail_dailytask_id"],
        dailytaskScId: json["dailytask_sc_id"],
        userId: json["user_id"],
        taskName: json["task_name"],
        taskDesc: json["task_desc"],
        fullName: json["full_name"],
        category: json["category"],
        totalTask: json["total_task"],
        taskDone: json["task_done"],
        taskDraft: json["task_draft"],
        statusTask: json["status_task"],
      );

  Map<String, dynamic> toJson() => {
        "detail_dailytask_id": detailDailytaskId,
        "dailytask_sc_id": dailytaskScId,
        "user_id": userId,
        "task_name": taskName,
        "task_desc": taskDesc,
        "full_name": fullName,
        "category": category,
        "total_task": totalTask,
        "task_done": taskDone,
        "task_draft": taskDraft,
        "status_task": statusTask,
      };
}
