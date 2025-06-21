import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:readmore/readmore.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/Utils/AppointmentBookScreen.dart';
import 'package:saaolapp/Utils/ChooseMemberScreen.dart';
import 'package:saaolapp/data/model/requestmodel/OnlineAppointmentDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../constant/ValidationCons.dart';
import '../constant/text_strings.dart';
import '../data/model/apiresponsemodel/AppointmentCentersResponse.dart';
import '../data/model/apiresponsemodel/AppointmentLocationResponse.dart';
import '../data/model/apiresponsemodel/AvailableAppointmentDateResponse.dart';
import '../data/network/ApiService.dart';
import '../data/network/BaseApiService.dart';
import 'AppointmentConfirmScreen.dart';


class MyAppointmentsScreen extends StatefulWidget {
  final int initialIndex;

  const MyAppointmentsScreen({super.key, this.initialIndex = 0});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  int selectedDateIndex = 0;
  final ScrollController dateScrollController = ScrollController();
  final ScrollController dayScrollController = ScrollController();
  final ApiService _apiService = ApiService();
  List<String> timeArray = ['Morning', 'Afternoon', 'Evening'];


  late int initialLabelIndex2;
  int initialLabelIndex = 0;
  int? selectedIndex;
  int? selectedIndex1 = 0;
  int selectCity = -1;
  int selectCenter = -1;
  String saveTimeValue = '';
  String saveDateValue = '';
  String saveCityName = '';
  String? saveLocationName;
  String consultationFess = '1';
  String saveDate = '';
  String saveDay = '';
  late Future<AppointmentLocationResponse> _appointmentFuture;
  String centerID = '';
  String saveCenterName = '';
  String offlineConsultationFess = '1';
  String getName = '';
  String getEmail = '';
  String? getLastName;
  String getPhone = '';
  String? getLocation;
  String? getSubLocality;
  String? getCountryCode = "IN";
  String? location;
  String getUID = '';
  String userID = '';

  Future<AppointmentCentersResponse>? _futureCenters;
  Future<AvailableAppointmentDateResponse>? _futureAppointments;

  @override
  void initState() {
    super.initState();
    initialLabelIndex2 = widget.initialIndex;
    _loadUserData();
    _futureCenters = BaseApiService().getCenterLocation(saveCityName);
    if (centerID.isNotEmpty) {
      _futureAppointments = BaseApiService().getAvailableAppointmentDate(centerID);
    }
    if (timeArray.isNotEmpty) {
      selectedIndex1 = 0;
      saveTimeValue = timeArray[0];
    }
  }

  int? _selectedIndex;
  String appointmentDate = '';
  String getPatientID = '';
  String _phoneNumber = '';
  late SharedPreferences sharedPreferences;
  bool isFirstCenterSelection = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController patientController = TextEditingController();
  final AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(ApiConstants.USER_ID) ?? '';
      getPatientID = sharedPreferences.getString('pmId') ?? '';
      getUID = sharedPreferences.getString('GoogleUserID') ?? '';
      getUID = sharedPreferences.getString(ApiConstants.IDENTIFIER_TOKEN) ?? '';
      print('GETUID:$getUID');
      if (getPatientID.isNotEmpty) {
        getName = sharedPreferences.getString('PatientFirstName') ?? '';
        getLastName = sharedPreferences.getString('PatientLastName') ?? '';
        getPhone = sharedPreferences.getString('PatientContact') ?? '';
        getEmail = sharedPreferences.getString('patientEmail') ?? '';
        _emailController.text = getEmail.toString();
        _phoneController.text = getPhone.toString();
        String fullName = "${getName?.trim()} ${getLastName?.trim()}"
            .trim(); // Trim to remove extra spaces
        _nameController.text = fullName.toString();
        print('fullname:$fullName');
      } else {
        String userName = sharedPreferences.getString(ApiConstants.APPLE_NAME) ??
            sharedPreferences.getString('GoogleUserName') ??
            sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
        String userEmail = sharedPreferences.getString(ApiConstants.APPLE_EMAIL) ??
            sharedPreferences.getString('GoogleUserEmail') ??
            sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '';
        getName = userName;
        getEmail = userEmail;

       /* String userName = sharedPreferences.getString('GoogleUserName') ?? sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
        String appleName = sharedPreferences.getString(ApiConstants.APPLE_NAME) ?? sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
        getName = userName;
        getName = appleName;
        //getName = sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
        String userEmail = sharedPreferences.getString('GoogleUserEmail') ?? sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '';
        String appleEmail = sharedPreferences.getString(ApiConstants.APPLE_EMAIL) ?? sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '';
        getEmail = userEmail;
        getEmail = appleEmail;*/

        getPhone = sharedPreferences.getString(ApiConstants.USER_MOBILE_NUMBER) ?? '';
        _nameController.text = getName.toString();
        _emailController.text = getEmail.toString();
        _phoneController.text = getPhone.toString();
         print('GetName$getName');

      }
      getLocation = sharedPreferences.getString('locationName') ?? '';
      getSubLocality = sharedPreferences.getString('subLocality') ?? '';
      location = '$getLocation $getSubLocality'.trim();
      _addressController.text = location.toString();
      print('Location: $getLocation, Sub-locality: $getSubLocality');
      getCountryCode = sharedPreferences.getString('SelectedCountryCode') ?? '';
      print('GetSelectedCountryCode:$getCountryCode');
    });
  }


  Future<void> _submitAppointmentRequest() async {
    if (_nameController.text.trim().isEmpty) {
      _showError("Name is required");
      return;
    }
    if (_phoneController.text.trim().isEmpty || _phoneController.text.length < 8) {
      _showError("Please enter a valid phone number");
      return;
    }
    if (_emailController.text.trim().isEmpty || !_emailController.text.contains('@')) {
      _showError("Please enter a valid email");
      return;
    }
    if (_addressController.text.trim().isEmpty) {
      _showError("Address is required");
      return;
    }

    DialogHelper.showLoadingDialog(context);
    final response = await _apiService.sendLeadData(
      contactCountryCode: getCountryCode.toString(),
      contactNo: _phoneController.text,
      appointmentType: '0',
      address: _addressController.text,
      email: _emailController.text,
      name: _nameController.text,
    );

    final response1 = await _apiService.patientAppointmentBookingOnline(
      contactCountryCode: getCountryCode.toString(),
      contactNo: _phoneController.text,
      appointmentType: '0',
      address: _addressController.text,
      email: _emailController.text,
      name: _nameController.text,
      userID: int.parse(userID),
    );

    Navigator.of(context).pop();
    if (response != null && response.status == true && response1 != null && response1.status == 'success') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      OnlineAppointmentDetails newAppointment = OnlineAppointmentDetails(
        patientName:_nameController.text,
        patientMobile:_phoneController.text,
        appointmentType: '0',
      );
      List<String> storedList = prefs.getStringList('onlineAppointments') ?? [];
      storedList.add(jsonEncode(newAppointment.toJson()));
      await prefs.setStringList('onlineAppointments', storedList);
      await prefs.setString(ApiConstants.APPOINTMENT_TYPE_ONLINE, '0');
      await prefs.setString(ApiConstants.APPOINTMENT_NAME_ONLINE, _nameController.text);
      await prefs.setString(ApiConstants.APPOINTMENT_PHONE_ONLINE, _phoneController.text);
      _showSuccessDialog(context);
      print('response: ${response.message}');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${response?.message ?? 'Something went wrong'}"),
          backgroundColor: Colors.red,
        ),
      );
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 100)
                    .animate()
                    .scale(duration: 600.ms),
                const SizedBox(height: 20),
                const Text(
                  textAlign: TextAlign.center,
                  "Appointment request Accepted",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FontPoppins',
                      color: AppColors.primaryColor),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your online appointment request has been successfully submitted.\n"
                  "📞 Our team will contact you soon to confirm appointment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'FontPoppins',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              const PatientAppointmentScreen(defaultTabIndex: 0)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 12),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: Colors.lightBlue.shade50,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('d MMMM y').format(pickedDate); // e.g. 21 April 2025
      setState(() {
        appointmentDate = formattedDate;
        _dateController.text = appointmentDate;
      });
    }
  }

  Future<void> _submitAppointmentRequest1() async {
    if ((getPhone == null || getPhone.isEmpty) &&
        (_phoneController.text.isEmpty)) {
      _showError1("Mobile number is required.");
      return;
    }
    if (getPhone == null || getPhone.isEmpty) {
      getPhone = _phoneController.text.trim();
    }
    if (getEmail == null || getEmail.isEmpty || !getEmail.contains('@')) {
      _showError1("A valid email is required.");
      return;
    }

    if (getName == null || getName.isEmpty) {
      _showError1("Name is required.");
      return;
    }

    if (location == null || location.toString().isEmpty) {
      _showError1("Location is required.");
      return;
    }
    if (saveCityName == null || saveCityName.toString().isEmpty) {
      _showError1("Center location is required.");
      return;
    }
    if (saveCenterName == null || saveCenterName.toString().isEmpty) {
      _showError1("Center name is required.");
      return;
    }

    if (appointmentDate == null || appointmentDate.toString().isEmpty) {
      _showError1("Appointment date is required.");
      return;
    }

    if (saveTimeValue == null || saveTimeValue.toString().isEmpty) {
      _showError1("Appointment time is required.");
      return;
    } else {
      Navigator.push(
          context,
          CupertinoPageRoute(
          builder: (context) =>
          AppointmentConfirmScreen(
            centerID: centerID,
            centerLocationName: saveCenterName,
            appointmentDate: appointmentDate,
            saveTimeValue: saveTimeValue,
            phone:getPhone,
            countryCode:getCountryCode.toString()
          ),
         ),
      );
    }
  }

  void _showError1(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style:const TextStyle(fontWeight:FontWeight.w600,
            fontSize:14,
            color:Colors.white,fontFamily:'FontPoppins'),),
        backgroundColor: Colors.red,
      ),
    );
  }


  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            height: 330,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(250, 30, 149, 195),
                  const Color.fromARGB(200, 30, 149, 195).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/bima_sir.png',
                    height: 220,
                    width: 260,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 245.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.grey[200],
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'Dr.Bimal Chhajer',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'MBBS,MD,(Heart Specialist)',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: 4.5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 18.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 10, top: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ToggleSwitch(
                              minWidth: double.infinity,
                              cornerRadius: 20.0,
                              activeBgColors: const [
                                [AppColors.primaryDark],
                                [AppColors.primaryDark],
                              ],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.blue[100],
                              inactiveFgColor: AppColors.primaryDark,
                              initialLabelIndex: initialLabelIndex2,
                              totalSwitches: 2,
                              labels: const [
                                'Online Appointment',
                                'Offline Appointment',
                              ],
                              customTextStyles: const [
                                TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                ),
                                TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                              radiusStyle: true,
                              onToggle: (index) {
                                setState(() {
                                  initialLabelIndex2 = index!;
                                });
                                print('switched to: $index');
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Visibility(
                                  visible: initialLabelIndex2 == 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12.0),
                                        width:double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Offline Appointment Request",
                                              style: TextStyle(
                                                fontSize:14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'FontPoppins',
                                                letterSpacing:0.2,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(height:10),
                                            const Text('First Name',
                                              style: TextStyle(
                                                fontSize:13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontFamily: 'FontPoppins',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                          /*  Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.blue.withOpacity(0.1)),
                                                borderRadius: BorderRadius.circular(12),
                                                color: Colors.blue[50],
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    patientController.text.isEmpty ? getName.toString() : patientController.text,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'FontPoppins',
                                                      color: patientController.text.isEmpty ? Colors.black54 : Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:AppColors.primaryDark,
                                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                icon: const Icon(Icons.person_add_alt_1, size: 20, color: Colors.white),
                                                label: const Text(
                                                  'Add Member',
                                                  style: TextStyle(
                                                    fontSize:14,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  final selectedPatient = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const SelectMemberScreen(),
                                                    ),
                                                  );
                                                  if (selectedPatient != null) {
                                                    setState(() {
                                                      patientController.text = selectedPatient;
                                                    });
                                                  }
                                                  if (selectedPatient != null) {
                                                    setState(() {
                                                      patientController.text = selectedPatient;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
*/

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.blue.withOpacity(0.1)),
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: Colors.blue[50],
                                                    ),
                                                    child: Text(
                                                      patientController.text.isEmpty ? getName.toString() : patientController.text,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'FontPoppins',
                                                        color: patientController.text.isEmpty ? Colors.black54 : Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  decoration:  BoxDecoration(
                                                    shape:BoxShape.rectangle,
                                                    color: AppColors.primaryDark,
                                                    borderRadius:BorderRadius.circular(12)
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(Icons.person_add_alt_1, color: Colors.white, size: 20),
                                                    onPressed: () async {
                                                      final selectedPatient = await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => const SelectMemberScreen(),
                                                        ),
                                                      );
                                                      if (selectedPatient != null) {
                                                        setState(() {
                                                          patientController.text = selectedPatient;
                                                        });
                                                      }
                                                      if (selectedPatient != null) {
                                                        setState(() {
                                                          patientController.text = selectedPatient;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height:10),
                                            if (getUID.isNotEmpty) ...[
                                              const Text(
                                                'Mobile Number',
                                                style: TextStyle(
                                                  fontSize:13,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'FontPoppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height:10),
                                              IntlPhoneField(
                                                controller: _phoneController,
                                                decoration: InputDecoration(
                                                  hintText: 'Enter mobile number',
                                                  hintStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.1)
                                                    ),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    borderSide:  BorderSide(
                                                      color: Colors.blue.withOpacity(0.1),
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.blue[50],
                                                ),
                                                initialCountryCode: 'IN',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'FontPoppins',
                                                  color: Colors.black,
                                                ),
                                                validator: (phone) {
                                                  if (phone == null || phone.number.isEmpty) {
                                                    return "Please enter a valid mobile number";
                                                  }
                                                  return null;
                                                },
                                                onChanged: (phone) {
                                                  getPhone = phone.completeNumber;
                                                  getCountryCode = phone.countryCode;
                                                  print('Countrycode:$getCountryCode');

                                                },
                                              ),
                                            ],
                                            const SizedBox(height:5),
                                            const Text(
                                              'Available Location of SAAOL Center',
                                              style: TextStyle(
                                                  fontSize:13,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height:10,
                                            ),
                                            SizedBox(
                                              height: 80,
                                              child: FutureBuilder<AppointmentLocationResponse>(
                                                future: BaseApiService().getAppointmentLocation(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (selectCity == -1 && snapshot.data!.data!.isNotEmpty) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback((_) {
                                                        setState(() {
                                                          selectCity =
                                                          0; // Set the first item as selected by default
                                                          saveCityName = snapshot
                                                              .data!.data![0].hmState
                                                              .toString(); // Save the default city name
                                                          _futureCenters =
                                                              BaseApiService()
                                                                  .getCenterLocation(
                                                                  saveCityName);
                                                        });
                                                      });
                                                    }
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: snapshot.data!.data!.length,
                                                      scrollDirection: Axis.horizontal,
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      itemBuilder: (context, index1) {
                                                        bool isSelected = selectCity == index1;
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectCity = index1;
                                                              saveCityName = snapshot.data!.data![index1].hmState.toString();
                                                              _futureCenters = BaseApiService().getCenterLocation(saveCityName);
                                                              //Fluttertoast.showToast(msg: saveCityName.toString());
                                                              print('SelectCity;$selectCity');

                                                            });
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  constraints:
                                                                  const BoxConstraints(
                                                                    minHeight: 80,
                                                                    maxWidth:80,
                                                                  ),
                                                                  width: 80,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: isSelected
                                                                        ? AppColors
                                                                        .primaryDark
                                                                        : Colors
                                                                        .white,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8),
                                                                    border:
                                                                    Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5),
                                                                      width: 0.6,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Image(
                                                                        image: const AssetImage(
                                                                            'assets/icons/kolkata.png'),
                                                                        width: 40,
                                                                        height: 40,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        color: isSelected
                                                                            ? Colors
                                                                            .white
                                                                            : Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height: 5),
                                                                      Text(
                                                                        snapshot
                                                                            .data!
                                                                            .data![
                                                                        index1]
                                                                            .hmState
                                                                            .toString(),
                                                                        textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                        style:
                                                                        TextStyle(
                                                                          fontSize:
                                                                          10,
                                                                          fontFamily:
                                                                          'FontPoppins',
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          color: isSelected
                                                                              ? Colors
                                                                              .white
                                                                              : Colors
                                                                              .black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    final errorMessage = snapshot.error.toString();
                                                    if (errorMessage.contains('No internet connection')) {
                                                      return const Center(
                                                        child:Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.wifi_off_rounded,
                                                              size:30,
                                                              color: Colors.redAccent,
                                                            ),
                                                            Text(
                                                              'No Internet Connection',
                                                              style: TextStyle(
                                                                fontSize:12,
                                                                fontFamily: 'FontPoppins',
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.black87,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Please check your network settings and try again.',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize:11,
                                                                fontFamily: 'FontPoppins',
                                                                color: Colors.black54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return const Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(Icons.error_outline, color: Colors.red, size: 20),
                                                            SizedBox(height:8),
                                                            Text(('No available locations'),
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(fontWeight:FontWeight.w500,
                                                                  fontSize:14,fontFamily:'FontPoppins',color:Colors.red),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  return const Center(child: CircularProgressIndicator());
                                                },
                                              ),
                                            ),


                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                              'Choose the center',
                                              style: TextStyle(
                                                  fontSize:13,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height:10,
                                            ),

                                            SizedBox(
                                              height:65,
                                              child: FutureBuilder<
                                                  AppointmentCentersResponse>(
                                                future: _futureCenters,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                          // Background color for the progress indicator
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              30), // Rounded corners
                                                        ),
                                                        child: const Center(
                                                          child:
                                                          CircularProgressIndicator(
                                                            color: AppColors
                                                                .primaryColor,
                                                            // Custom color
                                                            strokeWidth:
                                                            6, // Set custom stroke width
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    print('Error fetching centers: ${snapshot.error}');
                                                    return const Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.error_outline, color: Colors.red, size: 20),
                                                          SizedBox(height:8),
                                                          Text(('No available center locations'),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(fontWeight:FontWeight.w500,
                                                                fontSize:14,fontFamily:'FontPoppins',color:Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else if (!snapshot.hasData ||
                                                      snapshot.data!.data == null ||
                                                      snapshot.data!.data!.isEmpty) {
                                                    return const Center(child: Text('No Centers available.'));
                                                  } else {
                                                    final centers = snapshot.data!.data!;
                                                    if (isFirstCenterSelection) {
                                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                                        setState(() {
                                                          centerID = centers[0].hmId.toString();
                                                          saveCenterName = centers[0].hmName.toString();
                                                          _futureAppointments = BaseApiService().getAvailableAppointmentDate(centerID);
                                                          isFirstCenterSelection = false;
                                                        });
                                                      });
                                                    }
                                                    return ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: centers.length,
                                                      itemBuilder: (context, index) {
                                                        //bool isSelected = centerID == snapshot.data!.data![index].hmId.toString();
                                                        bool isSelected = centerID == centers[index].hmId.toString();
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              centerID = snapshot.data!.data![index].hmId.toString();
                                                              print('centerID:$centerID');
                                                              saveCenterName = snapshot.data!.data![index].hmName.toString();
                                                              _futureAppointments = BaseApiService().getAvailableAppointmentDate(centerID);

                                                            });
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Container(
                                                                  constraints:
                                                                  const BoxConstraints(
                                                                    minHeight: 50,
                                                                    // Minimum height
                                                                    maxWidth:
                                                                    135, // Max width for text wrapping
                                                                  ),
                                                                  width: 135,
                                                                  // Fixed width for consistent design
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: isSelected
                                                                        ? AppColors
                                                                        .primaryDark
                                                                        : Colors
                                                                        .white,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8),
                                                                    border:
                                                                    Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5),
                                                                      width: 0.6,
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    // Ensures content is centered properly
                                                                    child: Text(
                                                                      centers[index]
                                                                          .hmName
                                                                          .toString(),
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      maxLines: 2,
                                                                      // Prevents overflow by limiting text to 2 lines
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      // Adds "..." if text is too long
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:10,
                                                                        fontFamily:
                                                                        'FontPoppins',
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        color: isSelected
                                                                            ? Colors
                                                                            .white
                                                                            : Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ),

                                            const Row(
                                              children: [
                                                const Text(
                                                  'Choose Appointment Date & Time',
                                                  style: TextStyle(
                                                    fontSize:13,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:5,
                                                ),
                                                Icon(
                                                  Icons.alarm,
                                                  size:15,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height:10,
                                            ),

                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: TextFormField(
                                                    controller: _dateController,
                                                    readOnly: true,
                                                    onTap: () => _selectDate(context),
                                                    decoration: InputDecoration(
                                                      hintText: 'Select Date',
                                                      hintStyle: const TextStyle(
                                                        fontFamily: 'FontPoppins',
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                      suffixIcon: const Icon(Icons.calendar_month, color: AppColors.primaryDark),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.blue[50],
                                                    ),
                                                    style: const TextStyle(
                                                      color: AppColors.primaryColor,
                                                      fontSize: 13,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  flex: 2,
                                                  child: DropdownButtonFormField<String>(
                                                    value: saveTimeValue.isNotEmpty ? saveTimeValue : null,
                                                    items: timeArray.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style:const TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: 'FontPoppins',
                                                            fontWeight: FontWeight.w600,
                                                            color:AppColors.primaryColor,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        saveTimeValue = newValue!;
                                                        //Fluttertoast.showToast(msg: saveTimeValue);
                                                      });
                                                    },
                                                    icon: const Icon(Icons.access_time_rounded, color: AppColors.primaryDark),
                                                    dropdownColor: Colors.white,
                                                    elevation: 3,
                                                    borderRadius: BorderRadius.circular(15),
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.symmetric(vertical:13.0, horizontal: 12.0),
                                                      hintText: 'Select Time',
                                                      hintStyle: const TextStyle(
                                                        fontFamily: 'FontPoppins',
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                        borderSide: const BorderSide(color: Colors.transparent),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                        borderSide: const BorderSide(color: Colors.transparent),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.blue[50],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: initialLabelIndex2 == 0,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Form(
                                        key: _formKey,
                                        autovalidateMode: _autoValidateMode,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Online Appointment Request",
                                              style: TextStyle(
                                                fontSize:14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'FontPoppins',
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            buildTextField(
                                                "First Name",
                                                Icons.person,
                                                _nameController,
                                                "Enter your first name",
                                                validator: ValidationCons().validateName,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                                LengthLimitingTextInputFormatter(50),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            buildTextField(
                                                "Email ID",
                                                   Icons.email,
                                                _emailController,
                                                "Enter your email",
                                                keyboardType: TextInputType.emailAddress,
                                                validator: ValidationCons().validateEmail,
                                                inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(r'[a-zA-Z0-9@._\-+]'),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            const Text(
                                              'Mobile Number',
                                              style: TextStyle(
                                                fontSize:13,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'FontPoppins',
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            IntlPhoneField(
                                              readOnly:false,
                                              controller: _phoneController,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(10),
                                              ],
                                              decoration: InputDecoration(
                                                hintText: 'Enter mobile number',
                                                hintStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        BorderSide.none),
                                                filled: true,
                                                fillColor: Colors.lightBlue[50],
                                              ),
                                              style: const TextStyle(
                                                  fontSize:13,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'FontPoppins',
                                                  color: Colors.black),
                                              initialCountryCode: "IN",
                                              // Default country code (India)
                                              onChanged: (phone) {
                                                _phoneNumber = phone.completeNumber; // Store full number
                                                getCountryCode = phone.countryCode; // Store selected country code
                                                print("Selected Country Code: $getCountryCode");
                                              },
                                              validator: (phone) {
                                                if (phone == null ||
                                                    phone.number.isEmpty) {
                                                  return "Please enter a valid mobile number";
                                                }
                                                return null;
                                              },
                                            ),
                                            buildTextField(
                                              "Address",
                                              Icons.location_on,
                                              _addressController,
                                              "Enter your address",
                                              keyboardType: TextInputType.streetAddress,
                                              validator: ValidationCons().validateAddress,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(r'[a-zA-Z0-9\s,.\-/]'),
                                                ),
                                                LengthLimitingTextInputFormatter(100),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Dr. Bimal Chhajer Biography',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const ReadMoreText(
                                  aboutBimalSir,
                                  trimLines: 2,
                                  colorClickableText: AppColors.primaryColor,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Read More',
                                  trimExpandedText: 'Read Less',
                                  style: TextStyle(
                                    fontSize:12,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors
                                        .black87, // Text style for the main text
                                  ),
                                  moreStyle: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: AppColors
                                        .primaryColor, // Style for the 'Read More/Read Less' text
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryDark,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (initialLabelIndex2 == 0) {
                                        await _submitAppointmentRequest();
                                      } else if (initialLabelIndex2 == 1) {
                                        _submitAppointmentRequest1();

                                       /* showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const CustomProgressIndicator();
                                          },
                                        );
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                AppointmentConfirmScreen(
                                              centerID: centerID,
                                              centerLocationName: saveCenterName,
                                              appointmentDate: appointmentDate,
                                              saveTimeValue: saveTimeValue,

                                            ),
                                          ),
                                        );*/
                                      }
                                    },
                                    child: const Text(
                                      'Book Appointment',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Input Fields
  Widget buildTextField(String label, IconData icon,
      TextEditingController controller, String hintText,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize:13,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'FontPoppins',
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: false,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize:13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                fontFamily: 'FontPoppins'),
            prefixIcon: Icon(icon, color: AppColors.primaryDark),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            filled: true,
            fillColor: Colors.lightBlue[50],
          ),
          validator: validator,
          style: const TextStyle(
              fontSize:13,
              fontWeight: FontWeight.w600,
              fontFamily: 'FontPoppins',
              color: Colors.black),
        ),
      ],
    );
  }
}
