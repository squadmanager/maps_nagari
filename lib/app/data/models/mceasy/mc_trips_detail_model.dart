// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

McTripsDetailModel mcTripsDetailModelFromJson(String str) =>
    McTripsDetailModel.fromJson(json.decode(str));

String mcTripsDetailModelToJson(McTripsDetailModel data) =>
    json.encode(data.toJson());

class McTripsDetailModel {
  String message;
  List<DataMcTripsDetailModel> data;

  McTripsDetailModel({
    required this.message,
    required this.data,
  });

  factory McTripsDetailModel.fromJson(Map<String, dynamic> json) =>
      McTripsDetailModel(
        message: json["message"],
        data: List<DataMcTripsDetailModel>.from(
            json["data"].map((x) => DataMcTripsDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMcTripsDetailModel {
  int vehicleId;
  double latitude;
  double longitude;
  int speed;
  DateTime sentOn;
  String address;
  int direction;
  bool engineOn;
  DateTime lastPacket;
  DateTime lastReceive;
  dynamic motionStatus;
  String imei;
  dynamic licensePlate;
  dynamic driver;

  DataMcTripsDetailModel({
    required this.vehicleId,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.sentOn,
    required this.address,
    required this.direction,
    required this.engineOn,
    required this.lastPacket,
    required this.lastReceive,
    required this.motionStatus,
    required this.imei,
    required this.licensePlate,
    required this.driver,
  });

  factory DataMcTripsDetailModel.fromJson(Map<String, dynamic> json) =>
      DataMcTripsDetailModel(
        vehicleId: json["vehicleId"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        speed: json["speed"],
        sentOn: DateTime.parse(json["sentOn"]),
        address: json["address"],
        direction: json["direction"],
        engineOn: json["engineOn"],
        lastPacket: DateTime.parse(json["lastPacket"]),
        lastReceive: DateTime.parse(json["lastReceive"]),
        motionStatus: json["motionStatus"],
        imei: json["imei"],
        licensePlate: json["licensePlate"],
        driver: json["driver"],
      );

  Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "latitude": latitude,
        "longitude": longitude,
        "speed": speed,
        "sentOn": sentOn.toIso8601String(),
        "address": address,
        "direction": direction,
        "engineOn": engineOn,
        "lastPacket": lastPacket.toIso8601String(),
        "lastReceive": lastReceive.toIso8601String(),
        "motionStatus": motionStatus,
        "imei": imei,
        "licensePlate": licensePlate,
        "driver": driver,
      };
}
