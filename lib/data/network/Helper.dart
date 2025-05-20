import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../constant/ApiConstants.dart';
import '../model/requestmodel/AccessRiskAnswerRequest.dart';
import '../model/requestmodel/AddMemberRequest.dart';
import '../model/requestmodel/RegisterRequestData.dart';


class Helper {

}

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



