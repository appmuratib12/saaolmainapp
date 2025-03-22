import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/PaymentRecordData.dart';
import 'package:saaoldemo/data/model/requestmodel/AccessRiskAnswerRequest.dart';
import 'package:saaoldemo/data/model/requestmodel/AddMemberRequest.dart';
import 'package:saaoldemo/data/model/requestmodel/PaymentRecordRequest.dart';
import '../model/apiresponsemodel/RegisterResponseData.dart';
import '../model/requestmodel/RegisterRequestData.dart';
import 'Helper.dart';

class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  String? errorMessage;

  /* Future<void> postData(RegisterRequestData register) async {
    loading = true;
    notifyListeners();
    http.Response response = (await userRegister1(register))!;
    if (response.statusCode == 201) {
      final RegisterResponseData registerResponseData =
          RegisterResponseData.fromJson(jsonDecode(response.body));
      print('Response:$registerResponseData');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(
          'StudentId', registerResponseData.data!.id.toString());
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }*/

  Future<void> postUserRegisterRequest(RegisterRequestData signupRegistration) async {
    loading = true;
    errorMessage =
        null; // Reset the error message at the beginning of the request
    notifyListeners();

    try {
      http.Response response = (await userRegistered(signupRegistration))!;

      if (response.statusCode == 201) {
        final RegisterResponseData studentRegistrationResponse = RegisterResponseData.fromJson(jsonDecode(response.body));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(ApiConstants.USER_ID, studentRegistrationResponse.data!.id.toString());
        print('Status:${studentRegistrationResponse.status}');
        isBack = true;
      } else {
        errorMessage = 'Failed to register user. Please try again later.';
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



  Future<void> saveUserPaymentRecord(PaymentRecordRequest paymentRequest) async {
    loading = true;
    errorMessage = null; // Reset the error message at the beginning of the request
    notifyListeners();

    try {
      http.Response response = (await saveUserPayment(paymentRequest))!;
      if (response.statusCode == 201) {
        final PaymentRecordData paymentRecordData = PaymentRecordData.fromJson(jsonDecode(response.body));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(ApiConstants.PAYMENT_ID,paymentRecordData.payment!.txnId!.toString());
        await preferences.setString(ApiConstants.APPOINTMENT_MODE,paymentRecordData.payment!.appointmentMode!.toString());
        await preferences.setString(ApiConstants.TOTAL_AMOUNT,paymentRecordData.payment!.totalAmount!.toString());
        print('Status:${paymentRecordData.message}');
        isBack = true;

      } else {
        errorMessage = 'Failed to save payment. Please try again later.';
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
    errorMessage =
    null; // Reset the error message at the beginning of the request
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
    errorMessage =
    null; // Reset the error message at the beginning of the request
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
