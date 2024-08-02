import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maps_nagari/app/data/providers/url_api.dart';

import '../../models/mceasy/mc_trips_detail_model.dart';
import '../../models/mceasy/mc_trips_model.dart';
import '../../models/mceasy/mc_vehicle_detail_model.dart';
import '../../models/mceasy/mc_vehicle_statuses_model.dart';

class McProvider {
  Future<DataMcVehicleDetail> getVehicleDetail(vehicleId) async {
    final response = await http.get(
      Uri.parse('${UrlApi().url}/api/mc-vehicle-detail/$vehicleId'),
    );

    var responseBody = mcVehicleDetailModelFromJson(response.body).data;

    return responseBody;
  }

  Future<DataMcTripsModel> getTrips(vehicleId, startDate, endDate) async {
    Map data = {
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
    };

    final response = await http.post(
      Uri.parse('${UrlApi().url}/api/mc-vehicle-trips'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    var responseBody = mcTripsModelFromJson(response.body).data;

    return responseBody;
  }

  Future<List<DataMcTripsDetailModel>> getTripsDetail(
      vehicleId, startDate, endDate) async {
    Map data = {
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
    };

    final response = await http.post(
      Uri.parse('${UrlApi().url}/api/mc-vehicle-trips-detail'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    var responseBody = mcTripsDetailModelFromJson(response.body).data;

    return responseBody;
  }

  Future<List<DataMcVehicleStatusesModel>> getVehicleStatuses() async {
    final response = await http.get(
      Uri.parse('${UrlApi().url}/api/mc-vehicle'),
    );

    var responseBody = mcVehicleStatusesModelFromJson(response.body).data;

    return responseBody;
  }
}
