import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maps_nagari/app/data/models/profile_model.dart';
import 'package:maps_nagari/app/data/providers/url_api.dart';

class AuthProvider {
  Future loginStore(username, password) async {
    Map data = {
      'user_name': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(
        UrlApi().login,
      ),
      headers: {
        "Accept": "application/json",
      },
      body: data,
      encoding: Encoding.getByName('utf-8'),
    );

    Map<String, dynamic> responseDecode = jsonDecode(response.body);

    return responseDecode;    
  }

  Future<ProfileModel> getProfile(token) async {
    final response = await http.get(
      Uri.parse(UrlApi().profile),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var responseBody = profileModelFromJson(response.body);

    return responseBody;
  }

  Future<dynamic> logout(token) async {
    final response = await http.get(
      Uri.parse(UrlApi().logout),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
}
