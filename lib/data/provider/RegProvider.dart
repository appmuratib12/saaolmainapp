/*
import 'package:flutter/material.dart';
import 'package:saaolapp/constant/ApiConstants.dart' show ApiConstants;
import 'package:saaolapp/data/model/requestmodel/RegisterRequestData.dart';
import 'package:saaolapp/data/network/ApiService.dart' show ApiService;
import 'package:shared_preferences/shared_preferences.dart';


class RegProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool loading = false;
  bool isRegistered = false;
  String? errorMessage;
  String mobileNumber = '';


  Future<bool> verifyPatient(String phone) async {
    try {
      final result = await apiService.verifyPatient(phone);
      return result != null;
    } catch (_) {
      return false;
    }
  }

  Future<void> loadMobileNumber() async {
    final prefs = await SharedPreferences.getInstance();
    mobileNumber = prefs.getString(ApiConstants.SINGIN_MOBILENUMBER) ?? '';
    notifyListeners();
  }

  Future<void> registerUser(RegisterRequestData data) async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final response = await apiService.userRegistered(data);
      if (response != null && response.statusCode == 200) {
        isRegistered = true;
      } else {
        errorMessage = 'Registration failed';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> saveUser(RegisterRequestData request) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiConstants.USER_NAME,request.name ?? '');
    await prefs.setString(ApiConstants.USER_EMAIL, request.email ?? '');
    await prefs.setString(ApiConstants.USER_PASSWORD, request.password ?? '');
    await prefs.setString(ApiConstants.USER_MOBILE, request.mobile ?? '');
    await prefs.setString(ApiConstants.USER_MOBILE_NUMBER, request.mobile ?? '');
    await prefs.setBool('isRegistered', true);
    await prefs.setBool(ApiConstants.IS_LOGIN, true);
  }
}
*/
