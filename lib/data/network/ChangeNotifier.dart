import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
}
