import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/data/model/requestmodel/AppointmentDetails.dart';
import 'package:saaolapp/data/network/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';


class AppointmentConfirmScreen extends StatefulWidget {
  final String centerID;
  final String centerLocationName;
  final String appointmentDate;
  final String saveTimeValue;
  final String phone;
  final String countryCode;

  const AppointmentConfirmScreen(
      {super.key,
      required this.appointmentDate,
      required this.centerID,
      required this.centerLocationName,
      required this.saveTimeValue,required this.phone,required this.countryCode});

  @override
  State<AppointmentConfirmScreen> createState() =>
      _AppointmentConfirmScreenState();
}

class _AppointmentConfirmScreenState extends State<AppointmentConfirmScreen> {
  bool value = false;
  bool checkedValue = true;
  String getUserName = '';
  final TextEditingController patientController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String getEmail = '';
  String getMobileNumber = '';
  String? getLocation;
  String? getSubLocality;
  String? getCountryCode = "IN";
  String? location;
  final ApiService apiService = ApiService();
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String userName = prefs.getString('GoogleUserName') ?? prefs.getString(ApiConstants.USER_NAME) ?? '';
      getUserName = userName;
      String userEmail = prefs.getString('GoogleUserEmail') ?? prefs.getString(ApiConstants.USER_EMAIL) ?? '';
      getEmail = userEmail;
      getMobileNumber = (prefs.getString(ApiConstants.USER_MOBILE_NUMBER) ?? '');
      getCountryCode = (prefs.getString('SelectedCountryCode') ?? '');
      getLocation = (prefs.getString('locationName') ?? '');
      getSubLocality = (prefs.getString('subLocality') ?? '');
      location = '$getLocation $getSubLocality'.trim();
    });
  }

  Future<void> _submitAppointmentRequest() async {
    DialogHelper.showLoadingDialog(context);
    final response = await apiService.offlineCRMApi(
      contactCountryCode:widget.countryCode,
      //contactNo: getMobileNumber,
      contactNo:widget.phone,
      appointmentType: '1',
      address: location.toString(),
      email: getEmail,
      name: getUserName,
      date: widget.appointmentDate,
      centerName: widget.centerID,
      time: widget.saveTimeValue,
    );

    Navigator.of(context).pop();

    if (response != null && response.status == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      AppointmentDetails newAppointment = AppointmentDetails(
        patientName: getUserName,
        patientEmail: getEmail,
        patientMobile:widget.phone,
        appointmentType: '1',
        appointmentDate: widget.appointmentDate,
        appointmentTime: widget.saveTimeValue,
        appointmentLocation: widget.centerLocationName ?? '',
      );

      List<String> storedList = prefs.getStringList('appointments') ?? [];
      storedList.add(jsonEncode(newAppointment.toJson()));
      await prefs.setStringList('appointments', storedList);
      await prefs.setString(ApiConstants.APPOINTMENT_TYPE, '1');
      await prefs.setString(ApiConstants.APPOINTMENT_NAME, getUserName);
      await prefs.setString(ApiConstants.APPOINTMENT_PHONE, widget.phone);
      await prefs.setString(ApiConstants.APPOINTMENT_EMAIL, getEmail);
      await prefs.setString(ApiConstants.APPOINTMENT_LOCATION, widget.centerLocationName);
      await prefs.setString(ApiConstants.APPOINTMENT_DATE, widget.appointmentDate);
      await prefs.setString(ApiConstants.APPOINTMENT_TIME, widget.saveTimeValue);
      DialogHelper.showSuccessDialog(context);
      print('response: ${response.message}');
      print('StorePhone: ${widget.phone}');
    } else {
      _showError("Error: ${response?.message ?? 'Something went wrong'}");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Confirm Appointment',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: Colors.black26,
                child: Container(
                  height:355,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/bima_sir.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Bimal Chhajer',
                                  style: TextStyle(
                                    fontSize:16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'MBBS, MD | Heart Specialist',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white24, thickness: 0.5),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.calendar_today_rounded, size: 16, color: Colors.white70),
                                SizedBox(width: 6),
                                Text(
                                  'Date & Time',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.appointmentDate,
                                  style: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  widget.saveTimeValue,
                                  style: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        const Divider(color: Colors.white24, thickness: 0.5),
                        const SizedBox(height: 10),

                        InfoRow(label: "Name", value: getUserName),
                        InfoRow(label: "Email", value: getEmail),
                        InfoRow(label: "Mobile", value: widget.phone),
                        const InfoRow(label: "Appointment Mode", value: "Offline"),
                        InfoRow(label: "Center Location", value: widget.centerLocationName),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height:10,
              ),
              Padding(padding: const EdgeInsets.all(10),
                  child:SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitAppointmentRequest,
                  icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                  label: const Text(
                    'Confirm Now',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 15,
                      letterSpacing:0.3,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
               ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
