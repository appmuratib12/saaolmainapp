import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:saaoldemo/data/model/requestmodel/AccessRiskAnswerRequest.dart';
import 'package:saaoldemo/data/model/requestmodel/AddMemberRequest.dart';
import 'package:saaoldemo/data/model/requestmodel/PaymentRecordRequest.dart';
import 'package:saaoldemo/data/model/requestmodel/RegisterRequestData.dart';
import '../../constant/ApiConstants.dart';

class Helper {}

Future<http.Response?> userRegistered(RegisterRequestData register) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse('${ApiConstants.baseUrl}register'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(register.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> saveUserPayment(PaymentRecordRequest paymentRequest) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse('${ApiConstants.baseUrl}payments'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(paymentRequest.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}


Future<http.Response?> addFamilyMember(AddMemberRequest memberRequest) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse('${ApiConstants.baseUrl}family'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(memberRequest.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> storeAccessRiskAnswer(AccessRiskAnswerRequest request) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse('${ApiConstants.baseUrl}accessrisk-answer'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(request.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

