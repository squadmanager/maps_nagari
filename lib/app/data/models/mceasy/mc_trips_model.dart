// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

McTripsModel mcTripsModelFromJson(String str) =>
    McTripsModel.fromJson(json.decode(str));

String mcTripsModelToJson(McTripsModel data) => json.encode(data.toJson());

class McTripsModel {
  String message;
  DataMcTripsModel data;

  McTripsModel({
    required this.message,
    required this.data,
  });

  factory McTripsModel.fromJson(Map<String, dynamic> json) => McTripsModel(
        message: json["message"],
        data: DataMcTripsModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataMcTripsModel {
  double totalTrip;
  double totalMovingTripDistance;
  int totalAssistedTripDistance;
  String totalHourStart;
  String totalMovingTripDuration;
  String totalAssistedTripDuration;
  String totalHourStop;
  List<SummaryTrip> summaryTrips;

  DataMcTripsModel({
    required this.totalTrip,
    required this.totalMovingTripDistance,
    required this.totalAssistedTripDistance,
    required this.totalHourStart,
    required this.totalMovingTripDuration,
    required this.totalAssistedTripDuration,
    required this.totalHourStop,
    required this.summaryTrips,
  });

  factory DataMcTripsModel.fromJson(Map<String, dynamic> json) =>
      DataMcTripsModel(
        totalTrip: json["totalTrip"]?.toDouble(),
        totalMovingTripDistance: json["totalMovingTripDistance"]?.toDouble(),
        totalAssistedTripDistance: json["totalAssistedTripDistance"],
        totalHourStart: json["totalHourStart"],
        totalMovingTripDuration: json["totalMovingTripDuration"],
        totalAssistedTripDuration: json["totalAssistedTripDuration"],
        totalHourStop: json["totalHourStop"],
        summaryTrips: List<SummaryTrip>.from(
            json["summaryTrips"].map((x) => SummaryTrip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalTrip": totalTrip,
        "totalMovingTripDistance": totalMovingTripDistance,
        "totalAssistedTripDistance": totalAssistedTripDistance,
        "totalHourStart": totalHourStart,
        "totalMovingTripDuration": totalMovingTripDuration,
        "totalAssistedTripDuration": totalAssistedTripDuration,
        "totalHourStop": totalHourStop,
        "summaryTrips": List<dynamic>.from(summaryTrips.map((x) => x.toJson())),
      };
}

class SummaryTrip {
  DateTime startTime;
  DateTime stopTime;
  int vehicleId;
  double tripMileage;
  double startLong;
  double startLat;
  double stopLong;
  double stopLat;
  int maxSpeed;
  dynamic type;
  dynamic driver;
  dynamic driverId;
  String totalHourStart;
  String totalHourStop;

  SummaryTrip({
    required this.startTime,
    required this.stopTime,
    required this.vehicleId,
    required this.tripMileage,
    required this.startLong,
    required this.startLat,
    required this.stopLong,
    required this.stopLat,
    required this.maxSpeed,
    required this.type,
    required this.driver,
    required this.driverId,
    required this.totalHourStart,
    required this.totalHourStop,
  });

  factory SummaryTrip.fromJson(Map<String, dynamic> json) => SummaryTrip(
        startTime: DateTime.parse(json["startTime"]),
        stopTime: DateTime.parse(json["stopTime"]),
        vehicleId: json["vehicleId"],
        tripMileage: json["tripMileage"]?.toDouble(),
        startLong: json["startLong"]?.toDouble(),
        startLat: json["startLat"]?.toDouble(),
        stopLong: json["stopLong"]?.toDouble(),
        stopLat: json["stopLat"]?.toDouble(),
        maxSpeed: json["maxSpeed"],
        type: json["type"],
        driver: json["driver"],
        driverId: json["driverId"],
        totalHourStart: json["totalHourStart"],
        totalHourStop: json["totalHourStop"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime.toIso8601String(),
        "stopTime": stopTime.toIso8601String(),
        "vehicleId": vehicleId,
        "tripMileage": tripMileage,
        "startLong": startLong,
        "startLat": startLat,
        "stopLong": stopLong,
        "stopLat": stopLat,
        "maxSpeed": maxSpeed,
        "type": type,
        "driver": driver,
        "driverId": driverId,
        "totalHourStart": totalHourStart,
        "totalHourStop": totalHourStop,
      };
}
