import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineGalleryResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineHeartVideoResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineNewsCategoriesResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineNewsResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazinePostsResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineSliderResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineTalkResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineYearResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineZeroOilResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/ReviewRatingResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/YoutubeResponse.dart';
import '../../constant/ApiConstants.dart';
import '../model/apiresponsemodel/AccessRiskQuestionsResponse.dart';
import '../model/apiresponsemodel/AppointmentCentersResponse.dart';
import '../model/apiresponsemodel/AppointmentLocationResponse.dart';
import '../model/apiresponsemodel/AvailableAppointmentDateResponse.dart';
import '../model/apiresponsemodel/BlogsResponseData.dart';
import '../model/apiresponsemodel/CenterCitiesResponse.dart';
import '../model/apiresponsemodel/CenterDetailsResponse.dart';
import '../model/apiresponsemodel/CentersResponseData.dart';
import '../model/apiresponsemodel/CountriesResponse.dart';
import '../model/apiresponsemodel/DiseaseResponseData.dart';
import '../model/apiresponsemodel/FaqsResponse.dart';
import '../model/apiresponsemodel/NearestCenterResponseData.dart';
import '../model/apiresponsemodel/NotificationResponse.dart';
import '../model/apiresponsemodel/OverviewItemResponse.dart';
import '../model/apiresponsemodel/PatientAppointmentResponseData.dart';
import '../model/apiresponsemodel/PatientInstructionsResponse.dart';
import '../model/apiresponsemodel/PrescriptionResponse.dart';
import '../model/apiresponsemodel/PrivacyPoliciesResponse.dart';
import '../model/apiresponsemodel/SafetyCircleValuesResponse.dart';
import '../model/apiresponsemodel/StatesResponse.dart';
import '../model/apiresponsemodel/StatesResponseData.dart';
import '../model/apiresponsemodel/TermsAndConditionResponse.dart';
import '../model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../model/apiresponsemodel/TreatmentsResponseData.dart';
import '../model/apiresponsemodel/WebinarResponseData.dart';
import '../model/apiresponsemodel/WellnessCenterResponse.dart';
import '../model/apiresponsemodel/ZeroOilHealthyFoodResponseData.dart';
import '../model/apiresponsemodel/ZeroOilRecipeResponseData.dart';
import '../model/apiresponsemodel/overviewsResponse.dart';


class BaseApiService {

  Future<StatesResponseData> getStatesData() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}states'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return StatesResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<DiseaseResponseData> getDiseaseData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}diseases'), // Base URL + endpoint
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return DiseaseResponseData.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<TreatmentsDetailResponseData> getTreatmentDetailsData(
      String id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}treatment/$id'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return TreatmentsDetailResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<ZeroOilRecipeResponseData> getZeroOilRecipeData() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}zeroil-recipes/14'),
      // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return ZeroOilRecipeResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<NotificationResponse> getNotificationData() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}notifications'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return NotificationResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<WellnessCenterResponse> getWellnessData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}wellness'), // Base URL + endpoint
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return WellnessCenterResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<ZeroOilHealthyFoodResponseData> getZeroOilHealthyData() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}healthyfood/14'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return ZeroOilHealthyFoodResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<TreatmentsResponseData> getTreatmentsData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}treatments'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return TreatmentsResponseData.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<void> uploadPrescription(File file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}prescriptions'));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // The key name expected by the API
        file.path,
        filename: basename(file.path),
      ),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'API-KEY': ApiConstants.apiKey, // Replace with your actual API key
    });

    var response = await request.send();
    if (response.statusCode == 201) {
      print('File uploaded successfully.');
    } else {
      print('Failed to upload file. Status code: ${response.statusCode}');
    }
  }

  Future<CentersResponseData> getCenterData(String centerName) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.org/saaolapp/api/search-state?center_name=$centerName'),
        headers: {
            'Content-Type': 'application/json',
            'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
          },
      );

      if (response.statusCode == 202) {
        final result = json.decode(response.body);
        return CentersResponseData.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }



  Future<CentersResponseData> getStatesData2(String centerName) async {
    final Uri uri = Uri.parse('https://saaol.org/saaolapp/api/search-state')
        .replace(queryParameters: {
      'center_name': centerName, // Add the query parameter
    });
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );

    if (response.statusCode == 202) {
      final result = json.decode(response.body);
      return CentersResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<PatientInstructionsResponse> patientInstructionsData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}inst'), // Base URL + endpoint
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return PatientInstructionsResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<BlogsResponseData> blogsData(String category) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.org/saaolapp/api/blogs/category/$category'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return BlogsResponseData.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }



  Future<WebinarResponseData> getWebinarData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}webinars'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return WebinarResponseData.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<PatientAppointmentResponseData> patientAppointmentRecord(String patientID) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.crmBaseUrl}patient/appointment/$patientID'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return PatientAppointmentResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }



  Future<CentersResponseData> getCentersRecord(String centerName) async {
    final String url = 'https://saaol.org/saaolapp/api/search-state?center_name=$centerName';
    final response = await http.get(
      Uri.parse(url), // Use the complete URL
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 202) {
      final result = json.decode(response.body); // Decode the JSON response
      return CentersResponseData.fromJson(
          result); // Convert the response to your data model
    } else {
      // Handle the error if the request fails
      throw Exception('Failed to load data');
    }
  }


  Future<AppointmentLocationResponse> getAppointmentLocation() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.crmBaseUrl}availability/location/offline'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return AppointmentLocationResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<AppointmentCentersResponse> getCenterLocation(String stateName) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.crmBaseUrl}availability/location/offline/state/$stateName'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return AppointmentCentersResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }




  Future<AvailableAppointmentDateResponse> getAvailableAppointmentDate(String id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.crmBaseUrl}availability/hospital/$id'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return AvailableAppointmentDateResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<PrescriptionResponse> getPatientPrescription(String patientID) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.crmBaseUrl}prescription/patient/$patientID'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return PrescriptionResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SafetyCircleValuesResponse> getSafetyCircleZoneValues(String tcmID) async {
    final response = await http.get(
      Uri.parse('https://crm.saaol.com/app/api/haps_safety_circle/$tcmID'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return SafetyCircleValuesResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }




  Future<AccessRiskQuestionsResponse> getRiskQuestions() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}accessriskquestions'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return AccessRiskQuestionsResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }



  Future<CountriesResponse> getCountriesData() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}countries'), // Base URL + endpoint
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return CountriesResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<CenterStatesResponse> getCenterStatesData(String country) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}states/$country'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return CenterStatesResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<CenterCitiesResponse> getCenterCitiesResponse(String city) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}cities/$city'), // Base URL + endpoint
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return CenterCitiesResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }



  Future<CenterDetailsResponse> centerDetailsData(String centerName) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}city-details/$centerName'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return CenterDetailsResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<FaqsResponse> getFaqs() async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.org/saaolapp/api/faqs/active'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      print('Response body:${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return FaqsResponse.fromJson(result);
      } else {
        throw Exception('Failed to load FAQs');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  Future<TermsAndConditionResponse> getTermsAndCondition() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}terms'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      print('Response body:${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return TermsAndConditionResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Terms & Condition');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  Future<PrivacyPoliciesResponse> getPrivacyPolicy() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}policies'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      print('Response body:${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return PrivacyPoliciesResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Privacy & Policies');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }
  Future<OverviewResponse> getOverviewData() async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.org/saaolnewapp/api/overviews'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      print('Response body:${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return OverviewResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Overview');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  Future<OverviewItemResponse> getOverviewItem() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}overview'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      print('Response body:${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return OverviewItemResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Overview Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  Future<NearestCenterResponseData> getNearestCenters({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    final url = Uri.parse(
      'https://saaol.org/saaolapp/api/locations/centers?latitude=$latitude&longitude=$longitude&radius=10',
    );
    final headers = {
      'Content-Type': 'application/json',
      'API-KEY': ApiConstants.apiKey,
    };

    try {
      final response = await http.get(url, headers: headers);
      print("Status Code: ${response.statusCode}");
      print("Near Center Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return NearestCenterResponseData.fromJson(result);

      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }

  }

  Future<ReviewRatingResponse> getReviewRatingData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}reviews/high-rated'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey,
        },
      );
      print('Response body:${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return ReviewRatingResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }


  Future<void> feedback(BuildContext context, String reason, List<File> images) async {
    String apiUrl = 'https://saaol.org/saaolnewapp/api/helpandsupport/store';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll({
        'API-KEY': ApiConstants.apiKey,
        'Content-Type': 'application/json',
      });

      request.fields['reason'] = reason;

      for (var image in images) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image[]',
            image.path,
            filename: basename(image.path),
          ),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print("Response Body: $responseBody"); // Debugging log
      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody);
        String message = jsonResponse['message'] ?? 'Support request submitted successfully';
         SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        );

      } else {
        final jsonResponse = jsonDecode(responseBody);
        String message = jsonResponse['message'] ?? 'Submission failed. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    } on SocketException {
      const SnackBar(
        content: Text('No internet connection. Please check your network.'),
        backgroundColor: Colors.red,
      );

    } on HttpException {
      const SnackBar(
        content: Text('Could not reach the server. Please try again.'),
        backgroundColor: Colors.red,
      );
    } on FormatException {
      const SnackBar(
        content: Text('Invalid response from server. Please try again later.'),
        backgroundColor: Colors.red,
      );

    } catch (e) {
      print("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<YoutubeResponse> getYoutubeData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}youtube'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return YoutubeResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }



  Future<EmagazineYearResponse> getEmagazineData() async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/yearlist'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineYearResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<EmagazineResponse> getEmagazine(String year) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/yeardata?year=$year'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineResponse.fromJson(result);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.',);
    } on HttpException {
      throw Exception('Could not retrieve data. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please contact support.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<EmagazineTalkResponse> getEmagazineTalkData(String year,String month) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/talk?year=$year&month=$month'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineTalkResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Emagazine Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  Future<EmagazineZeroOilResponse> getEmagazineZeroOilData(String year,String month) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/zeroil?year=$year&month_number=$month'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineZeroOilResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Emagazine Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }
  Future<EmagazineHeartVideoResponse> getEmagazineHeartVideoData(String year,String month) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/heart?year=$year&month_number=$month'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineHeartVideoResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Emagazine Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  Future<EmagazinePostsResponse> getEmagazinePostData() async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/blogs'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazinePostsResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Emagazine Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }


  Future<EmagazineNewsCategoriesResponse> getNewsCategoriesData() async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/news-categories'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineNewsCategoriesResponse.fromJson(result);
      } else {
        throw Exception('Failed to load news categories Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }
  Future<EmagazineNewsResponse> getEmagazineNews(String id) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/newslist/$id'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineNewsResponse.fromJson(result);
      } else {
        throw Exception('Failed to load news categories Item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }


  Future<EmagazineSliderResponse> getEmagazineSliderData(String year,String month) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/sliders?year=$year&month=$month'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineSliderResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Emagazine slider item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }


  Future<EmagazineGalleryResponse> getEmagazineGalleryData(String year,String month) async {
    try {
      final response = await http.get(
        Uri.parse('https://saaol.com/emagzine/api/gallerys?year=$year&month=$month'),
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': ApiConstants.apiKey
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return EmagazineGalleryResponse.fromJson(result);
      } else {
        throw Exception('Failed to load Emagazine gallery item');
      }
    } catch (e) {
      throw Exception('Error: $e'); // Catch network issues
    }
  }

  /*Future<void> FirebaseMessage(String title, String subtitle) async {
    print('hghghghgh$title');
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    try {
      final body = {
        "message": {
          "token": deviceToken,
          "notification": {
            "title": title,
            "body": subtitle,
            "image":
            "https://saaol.com/assets/images/home/dr-bimal-img.jpg" // URL of the image
          },
          "android": {
            "notification": {
              "sound": "mayanktone",
              "channel_id": "custom_channel_id",
              "image": "https://saaol.com/assets/images/home/dr-bimal-img.jpg"
            }
          },
          "apns": {
            "payload": {
              "aps": {"sound": "mayanktone.mp3", "mutable-content": 1}
            },
            "fcm_options": {
              "image": "https://saaol.com/assets/images/home/dr-bimal-img.jpg"
            }
          },
          "data": {
            "screen": "second",
            "title": title,
            "body": subtitle,
            "image":
            "https://saaol.com/assets/images/home/dr-bimal-img.jpg" // Add image in data payload as well
          },
        }
      };

      const projectID ='saaolapp-4918b';
      final get = get_server_key();
      String token22222 = await get.server_token();
      log('bearerToken: $token22222');
      if (token22222 == null) return;

      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/$projectID/messages:send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token22222'
        },
        body: jsonEncode(body),
      );

      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }*/
}
