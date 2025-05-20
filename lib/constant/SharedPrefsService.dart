import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Save any value
  static Future<void> saveString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  // Get any value
  static Future<String> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  // Example: load appointment details
  static Future<Map<String, String>> loadAppointmentDetails() async {
    final prefs = await _prefs;
    return {
      'pmId': prefs.getString('pmId') ?? '',
      'GoogleUserID': prefs.getString('GoogleUserID') ?? '',
      'GoogleUserName': prefs.getString('GoogleUserName') ?? '',
      'GoogleUserEmail': prefs.getString('GoogleUserEmail') ?? '',
      'patientUniqueID': prefs.getString('patientUniqueID') ?? '',
      'mobile': prefs.getString('user_mobile') ?? '',
      'email': prefs.getString('user_email') ?? '',
      'userId': prefs.getString('user_id') ?? '',
      'tcmId': prefs.getString('tcm_id') ?? '',
      'lat': prefs.getString('lat') ?? '',
      'long': prefs.getString('long') ?? '',
      'subLocality': prefs.getString('subLocality') ?? '',
      'locationName': prefs.getString('locationName') ?? '',
      'pincode': prefs.getString('pincode') ?? '',
      'selected_location': prefs.getString('selected_location') ?? '',
      'PatientFirstName': prefs.getString('PatientFirstName') ?? '',
      'appointmentDate': prefs.getString('appointmentDate') ?? '',
      'appointmentTime': prefs.getString('appointmentTime') ?? '',
    };
  }
}
