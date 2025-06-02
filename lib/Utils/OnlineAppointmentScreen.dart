import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saaolapp/data/model/apiresponsemodel/PatientAppointmentResponseData.dart';
import 'package:saaolapp/data/model/requestmodel/OnlineAppointmentDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/ApiConstants.dart';
import '../common/app_colors.dart';
import '../data/network/ApiService.dart';
import '../data/network/BaseApiService.dart';


class OnlineAppointmentScreen extends StatefulWidget {
  const OnlineAppointmentScreen({super.key});

  @override
  State<OnlineAppointmentScreen> createState() =>
      _OnlineAppointmentScreenState();
}

class _OnlineAppointmentScreenState extends State<OnlineAppointmentScreen> {
  String? getMobileNumber;
  bool isLoading = false;
  String? errorMessage;
  String? storePatientID;
  String? getPatientID;
  String? getAppointmentType;
  String? getAppointmentName;
  List<Data> appointments = [];
  List<OnlineAppointmentDetails> appointments1 = [];


  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadAppointments();
  }


  void _loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getMobileNumber = sharedPreferences.getString(ApiConstants.APPOINTMENT_PHONE_ONLINE) ?? '';
      getAppointmentName = sharedPreferences.getString(ApiConstants.APPOINTMENT_NAME_ONLINE) ?? '';
      getAppointmentType = sharedPreferences.getString(ApiConstants.APPOINTMENT_TYPE_ONLINE) ?? '';
      //getPatientID = sharedPreferences.getString('pmId') ?? '';
      print('AppointmentPhoneOnline:$getMobileNumber');
      print('AppointmentTypeOnline:$getAppointmentType');
    });

     // Call API once user data is loaded
    if (getMobileNumber != null && getMobileNumber!.isNotEmpty) {
          await _verifyPatient();
    }
  }


  Future<void> _verifyPatient() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final patientResponse =
      await ApiService().verifyPatient(getMobileNumber!);
      if (patientResponse != null && patientResponse.status == true) {
        print("Patient Verified: ${patientResponse.data!.first.pmId}");
        print('Patient Message:${patientResponse.message}');
        getPatientID = patientResponse.data!.first.pmId.toString();
        await _fetchAppointments();
      } else {
        setState(() {
          errorMessage = patientResponse?.message ?? "Unknown error occurred";
          print('ErrorMessage:$errorMessage');
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error verifying patient: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _fetchAppointments() async {
    if (getPatientID == null || getPatientID!.isEmpty) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final response =
      await BaseApiService().patientAppointmentRecord(getPatientID!);
      setState(() {
        appointments = response.data
            ?.where(
                (appointment) => appointment.pamAppointmentCategory == "0")
            .toList() ??
            [];
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching appointments: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList('onlineAppointments') ?? [];
    List<OnlineAppointmentDetails> tempList = storedList.map((item) {
      final Map<String, dynamic> jsonData = jsonDecode(item);
      return OnlineAppointmentDetails.fromJson(jsonData);
    }).toList();

    setState(() {
      appointments1 = tempList;
    });
  }

  String _convertTo12HourFormat(String time24) {
    try {
      final DateTime time = DateFormat("HH:mm").parse(time24);
      return DateFormat("hh:mm a").format(time);
    } catch (e) {
      return time24;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? const Center(
          child: CircularProgressIndicator()) // Show loader while fetching
          : errorMessage != null && getAppointmentType == "0"?
          ListView.builder(
        itemCount: appointments1.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final appointment = appointments1[index];
          return Padding(
            padding: const EdgeInsets.only(left:10,right:10,top:5,bottom:6),
            child: Card(
              color: Colors.white,
              elevation:2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height:300,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      child: const Icon(Icons.check_circle, color: Colors.green, size: 40),
                    ),
                    const SizedBox(height:10),
                    const Text(
                      "Your appointment request has been accepted",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Our team will call you soon.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    const Divider(height:20, thickness: 1, color:AppColors.primaryColor),
                    _infoRow("Name", appointment.patientName),
                    _infoRow("Mobile", appointment.patientMobile),
                    _infoRow("Appointment Type", appointment.appointmentType == "0" ? "Online" : appointment.appointmentType),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : appointments.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 50,
              color: AppColors.primaryDark,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    "No Online Appointments Found",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:14,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Our consultation team will call you soon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:10,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: appointments.length,
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.hardEdge,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return InkWell(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor
                                .withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Image(
                            image: AssetImage(
                                'assets/images/bima_sir.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Dr.Bimal Chhajer',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const Text(
                                'Heart Specialist',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: List.generate(
                                  5,
                                      (index) => const Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.call,
                              color: AppColors.primaryColor),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        Text(
                          appointment.pamAppDate.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        const Spacer(),
                        const Icon(Icons.access_time,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        Text(
                          _convertTo12HourFormat(
                              appointment.pamAppTime.toString()),
                          style: const TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.3,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View Prescription',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.primaryDark),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            AppColors.primaryDark,
                          ),
                          child: const Text('Reschedule',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontSize:12,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize:12,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

