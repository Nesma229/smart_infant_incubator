import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../const/roles.dart';
import '../repository/shared_preferences.dart';

class DioHelper {
  // Future<Map<String, dynamic>?> get(String url,
  //     {Map<String, dynamic>? headers}) async {
  //   try {
  //     final Response response =
  //         await _dio.get(url, options: Options(headers: headers));
  //     log(response.data);
  //     print('from get');

  //     return response.data;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future<Map<String, dynamic>?> post(String url,
      {dynamic data, Map<String, String>? headers}) async {
    final Map<String, String> h = {};

    h['Content-Type'] = 'application/json';
    if (headers != null) {
      h.addAll(headers);
    }
    final String? token = await SharedPrefs.getToken();
    print(token);
    if (token != null) {
      h[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    try {
      final http.Response response =
          await http.post(Uri.parse(url), body: jsonEncode(data), headers: h);
      
      if (response.statusCode == 200) {
        log(response.body);
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error is $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> get(String url,
      {Map<String, String>? headers}) async {
    final Map<String, String> h = {};
    h['Content-Type'] = 'application/json';
    if (headers != null) {
      h.addAll(headers);
    }
    final String? token = await SharedPrefs.getToken();
    print(token);
    if (token != null) {
      h[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    try {
      final http.Response response = await http.get(Uri.parse(url), headers: h);
      log('${response.statusCode}');
      log(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error is $e');
      return null;
    }
  }

  Future<bool> delete(String url, {Map<String, String>? headers}) async {
    final Map<String, String> h = {};
    h['Content-Type'] = 'application/json';
    if (headers != null) {
      h.addAll(headers);
    }
    final String? token = await SharedPrefs.getToken();

    if (token != null) {
      h[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    try {
      final http.Response response =
          await http.delete(Uri.parse(url), headers: h);
      log('${response.statusCode}');

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error is $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> put(String url,
      {Map<String, String>? headers, dynamic data}) async {
    final Map<String, String> h = {};
    h['Content-Type'] = 'application/json';
    if (headers != null) {
      h.addAll(headers);
    }
    final String? token = await SharedPrefs.getToken();

    if (token != null) {
      h[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    try {
      final http.Response response =
          await http.put(Uri.parse(url), body: jsonEncode(data), headers: h);
      log('${response.statusCode}');

      if (response.statusCode == 204) {
        log(response.body);
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error is $e');
      return null;
    }
  }

  Future<List?> getList(String url, {Map<String, String>? headers}) async {
    try {
      final Map<String, String> h = {};
      h['Content-Type'] = 'application/json';
      if (headers != null) {
        h.addAll(headers);
      }
      final String? token = await SharedPrefs.getToken();

      if (token != null) {
        h[HttpHeaders.authorizationHeader] = "Bearer $token";
      }

      final http.Response response = await http.get(Uri.parse(url), headers: h);
      print(response.reasonPhrase);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error is $e');
      return null;
    }
  }
}
