import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/ApiConstants.dart';
import '../model/apiresponsemodel/PatientDetailsResponse.dart';
import '../model/apiresponsemodel/SendOTPResponse.dart';
import '../model/apiresponsemodel/VerifyOTPResponse.dart';


class ApiService {

  Future<SendOTPResponse?> sendOTP(String phoneNumber, String deviceID) async {
    final url =
        Uri.parse('https://saaol.org/saaolnewapp/api/send-otps/$deviceID');
    final body = {
      'mobile': phoneNumber,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return SendOTPResponse.fromJson(jsonResponse);
      } else {
        print('Failed to send OTP: ${response.statusCode}');
        print('Response body: ${response.body}'); // Add this to debug
        return null;
      }
    } catch (error) {
      print('Error sending OTP: $error');
      return null;
    }
  }

  Future<VerifyOTPResponse?> verifyOTP(String mobile, String otp, BuildContext context) async {
    final url = Uri.parse('https://saaol.org/saaolnewapp/api/verify');
    final body = {
      'mobile': mobile,
      'otp': otp,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final VerifyOTPResponse verifyOTPResponse = VerifyOTPResponse.fromJson(jsonResponse);
        print('Status: ${verifyOTPResponse.success}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonResponse['message'] ?? 'Mobile number verified successfully.'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        return verifyOTPResponse;
      } else {
        print('Failed to verify OTP. Status Code: ${response.statusCode}');
        // Show error message in SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to verify OTP. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );

        return null;
      }
    } catch (error) {
      String errorMessage = 'Error verifying OTP. Please try again.';
      if (error is TimeoutException) {
        print('Request timed out: $error');
        errorMessage = 'Request timed out. Please check your connection.';
      } else if (error is SocketException) {
        print('Network error: $error');
        errorMessage = 'Network error. Please check your internet connection.';
      }
      print(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }


  /*Future<VerifyOTPResponse?> verifyOTP(String mobile, String otp) async {
    final url = Uri.parse('https://saaol.org/saaolnewapp/api/verify');
    final body = {
      'mobile': mobile,
      'otp': otp,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final VerifyOTPResponse verifyOTPResponse = VerifyOTPResponse.fromJson(jsonResponse);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('UserToken', verifyOTPResponse.success.toString());
        print('Status: ${verifyOTPResponse.success}');
        return verifyOTPResponse;
      } else {
        print('Failed to verify OTP. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      if (error is TimeoutException) {
        print('Request timed out: $error');
      } else if (error is SocketException) {
        print('Network error: $error');
      } else {
        print('Error to verify OTP: $error');
      }
      return null;
    }
  }*/

  Future<void> savePatientDetails(PatientDetailsResponse response) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (response.data != null && response.data!.isNotEmpty) {
      final data = response.data!.first;
      await preferences.setString('pmId', data.pmId.toString());
      await preferences.setString('patientUniqueID', data.patientUniqueId.toString());
      print('Patient ID: ${data.pmId}');
      await preferences.setString('PatientFirstName', data.pmFirstName.toString());
      await preferences.setString(
          'PatientLastName', data.pmLastName.toString());
      await preferences.setString(
          'PatientMiddleName', data.pmMiddleName.toString());
      await preferences.setString('PatientGender', data.pmGender.toString());
      print('Patient gender: ${data.pmGender}');
      await preferences.setString('PatientDob', data.pmDob.toString());
      await preferences.setString('PatientContact', data.pmContactNo.toString());
      await preferences.setString('PatientSalutation', data.pmSalutation.toString());
      await preferences.setString('patientEmail', data.pmEmail.toString());
      if (data.patientUniqueId != null) {
        await preferences.setString('patientUniqueId', data.patientUniqueId!);
        print('Patient Unique ID saved: ${data.patientUniqueId}');
      } else {
        print('Patient Unique ID is null.');
      }

      if (data.pmRefId != null) {
        await preferences.setString('pmRefId', data.pmRefId!);
        print('PM Ref ID saved: ${data.pmRefId}');
      } else {
        print('PM Ref ID is null.');
      }

      if (data.pmFirstName != null) {
        await preferences.setString('pmFirstName', data.pmFirstName!);
        print('PM First Name saved: ${data.pmFirstName}');
      }
    } else {
      print('No patient data found to save.');
    }
  }

  Future<PatientDetailsResponse?> verifyPatient(String contact_no) async {
    final url = Uri.parse('https://crm.saaol.com/app/api/patient');
    final body = {
      'contact_no': contact_no,
    };
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'jitmVvGDZaVfCNBX9POHbJOQQyZY5qD8',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final PatientDetailsResponse patientDetailsResponse = PatientDetailsResponse.fromJson(jsonResponse);
        await savePatientDetails(patientDetailsResponse);
        print('Status: ${patientDetailsResponse.data!.first.pmId.toString()}');
        return patientDetailsResponse;
      } else {
        print('Failed to verify Patient. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      if (error is TimeoutException) {
        print('Request timed out: $error');
      } else if (error is SocketException) {
        print('Network error: $error');
      } else {
        print('Error to verify OTP: $error');
      }
      return null;
    }
  }

  Future<bool> sendCallRequest({
    required int userId,
    required String mobileNumber,
    required String emailId,
  }) async {
    const String apiUrl = "https://saaol.org/saaolnewapp/api/call-request/store";
    Map<String, dynamic> requestData = {
      "user_id": userId,
      "mobile_number": mobileNumber,
      "email_id": emailId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        print("Success: ${response.body}");
        return true; // Request was successful
      } else {
        print("Failed: ${response.statusCode} - ${response.body}");
        return false; // Request failed
      }
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }
}
