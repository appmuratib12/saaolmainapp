import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saaolapp/data/model/apiresponsemodel/AppointmentBookingResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/UserAccountDeleteResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/offlineAppointmentRequestResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/ApiConstants.dart';
import '../model/apiresponsemodel/OnlineAppointmentRequestResponse.dart';
import '../model/apiresponsemodel/PatientDetailsResponse.dart';
import '../model/apiresponsemodel/SendOTPResponse.dart';
import '../model/apiresponsemodel/VerifyOTPResponse.dart';



class ApiService {

  Future<SendOTPResponse?> sendOTP(String phoneNumber, String deviceID) async {
    final url = Uri.parse('https://saaol.org/saaolnewapp/api/send-otps/$deviceID');
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
      final jsonResponse = jsonDecode(response.body);
      print('Response body---> $jsonResponse');
      print('Status code---> ${response.statusCode}');
      if (response.statusCode == 200) {
        return SendOTPResponse.fromJson(jsonResponse);
      } else {
        return SendOTPResponse.fromJson(jsonResponse);
      }
    } catch (error) {
      print('Error sending OTP: $error');
      return null;
    }
  }

  Future<VerifyOTPResponse?> verifyOTP(String mobile, String otp, String device_id,String platform_name, BuildContext context) async {
    final url = Uri.parse('https://saaol.org/saaolnewapp/api/verify-otp');
    final body = {
      'mobile': mobile,
      'otp': otp,
      'device_id':device_id,
      'platform_name':platform_name
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
      print('Response Status OTP: ${response.statusCode}');
      print('Response Body OTP: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final VerifyOTPResponse verifyOTPResponse = VerifyOTPResponse.fromJson(jsonResponse);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(ApiConstants.USER_ID,verifyOTPResponse.id.toString());
        print('STOREID:${verifyOTPResponse.id}');
        print('Status: ${verifyOTPResponse.status}');
        return verifyOTPResponse;
      } else {
        print('Failed to verify OTP. Status Code: ${response.statusCode}');
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

  Future<void> savePatientDetails(PatientDetailsResponse response) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (response.data != null && response.data!.isNotEmpty) {
      final data = response.data!.first;
      await preferences.setString('pmId', data.pmId.toString());
      await preferences.setString('patientUniqueID', data.patientUniqueId.toString());
      print('Patient ID: ${data.pmId}');
      await preferences.setString('PatientFirstName', data.pmFirstName.toString());
      await preferences.setString('PatientLastName', data.pmLastName.toString());
      await preferences.setString('PatientMiddleName', data.pmMiddleName.toString());
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

  Future<Map<String, dynamic>> sendCallRequest({
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

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('CheckCallRequest: $responseData');

      if (response.statusCode == 201 && responseData['success'] == true) {
        return {
          "success": true,
          "message": responseData['message'] ?? "Request sent successfully!"
        };
      } else {
        return {
          "success": false,
          "message": responseData['message'] ?? "Failed to send request."
        };
      }
    } catch (error) {
      print("Error: $error");
      return {
        "success": false,
        "message": "An error occurred. Please try again."
      };
    }
  }




  Future<OnlineAppointmentRequestResponse?> sendLeadData({
    required String contactCountryCode,
    required String contactNo,
    required String appointmentType,
    required String address,
    required String email,
    required String name,
  }) async {
    const String url = "https://crm.saaol.com/app/api/lead/app/request";

    final Map<String, String> requestBody = {
      "contact_country_code": contactCountryCode,
      "contact_no": contactNo,
      "appointment_type": appointmentType,
      "address": address,
      "email": email,
      "name": name,
    };

    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'x-api-key': ApiConstants.crmAPIkEY
        },
        body: jsonEncode(requestBody),
      )
          .timeout(const Duration(seconds: 10));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final OnlineAppointmentRequestResponse onlineAppointmentRequestResponse = OnlineAppointmentRequestResponse.fromJson(jsonResponse);
        print('OnlinAppointmentResponse: $onlineAppointmentRequestResponse');
        return onlineAppointmentRequestResponse;
      }
    } on TimeoutException {
      print("Error: Request timed out. Please try again.");
    } on SocketException {
      print("Error: No internet connection.");
    } on HttpException {
      print("Error: HTTP error occurred.");
    } on FormatException {
      print("Error: Bad response format.");
    } catch (e) {
      print("Error: Something went wrong - $e");
    }
    return null;
  }


  Future<OfflineAppointmentRequestResponse?> offlineCRMApi({
    required String contactCountryCode,
    required String contactNo,
    required String appointmentType,
    required String address,
    required String email,
    required String name,
    required String date,
    required String centerName,
    required String time,
  }) async {
    const String url = "https://crm.saaol.com/app/api/lead/app/request";

    final Map<String, String> requestBody = {
      "contact_country_code": contactCountryCode,
      "contact_no": contactNo,
      "appointment_type": appointmentType,
      "address": address,
      "email": email,
      "name": name,
      "desired_date": date,
      "desired_hm_id": centerName,
      "desired_slot": time,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'x-api-key': ApiConstants.crmAPIkEY
        },
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 10));

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final offlineAppointmentRequestResponse = OfflineAppointmentRequestResponse.fromJson(jsonResponse);
        print('OfflineAppointmentRequestResponse: $offlineAppointmentRequestResponse');
        return offlineAppointmentRequestResponse;
      }
    } on TimeoutException {
      print("Error: Request timed out. Please try again.");
    } on SocketException {
      print("Error: No internet connection.");
    } on HttpException {
      print("Error: HTTP error occurred.");
    } on FormatException {
      print("Error: Bad response format.");
    } catch (e) {
      print("Error: Something went wrong - $e");
    }
    return null;
  }


  Future<AppointmentBookingResponse?> patientAppointmentBookingOnline({
    required String contactCountryCode,
    required String contactNo,
    required String appointmentType,
    required String address,
    required String email,
    required String name,
    required int userID,
  }) async {
    const String url = "http://saaol.org/saaolnewapp/api/appointments";

    final Map<String, dynamic> requestBody = {
      "contactCountryCode": contactCountryCode,
      "contactNo": contactNo,
      "appointmentType": appointmentType,
      "address": address,
      "email": email,
      "name": name,
      "user_id": userID,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'API-KEY': ApiConstants.apiKey
        },
        body: jsonEncode(requestBody),
      );

      print("Appointment Booking Status Code: ${response.statusCode}");
      print("Appointment Booking Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final AppointmentBookingResponse appointmentBookingResponse = AppointmentBookingResponse.fromJson(jsonResponse);
        print('AppointmentBookingRequestResponse:$appointmentBookingResponse');
        return appointmentBookingResponse;
      }
    } on TimeoutException {
      print("Error: Request timed out. Please try again.");
    } on SocketException {
      print("Error: No internet connection.");
    } on HttpException {
      print("Error: HTTP error occurred.");
    } on FormatException {
      print("Error: Bad response format.");
    } catch (e) {
      print("Error: Something went wrong - $e");
    }
    return null;
  }

  Future<AppointmentBookingResponse?> patientOfflineAppointment({
    required String contactCountryCode,
    required String contactNo,
    required String appointmentType,
    required String address,
    required String email,
    required String name,
    required String date,
    required String centerName,
    required String time,
    required int userID,
    required int centerID,
  }) async {
    const String url = "http://saaol.org/saaolnewapp/api/appointments";

    final Map<String, dynamic> requestBody = {
      "contactCountryCode": contactCountryCode,
      "contactNo": contactNo,
      "appointmentType": appointmentType,
      "address": address,
      "email": email,
      "name": name,
      'center_name':centerName,
      'appointment_date':date,
      'appointment_time':time,
      'user_id':userID,
      'center_id':centerID,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'API-KEY': ApiConstants.apiKey
        },
        body: jsonEncode(requestBody),
      );

      print("Offline Appointment Status Code: ${response.statusCode}");
      print("Appointment Booking Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final AppointmentBookingResponse appointmentBookingResponse = AppointmentBookingResponse.fromJson(jsonResponse);
        print('AppointmentBookingRequestResponse:$appointmentBookingResponse');
        return appointmentBookingResponse;
      }
    } on TimeoutException {
      print("Error: Request timed out. Please try again.");
    } on SocketException {
      print("Error: No internet connection.");
    } on HttpException {
      print("Error: HTTP error occurred.");
    } on FormatException {
      print("Error: Bad response format.");
    } catch (e) {
      print("Error: Something went wrong - $e");
    }
    return null;
  }


  Future<UserAccountDeleteResponse?> userAccountDelete({
    required String reason,
    required String userID,
  }) async {
    final String url = "https://saaol.org/saaolnewapp/api/delete-user/$userID";

    final Map<String, dynamic> requestBody = {
      "reason": reason,
    };

    try {
      final http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'API-KEY': ApiConstants.apiKey,
          },
          body: jsonEncode(requestBody));

      print("userAccountDelete → Status Code: ${response.statusCode}");
      print("userAccountDelete → Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final UserAccountDeleteResponse deleteResponse =
        UserAccountDeleteResponse.fromJson(jsonResponse);
        print('UserAccountDeleteResponse: $deleteResponse');
        return deleteResponse;
      } else {
        print("Unexpected status code: ${response.statusCode}");
      }
    } on TimeoutException catch (_) {
      print("Error: Request timed out. Please try again.");
    } on SocketException catch (_) {
      print("Error: No internet connection.");
    } on HttpException catch (_) {
      print("Error: HTTP error occurred.");
    } on FormatException catch (_) {
      print("Error: Bad response format.");
    } catch (e) {
      print("Error: Something went wrong - $e");
    }
    return null;
  }


}
