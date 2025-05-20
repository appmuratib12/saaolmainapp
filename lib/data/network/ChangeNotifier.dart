import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:saaolapp/data/model/apiresponsemodel/GoogleUserResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/ApiConstants.dart';
import '../model/apiresponsemodel/RegisterResponseData.dart';
import '../model/requestmodel/AccessRiskAnswerRequest.dart';
import '../model/requestmodel/AddMemberRequest.dart';
import '../model/requestmodel/RegisterRequestData.dart';
import 'Helper.dart';


class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  String? errorMessage;
  GoogleUserResponse? googleUserResponse;


  Future<void> postUserRegisterRequest(RegisterRequestData signupRegistration) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      http.Response response = (await userRegistered(signupRegistration))!;

      if (response.statusCode == 201) {
        final RegisterResponseData studentRegistrationResponse =
        RegisterResponseData.fromJson(jsonDecode(response.body));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(ApiConstants.USER_ID,
            studentRegistrationResponse.data!.id.toString());
        print('Status:${studentRegistrationResponse.status}');
        isBack = true;
      } else {
        errorMessage ='Failed to register user. Please try again later.';
        isBack = false;
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
      isBack = false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addMemberData(AddMemberRequest memberRequest) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      http.Response response = (await addFamilyMember(memberRequest))!;

      if (response.statusCode == 201) {
        isBack = true;
      } else {
        errorMessage = 'Failed to save family member. Please try again later.';
        isBack = false;
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
      isBack = false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> accessRiskAnswer(AccessRiskAnswerRequest request) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      http.Response response = (await storeAccessRiskAnswer(request))!;

      if (response.statusCode == 200) {
        isBack = true;
      } else {
        errorMessage = 'Failed to store access risk. Please try again later.';
        isBack = false;
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
      isBack = false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> sendGoogleUserData({
    required String name,
    required String email,
    required String googleId,
    required String token,
    required String image,
  }) async {
    loading = true;
    notifyListeners();

    final url = Uri.parse('${ApiConstants.baseUrl}auth/googles'); // Replace with actual endpoint

    final Map<String, dynamic> payload = {
      'name': name,
      'email': email,
      'google_id': googleId,
      'token': token,
      'image': image,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(payload),
      );

      print('Raw response body: ${response.body}');
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        googleUserResponse = GoogleUserResponse.fromJson(json);
        print('Google user data posted successfully.');
      } else {
        throw Exception('Failed to send user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending Google user data: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
