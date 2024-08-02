// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

McVehicleDetailModel mcVehicleDetailModelFromJson(String str) => McVehicleDetailModel.fromJson(json.decode(str));

String mcVehicleDetailModelToJson(McVehicleDetailModel data) => json.encode(data.toJson());

class McVehicleDetailModel {
  String message;
  DataMcVehicleDetail data;

  McVehicleDetailModel({
    required this.message,
    required this.data,
  });

  factory McVehicleDetailModel.fromJson(Map<String, dynamic> json) => McVehicleDetailModel(
        message: json["message"],
        data: DataMcVehicleDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataMcVehicleDetail {
  int id;
  int companyId;
  int vehicleTypeId;
  dynamic garageId;
  dynamic tonnage;
  dynamic volume;
  int fuelEfficiency;
  int fuelCapacity;
  double odometer;
  String status;
  String imei;
  String licensePlate;
  dynamic thermoType;
  dynamic boxType;
  dynamic chassisNumber;
  dynamic machineNumber;
  String carrosserie;
  dynamic year;
  String hullNo;
  dynamic driverId;

  DataMcVehicleDetail({
    required this.id,
    required this.companyId,
    required this.vehicleTypeId,
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
    required this.hullNo,
    required this.driverId,
  });

  factory DataMcVehicleDetail.fromJson(Map<String, dynamic> json) => DataMcVehicleDetail(
        id: json["id"],
        companyId: json["companyId"],
        vehicleTypeId: json["vehicleTypeId"],
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
        hullNo: json["hullNo"],
        driverId: json["driverId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "vehicleTypeId": vehicleTypeId,
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
        "hullNo": hullNo,
        "driverId": driverId,
      };
}
