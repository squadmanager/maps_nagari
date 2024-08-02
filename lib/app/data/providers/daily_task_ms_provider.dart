import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:maps_nagari/app/data/providers/url_api.dart';

import '../../widgets/snackbar_widget.dart';
import '../models/daily_task_ms_model.dart';

class DailyTaskMsProvider {
  Future<List<DataDailyTaskMsModel>> getDailyTask(token) async {
    final response = await http.get(
      Uri.parse(UrlApi().dailyTaskMs),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 500) {
      await EasyLoading.dismiss();
      SnackbarWidget().getSnackbar(
          'Alert!', 'Server error, please contact the administrator', 'error');
    }

    var responseBody = dailyTaskMsModelFromJson(response.body).data;

    return responseBody;
  }

  Future<List<DataDailyTaskMsModel>> getDailyTaskUserLogin(token) async {
    final response = await http.get(
      Uri.parse(UrlApi().taskWhereTeamsLoginMs),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 500) {
      await EasyLoading.dismiss();
      SnackbarWidget().getSnackbar(
          'Alert!', 'Server error, please contact the administrator', 'error');
    }

    var responseBody = dailyTaskMsModelFromJson(response.body).data;

    return responseBody;
  }

  Future<dynamic> insertDailyTask(token, data) async {
    final response = await http.post(
      Uri.parse(UrlApi().storeDailyTaskMs),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 500) {
      await EasyLoading.dismiss();
      SnackbarWidget().getSnackbar(
          'Alert!', 'Server error, please contact the administrator', 'error');
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> updateDailyTask(token, data, id) async {
    final response = await http.put(
      Uri.parse('${UrlApi().updateDailyTaskMs}/$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 500) {
      await EasyLoading.dismiss();
      SnackbarWidget().getSnackbar(
          'Alert!', 'Server error, please contact the administrator', 'error');
    }

    return jsonDecode(response.body);
  }
}
