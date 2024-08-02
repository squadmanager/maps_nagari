import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:maps_nagari/app/data/providers/url_api.dart';

import '../../widgets/snackbar_widget.dart';
import '../models/daily_task_ms_model.dart';
import '../models/daily_task_rs_model.dart';
import '../models/task_group_teams_ms_model.dart';
import '../models/task_group_teams_rs_model.dart';

class MonitoringScProvider {
  // road sweeper
  Future<List<DataTaskGroupTeamsRsModel>> getTaskGroupTeamsRs(token) async {
    final response = await http.get(
      Uri.parse(UrlApi().taskGroupTeamsRs),
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

    var responseBody = taskGroupTeamsRsModelFromJson(response.body).data;

    return responseBody;
  }

  Future<List<DataDailyTaskRsModel>> getTaskWhereTeamsRs(token, userId) async {
    final response = await http.get(
      Uri.parse('${UrlApi().taskWhereTeamsRs}/$userId'),
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

    var responseBody = dailyTaskRsModelFromJson(response.body).data;

    return responseBody;
  }
  // end road sweeper

  // manual sweeper
  Future<List<DataTaskGroupTeamsMsModel>> getTaskGroupTeamsMs(token) async {
    final response = await http.get(
      Uri.parse(UrlApi().taskGroupTeamsMs),
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

    var responseBody = taskGroupTeamsMsModelFromJson(response.body).data;

    return responseBody;
  }

  Future<List<DataDailyTaskMsModel>> getTaskWhereTeamsMs(token, userId) async {
    final response = await http.get(
      Uri.parse('${UrlApi().taskWhereTeamsMs}/$userId'),
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
  // end manual sweeper
}
