import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AccessRiskQuestionsResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AppointmentCentersResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AppointmentLocationResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AvailableAppointmentDateResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CRMLabTestResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CenterCitiesResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CenterDetailsResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CountriesResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/DiseaseResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/FaqsResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/LabTestResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/NotificationResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/OverviewItemResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/PatientAppointmentResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/PatientInstructionsResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/PrescriptionResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/StatesResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/TreatmentsResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/WebinarResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/WellnessCenterResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/ZeroOilHealthyFoodResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/ZeroOilRecipeResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/overviewsResponse.dart';
import '../../constant/ApiConstants.dart';
import '../model/apiresponsemodel/BlogsResponseData.dart';
import '../model/apiresponsemodel/CentersResponseData.dart';
import '../model/apiresponsemodel/NearestCenterResponseData.dart';
import '../model/apiresponsemodel/PrivacyPoliciesResponse.dart';
import '../model/apiresponsemodel/SafetyCircleValuesResponse.dart';
import '../model/apiresponsemodel/StatesResponse.dart';
import '../model/apiresponsemodel/StatesResponseData.dart';
import '../model/apiresponsemodel/TermsAndConditionResponse.dart';

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
      throw Exception('Failed to load data');
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

  Future<LabTestResponseData> getLabTestReport() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}labtests'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return LabTestResponseData.fromJson(result);
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
      throw Exception('Failed to load data');
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
    final response = await http.get(
      Uri.parse(
          'https://saaol.org/saaolapp/api/search-state?center_name=$centerName'),
      // Base URL + endpoint
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
      throw Exception('Failed to load data');
    }
  }

  Future<BlogsResponseData> blogsData(String category) async {
    final response = await http.get(
      Uri.parse('https://saaol.org/saaolapp/api/blogs/category/$category'),
      // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return BlogsResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<WebinarResponseData> getWebinarData() async {
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
      throw Exception('Failed to load data');
    }
  }

  Future<PatientAppointmentResponseData> patientAppointmentRecord(
      String patientID) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.crmBaseUrl}patient/appointment/$patientID'),
      // Base URL + endpoint
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
    final String url =
        'https://saaol.org/saaolapp/api/search-state?center_name=$centerName';
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

  Future<NearestCenterResponseData> getNearestCenter(
      String pincode, String radius) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}locations/centers?pincode=$pincode&radius=$radius'),
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return NearestCenterResponseData.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AppointmentLocationResponse> getAppointmentLocation() async {
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
      throw Exception('Failed to load data');
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

  Future<AvailableAppointmentDateResponse> getAvailableAppointmentDate(
      String id) async {
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


  Future<CRMLabTestResponse> getLabTestRecord() async {
    final response = await http.get(
      Uri.parse('https://crm.saaol.com/app/api/investigation'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.crmAPIkEY, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return CRMLabTestResponse.fromJson(result);
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
      throw Exception('Failed to load data');
    }
  }

  Future<CenterStatesResponse> getCenterStatesData(String country) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}states/$country'), // Base URL + endpoint
      headers: {
        'Content-Type': 'application/json',
        'API-KEY': ApiConstants.apiKey, // Custom header for API-KEY
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return CenterStatesResponse.fromJson(result);
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<CenterCitiesResponse> getCenterCitiesResponse(String city) async {
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
      throw Exception('Failed to load data');
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
}
