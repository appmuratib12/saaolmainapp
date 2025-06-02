import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:saaolapp/data/model/apiresponsemodel/GoogleExistingUserResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/GoogleUserResponse.dart';
import 'package:saaolapp/responsemodel/ProfileUpdateResponse.dart';
import '../../constant/ApiConstants.dart';
import '../model/requestmodel/AccessRiskAnswerRequest.dart';
import '../model/requestmodel/AddMemberRequest.dart';
import '../model/requestmodel/RegisterRequestData.dart';
import 'Helper.dart';

class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  String? errorMessage;
  GoogleUserResponse? googleUserResponse;
  GoogleExistingUserResponse? googleExistingUserResponse;
  //late Future<List<NotificationData>> _notifications;
 // dynamic notificationLength = 0;
  //NotificationDatabase databaseHelper = NotificationDatabase.instance;

  //Future<List<NotificationData>> get notifications => _notifications;
  Future<void> postUserRegisterRequest(
      RegisterRequestData signupRegistration) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      http.Response response = (await userRegistered(signupRegistration))!;

      if (response.statusCode == 200) {
        final ProfileUpdateResponse profileUpdateResponse =
            ProfileUpdateResponse.fromJson(jsonDecode(response.body));
        //SharedPreferences preferences = await SharedPreferences.getInstance();
        //await preferences.setString(ApiConstants.USER_ID,profileUpdateResponse.data!.id.toString());
        //await preferences.setString('isRegistered',profileUpdateResponse.status.toString());
        print('Status:${profileUpdateResponse.status},Message:${profileUpdateResponse.message}');
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

  /*void notificationData() async {
    _notifications = databaseHelper.fetchNotifications("0");
    final lsit = await _notifications;
    notificationLength = lsit.length;
    notifyListeners();
  }*/

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
    required String image, // image URL
  }) async {
    loading = true;
    notifyListeners();

    final url = Uri.parse('${ApiConstants.baseUrl}auth/googles');

    try {
      final response = await http.get(Uri.parse(image));
      final documentDirectory = await getTemporaryDirectory();
      final filePath = path.join(documentDirectory.path, 'profile.jpg');
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'API-KEY': ApiConstants.apiKey,
        })
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['google_id'] = googleId
        ..fields['token'] = token
        ..files.add(await http.MultipartFile.fromPath('image', file.path));

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);
      print('Raw response body: ${res.body}');

      if (res.statusCode == 201) {
        final json = jsonDecode(res.body);
        googleUserResponse = GoogleUserResponse.fromJson(json);
        print('Google user data posted successfully.');
      } else if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        googleExistingUserResponse = GoogleExistingUserResponse.fromJson(json);
        print('Google Existing user data posted successfully.');
      } else {
        throw Exception('Failed to send user data: ${res.statusCode}');
      }
    } catch (e) {
      print('Error sending Google user data: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
