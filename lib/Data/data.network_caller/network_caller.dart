import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';

class NetworkCaller {
  final SharedPreferenceController _sharedPreferenceController =
      Get.put(SharedPreferenceController());

  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool islogin = false}) async {
    final String token = _sharedPreferenceController.token ?? '';
    try {
      // log(body.toString());
      final http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {"Content-type": "Application/json", "token": token},
      );

      log(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (!islogin) {
          backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getRequest(String url,
      {Map<String, dynamic>? body}) async {
    final String token = _sharedPreferenceController.token ?? '';

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {"Content-type": "Application/json", "token": token},
      );

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  void backToLogin() {
    _sharedPreferenceController.logout();
    Get.offUntil(
      GetPageRoute(
        page: () => LoginScreen(),
      ),
      (route) => false,
    );
  }
}
