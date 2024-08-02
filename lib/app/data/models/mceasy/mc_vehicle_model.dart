// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

McVehicleModel mcVehicleModelFromJson(String str) =>
    McVehicleModel.fromJson(json.decode(str));

String mcVehicleModelToJson(McVehicleModel data) => json.encode(data.toJson());

class McVehicleModel {
  String message;
  List<DataMcVehicleModel> data;

  McVehicleModel({
    required this.message,
    required this.data,
  });

  factory McVehicleModel.fromJson(Map<String, dynamic> json) => McVehicleModel(
        message: json["message"],
        data: List<DataMcVehicleModel>.from(
            json["data"].map((x) => DataMcVehicleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMcVehicleModel {
  int id;
  int companyId;
  int vehicleTypeId;
  dynamic driverId;
  dynamic garageId;
  dynamic tonnage;
  dynamic volume;
  dynamic fuelEfficiency;
  dynamic fuelCapacity;
  double odometer;
  String status;
  String imei;
  String licensePlate;
  dynamic thermoType;
  dynamic boxType;
  dynamic chassisNumber;
  dynamic machineNumber;
  dynamic carrosserie;
  dynamic year;
  dynamic odometerEditedOn;
  String? hullNo;

  DataMcVehicleModel({
    required this.id,
    required this.companyId,
    required this.vehicleTypeId,
    required this.driverId,
    required this.garageId,
    required this.tonnage,
    required this.volume,
    required this.fuelEfficiency,
    required this.fuelCapacity,
    required this.odometer,
    required this.status,
    required this.imei,
    required this.licensePlate,
    required this.thermoType,
    required this.boxType,
    required this.chassisNumber,
    required this.machineNumber,
    required this.carrosserie,
    required this.year,
    required this.odometerEditedOn,
    required this.hullNo,
  });

  factory DataMcVehicleModel.fromJson(Map<String, dynamic> json) =>
      DataMcVehicleModel(
        id: json["id"],
        companyId: json["companyId"],
        vehicleTypeId: json["vehicleTypeId"],
        driverId: json["driverId"],
        garageId: json["garageId"],
        tonnage: json["tonnage"],
        volume: json["volume"],
        fuelEfficiency: json["fuelEfficiency"],
        fuelCapacity: json["fuelCapacity"],
        odometer: json["odometer"]?.toDouble(),
        status: json["status"],
        imei: json["imei"],
        licensePlate: json["licensePlate"],
        thermoType: json["thermoType"],
        boxType: json["boxType"],
        chassisNumber: json["chassisNumber"],
        machineNumber: json["machineNumber"],
        carrosserie: json["carrosserie"],
        year: json["year"],
        odometerEditedOn: json["odometerEditedOn"],
        hullNo: json["hullNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "vehicleTypeId": vehicleTypeId,
        "driverId": driverId,
        "garageId": garageId,
        "tonnage": tonnage,
        "volume": volume,
        "fuelEfficiency": fuelEfficiency,
        "fuelCapacity": fuelCapacity,
        "odometer": odometer,
        "status": status,
        "imei": imei,
        "licensePlate": licensePlate,
        "thermoType": thermoType,
        "boxType": boxType,
        "chassisNumber": chassisNumber,
        "machineNumber": machineNumber,
        "carrosserie": carrosserie,
        "year": year,
        "odometerEditedOn": odometerEditedOn,
        "hullNo": hullNo,
      };
}
