import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/ApiConstants.dart';
import '../model/requestmodel/AccessRiskAnswerRequest.dart';
import '../model/requestmodel/AddMemberRequest.dart';
import '../model/requestmodel/RegisterRequestData.dart';


class Helper {

}

Future<http.Response?> userRegistered(RegisterRequestData register) async {
  http.Response? response;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(ApiConstants.USER_ID);
    if (id == null) {
      log("User ID not found in SharedPreferences.");
      return null;
    }
    response = await http.post(
      Uri.parse('https://saaol.org/saaolnewapp/api/update-profile/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'API-KEY': ApiConstants.apiKey,
      },
      body: jsonEncode(register.toJson()),
    );
  } catch (e) {
    log("Error in userRegistered: $e");
  }
  return response;
}


/*Future<http.Response?> userRegistered(RegisterRequestData register) async {
  http.Response? response;
  String? id;
  try {
    response = await http.post(Uri.parse('https://saaol.org/saaolnewapp/api/update-profile/$id'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'API-KEY': ApiConstants.apiKey,
        },
        body: jsonEncode(register.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}*/


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



