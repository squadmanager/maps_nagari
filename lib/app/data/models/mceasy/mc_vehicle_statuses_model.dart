// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

McVehicleStatusesModel mcVehicleStatusesModelFromJson(String str) => McVehicleStatusesModel.fromJson(json.decode(str));

String mcVehicleStatusesModelToJson(McVehicleStatusesModel data) => json.encode(data.toJson());

class McVehicleStatusesModel {
    String message;
    List<DataMcVehicleStatusesModel> data;

    McVehicleStatusesModel({
        required this.message,
        required this.data,
    });

    factory McVehicleStatusesModel.fromJson(Map<String, dynamic> json) => McVehicleStatusesModel(
        message: json["message"],
        data: List<DataMcVehicleStatusesModel>.from(json["data"].map((x) => DataMcVehicleStatusesModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataMcVehicleStatusesModel {
    int vehicleId;
    int companyId;
    String companyName;
    dynamic driverId;
    dynamic tripDriverId;
    DateTime lastPacket;
    DateTime lastReceive;
    DateTime lastMotion;
    DateTime lastStatusChg;
    DateTime driverChangeOn;
    double latitude;
    double longitude;
    dynamic temperature;
    dynamic fuel;
    int fuelFiltered;
    int fuelCapacity;
    int sumFuel;
    int tripFuel;
    double sumDistance;
    double tripDistance;
    int sumDrivetime;
    int tripDrivetime;
    dynamic sumDrivetimeFormatted;
    String tripDrivetimeFormatted;
    int speed;
    int calculatedSpeed;
    int direction;
    int signalStrength;
    int battery;
    int harshBrakes;
    int harshAccels;
    int sharpTurns;
    int overspeeds;
    int fenceCtr;
    dynamic door1Status;
    dynamic door2Status;
    dynamic refrigeratorStatus;
    int tripMaxspeed;
    DateTime lastDoor1Data;
    DateTime lastDoor1Alert;
    DateTime lastDoor2Alert;
    DateTime lastSpeedAlert;
    DateTime lastSummary;
    DateTime tripstartOn;
    double tripstartLong;
    double tripstartLat;
    dynamic motionStatus;
    String calculatedMotionStatus;
    dynamic licensePlate;
    dynamic hullNo;
    bool engineOn;
    bool batteryAlarmSet;
    bool gsmAlarmSet;
    dynamic address;
    List<String> vehicleGroups;
    int altitude;
    dynamic imei;
    DateTime requestedDate;

    DataMcVehicleStatusesModel({
        required this.vehicleId,
        required this.companyId,
        required this.companyName,
        required this.driverId,
        required this.tripDriverId,
        required this.lastPacket,
        required this.lastReceive,
        required this.lastMotion,
        required this.lastStatusChg,
        required this.driverChangeOn,
        required this.latitude,
        required this.longitude,
        required this.temperature,
        required this.fuel,
        required this.fuelFiltered,
        required this.fuelCapacity,
        required this.sumFuel,
        required this.tripFuel,
        required this.sumDistance,
        required this.tripDistance,
        required this.sumDrivetime,
        required this.tripDrivetime,
        required this.sumDrivetimeFormatted,
        required this.tripDrivetimeFormatted,
        required this.speed,
        required this.calculatedSpeed,
        required this.direction,
        required this.signalStrength,
        required this.battery,
        required this.harshBrakes,
        required this.harshAccels,
        required this.sharpTurns,
        required this.overspeeds,
        required this.fenceCtr,
        required this.door1Status,
        required this.door2Status,
        required this.refrigeratorStatus,
        required this.tripMaxspeed,
        required this.lastDoor1Data,
        required this.lastDoor1Alert,
        required this.lastDoor2Alert,
        required this.lastSpeedAlert,
        required this.lastSummary,
        required this.tripstartOn,
        required this.tripstartLong,
        required this.tripstartLat,
        required this.motionStatus,
        required this.calculatedMotionStatus,
        required this.licensePlate,
        required this.hullNo,
        required this.engineOn,
        required this.batteryAlarmSet,
        required this.gsmAlarmSet,
        required this.address,
        required this.vehicleGroups,
        required this.altitude,
        required this.imei,
        required this.requestedDate,
    });

    factory DataMcVehicleStatusesModel.fromJson(Map<String, dynamic> json) => DataMcVehicleStatusesModel(
        vehicleId: json["vehicleId"],
        companyId: json["companyId"],
        companyName: json["companyName"],
        driverId: json["driverId"],
        tripDriverId: json["tripDriverId"],
        lastPacket: DateTime.parse(json["lastPacket"]),
        lastReceive: DateTime.parse(json["lastReceive"]),
        lastMotion: DateTime.parse(json["lastMotion"]),
        lastStatusChg: DateTime.parse(json["lastStatusChg"]),
        driverChangeOn: DateTime.parse(json["driverChangeOn"]),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        temperature: json["temperature"],
        fuel: json["fuel"],
        fuelFiltered: json["fuelFiltered"],
        fuelCapacity: json["fuelCapacity"],
        sumFuel: json["sumFuel"],
        tripFuel: json["tripFuel"],
        sumDistance: json["sumDistance"]?.toDouble(),
        tripDistance: json["tripDistance"]?.toDouble(),
        sumDrivetime: json["sumDrivetime"],
        tripDrivetime: json["tripDrivetime"],
        sumDrivetimeFormatted: json["sumDrivetimeFormatted"],
        tripDrivetimeFormatted: json["tripDrivetimeFormatted"],
        speed: json["speed"],
        calculatedSpeed: json["calculatedSpeed"],
        direction: json["direction"],
        signalStrength: json["signalStrength"],
        battery: json["battery"],
        harshBrakes: json["harshBrakes"],
        harshAccels: json["harshAccels"],
        sharpTurns: json["sharpTurns"],
        overspeeds: json["overspeeds"],
        fenceCtr: json["fenceCtr"],
        door1Status: json["door1Status"],
        door2Status: json["door2Status"],
        refrigeratorStatus: json["refrigeratorStatus"],
        tripMaxspeed: json["tripMaxspeed"],
        lastDoor1Data: DateTime.parse(json["lastDoor1Data"]),
        lastDoor1Alert: DateTime.parse(json["lastDoor1Alert"]),
        lastDoor2Alert: DateTime.parse(json["lastDoor2Alert"]),
        lastSpeedAlert: DateTime.parse(json["lastSpeedAlert"]),
        lastSummary: DateTime.parse(json["lastSummary"]),
        tripstartOn: DateTime.parse(json["tripstartOn"]),
        tripstartLong: json["tripstartLong"]?.toDouble(),
        tripstartLat: json["tripstartLat"]?.toDouble(),
        motionStatus: json["motionStatus"],
        calculatedMotionStatus: json["calculatedMotionStatus"],
        licensePlate: json["licensePlate"],
        hullNo: json["hullNo"],
        engineOn: json["engineOn"],
        batteryAlarmSet: json["batteryAlarmSet"],
        gsmAlarmSet: json["gsmAlarmSet"],
        address: json["address"],
        vehicleGroups: List<String>.from(json["vehicleGroups"].map((x) => x)),
        altitude: json["altitude"],
        imei: json["imei"],
        requestedDate: DateTime.parse(json["requestedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "companyId": companyId,
        "companyName": companyName,
        "driverId": driverId,
        "tripDriverId": tripDriverId,
        "lastPacket": lastPacket.toIso8601String(),
        "lastReceive": lastReceive.toIso8601String(),
        "lastMotion": lastMotion.toIso8601String(),
        "lastStatusChg": lastStatusChg.toIso8601String(),
        "driverChangeOn": driverChangeOn.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "temperature": temperature,
        "fuel": fuel,
        "fuelFiltered": fuelFiltered,
        "fuelCapacity": fuelCapacity,
        "sumFuel": sumFuel,
        "tripFuel": tripFuel,
        "sumDistance": sumDistance,
        "tripDistance": tripDistance,
        "sumDrivetime": sumDrivetime,
        "tripDrivetime": tripDrivetime,
        "sumDrivetimeFormatted": sumDrivetimeFormatted,
        "tripDrivetimeFormatted": tripDrivetimeFormatted,
        "speed": speed,
        "calculatedSpeed": calculatedSpeed,
        "direction": direction,
        "signalStrength": signalStrength,
        "battery": battery,
        "harshBrakes": harshBrakes,
        "harshAccels": harshAccels,
        "sharpTurns": sharpTurns,
        "overspeeds": overspeeds,
        "fenceCtr": fenceCtr,
        "door1Status": door1Status,
        "door2Status": door2Status,
        "refrigeratorStatus": refrigeratorStatus,
        "tripMaxspeed": tripMaxspeed,
        "lastDoor1Data": lastDoor1Data.toIso8601String(),
        "lastDoor1Alert": lastDoor1Alert.toIso8601String(),
        "lastDoor2Alert": lastDoor2Alert.toIso8601String(),
        "lastSpeedAlert": lastSpeedAlert.toIso8601String(),
        "lastSummary": lastSummary.toIso8601String(),
        "tripstartOn": tripstartOn.toIso8601String(),
        "tripstartLong": tripstartLong,
        "tripstartLat": tripstartLat,
        "motionStatus": motionStatus,
        "calculatedMotionStatus": calculatedMotionStatus,
        "licensePlate": licensePlate,
        "hullNo": hullNo,
        "engineOn": engineOn,
        "batteryAlarmSet": batteryAlarmSet,
        "gsmAlarmSet": gsmAlarmSet,
        "address": address,
        "vehicleGroups": List<dynamic>.from(vehicleGroups.map((x) => x)),
        "altitude": altitude,
        "imei": imei,
        "requestedDate": requestedDate.toIso8601String(),
    };
}
