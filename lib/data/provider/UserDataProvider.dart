import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {
  String getPatientID = '';
  String googleUserID = '';
  String googlePatientName = '';
  String googlePatientEmail = '';
  String patientUniqueID = '';
  String getMobileNumber = '';
  String getEmailID = '';
  String getUserID = '';
  String getTcmID = '';
  String getLatitude = '';
  String getLongitude = '';
  String getSubLocality = '';
  String getCity = '';
  String getPinCode = '';
  String savedLocation = '';
  String userName = '';
  String saveDate = '';
  String saveTime = '';

  Future<void> loadSavedAppointment() async {
    final prefs = await SharedPreferences.getInstance();

    getPatientID = prefs.getString('pmId') ?? '';
    googleUserID = prefs.getString('GoogleUserID') ?? '';
    googlePatientName = prefs.getString('GoogleUserName') ?? '';
    googlePatientEmail = prefs.getString('GoogleUserEmail') ?? '';
    patientUniqueID = prefs.getString('patientUniqueID') ?? '';
    getMobileNumber = prefs.getString('user_mobile') ?? '';
    getEmailID = prefs.getString('user_email') ?? '';
    getUserID = prefs.getString('user_id') ?? '';
    getTcmID = prefs.getString('tcm_id') ?? '';
    getLatitude = prefs.getString('lat') ?? '';
    getLongitude = prefs.getString('long') ?? '';
    getSubLocality = prefs.getString('subLocality') ?? '';
    getCity = prefs.getString('locationName') ?? '';
    getPinCode = prefs.getString('pincode') ?? '';
    savedLocation = prefs.getString('selected_location') ?? '';

    if (getPatientID.isNotEmpty) {
      userName = prefs.getString('PatientFirstName') ?? '';
    } else {
      userName = prefs.getString('user_name') ?? '';
    }

    saveDate = prefs.getString('appointmentDate') ?? '';
    saveTime = prefs.getString('appointmentTime') ?? '';

    notifyListeners();
  }
}
