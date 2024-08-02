// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TaskGroupTeamsMsModel taskGroupTeamsMsModelFromJson(String str) => TaskGroupTeamsMsModel.fromJson(json.decode(str));

String taskGroupTeamsMsModelToJson(TaskGroupTeamsMsModel data) => json.encode(data.toJson());

class TaskGroupTeamsMsModel {
    bool status;
    String message;
    List<DataTaskGroupTeamsMsModel> data;

    TaskGroupTeamsMsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskGroupTeamsMsModel.fromJson(Map<String, dynamic> json) => TaskGroupTeamsMsModel(
        status: json["status"],
        message: json["message"],
        data: List<DataTaskGroupTeamsMsModel>.from(json["data"].map((x) => DataTaskGroupTeamsMsModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataTaskGroupTeamsMsModel {
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

    DataTaskGroupTeamsMsModel({
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

    factory DataTaskGroupTeamsMsModel.fromJson(Map<String, dynamic> json) => DataTaskGroupTeamsMsModel(
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
