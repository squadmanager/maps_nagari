import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../widgets/snackbar_widget.dart';
import '../models/attachment_sc_model.dart';
import 'url_api.dart';

class AttachmentScProvider {
  // road sweeper
  Future<List<DataAttachmentScModel>> getImageRs(token, id) async {
    final response = await http.get(
      Uri.parse('${UrlApi().getImageWhereDailyTaskRs}/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var responseBody = attachmentScModelFromJson(response.body).data;

    return responseBody;
  }

  Future<dynamic> storeImageRs(token, data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(UrlApi().storeImageDailyTaskRs),
    );
    request.headers['Content-Type'] = "application/json";
    request.headers['Authorization'] = 'bearer $token';
    request.fields['trans_dtsc_id'] = data['trans_dtsc_id'].toString();
    request.files.add(
        await http.MultipartFile.fromPath('attachment', data['attachment']));

    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 500) {
      await EasyLoading.dismiss();
      SnackbarWidget().getSnackbar(
          'Alert!', 'Server error, please contact the administrator', 'error');
    }

    return respStr;
  }

  Future<dynamic> deleteImageRs(token, id) async {
    final response = await http.delete(
      Uri.parse('${UrlApi().deleteImageDailyTaskRs}/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
  // end road sweeper

  // manual sweeper
  Future<List<DataAttachmentScModel>> getImageMs(token, id) async {
    final response = await http.get(
      Uri.parse('${UrlApi().getImageWhereDailyTaskMs}/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var responseBody = attachmentScModelFromJson(response.body).data;

    return responseBody;
  }

  Future<dynamic> storeImageMs(token, data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(UrlApi().storeImageDailyTaskMs),
    );
    request.headers['Content-Type'] = "application/json";
    request.headers['Authorization'] = 'bearer $token';
    request.fields['trans_dtsc_id'] = data['trans_dtsc_id'].toString();
    request.files.add(
        await http.MultipartFile.fromPath('attachment', data['attachment']));

    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 500) {
      await EasyLoading.dismiss();
      SnackbarWidget().getSnackbar(
          'Alert!', 'Server error, please contact the administrator', 'error');
    }

    return respStr;
  }

  Future<dynamic> deleteImageMs(token, id) async {
    final response = await http.delete(
      Uri.parse('${UrlApi().deleteImageDailyTaskMs}/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
  // end manual sweeper
}
