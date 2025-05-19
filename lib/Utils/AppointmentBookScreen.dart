import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:saaolapp/data/model/requestmodel/AppointmentDetails.dart';
import 'package:saaolapp/data/network/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/PatientAppointmentResponseData.dart';
import '../data/network/BaseApiService.dart';
import 'AppointmentDetailsScreen.dart';
import 'OnlineAppointmentScreen.dart';
import 'StatesData.dart';


class PatientAppointmentScreen extends StatefulWidget {
  final int defaultTabIndex;
  const PatientAppointmentScreen({super.key,this.defaultTabIndex = 0});

  @override
  State<PatientAppointmentScreen> createState() => _PatientAppointmentScreenState();
}

class _PatientAppointmentScreenState extends State<PatientAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.defaultTabIndex,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color:AppColors.primaryColor,size:20,),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'My Appointments',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color:AppColors.primaryColor,
            ),
          ),
          bottom:  const TabBar(
            indicatorWeight:4,
            indicatorColor: AppColors.primaryColor,
            indicatorPadding: EdgeInsets.all(5),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.primaryColor,
            labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'FontPoppins',
                color: AppColors.primaryColor),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'FontPoppins',
                color: AppColors.primaryColor),
            dragStartBehavior: DragStartBehavior.start,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Online Appointment",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                  ),
                ),
              ),
              Tab(
                child: Text("Offline Appointment",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FontPoppins',
                    ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            OnlineAppointmentScreen(),
            AppointmentBookScreen()
          ],
        ),
      ),
    );
  }
}

class AppointmentBookScreen extends StatefulWidget {
  const AppointmentBookScreen({super.key});

  @override
  State<AppointmentBookScreen> createState() => _AppointmentBookScreenState();
}

class _AppointmentBookScreenState extends State<AppointmentBookScreen> {
  int initialLabelIndex = 0; // 0 = Upcoming, 1 = Completed, 2 = Cancelled
  String patientName = '';
  String patientEmail = '';
  String patientMobile = '';
  String appointmentType= '';
  String appointmentDate= '';
  String appointmentTime= '';
  String appointmentLocation= '';
  String getPatientID = '';
  bool isLoading = false;
  String? errorMessage;
  List<Data> appointments = [];
  List<AppointmentDetails> appointments1 = [];

  @override
  void initState() {
    super.initState();
    _loadPatientID();
    _loadAppointments();
  }

  Future<void> _loadPatientID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = sharedPreferences.getString('pmId') ?? '';
      patientName = sharedPreferences.getString(ApiConstants.APPOINTMENT_NAME) ?? '';
      patientEmail = sharedPreferences.getString(ApiConstants.APPOINTMENT_EMAIL) ?? '';
      patientMobile = sharedPreferences.getString(ApiConstants.APPOINTMENT_PHONE) ?? '';
      appointmentType = sharedPreferences.getString(ApiConstants.APPOINTMENT_TYPE) ?? '';
      appointmentDate = sharedPreferences.getString(ApiConstants.APPOINTMENT_DATE) ?? '';
      appointmentTime = sharedPreferences.getString(ApiConstants.APPOINTMENT_TIME) ?? '';
      appointmentLocation = sharedPreferences.getString(ApiConstants.APPOINTMENT_LOCATION) ?? '';
    });

    print('PatientID:-->$getPatientID');
    print('OfflineAppointmentLocation-->$appointmentLocation');
    print('OfflineAppointmentDate-->$appointmentDate');

    if (patientMobile.isNotEmpty) {
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
      await ApiService().verifyPatient(patientMobile);
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
    if (getPatientID == null || getPatientID.isEmpty) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final response =
      await BaseApiService().patientAppointmentRecord(getPatientID);
      setState(() {
        appointments = response.data
            ?.where(
                (appointment) => appointment.pamAppointmentCategory == "1")
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
    List<String> storedList = prefs.getStringList('appointments') ?? [];
    List<AppointmentDetails> tempList = storedList.map((item) {
      final Map<String, dynamic> jsonData = jsonDecode(item);
      return AppointmentDetails.fromJson(jsonData);
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
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
          child: CircularProgressIndicator()) // Show loader while fetching
          : errorMessage != null && appointmentType == "1" && appointmentLocation.isNotEmpty?
          ListView.builder(
        itemCount: appointments1.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final appointment = appointments1[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical:5, horizontal:10),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius:40,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      child: const Icon(Icons.check_circle, color: Colors.green, size:45),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Your appointment request has been accepted",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Our team will contact you shortly.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const Divider(height: 25, thickness: 1, color: AppColors.primaryColor),
                    _iconInfoRow(Icons.person, "Name", appointment.patientName),
                    _iconInfoRow(Icons.phone, "Mobile", appointment.patientMobile),
                    _iconInfoRow(Icons.local_hospital, "Type", "Offline"),
                    _iconInfoRow(Icons.calendar_today, "Date & Time", '${appointment.appointmentDate}, ${appointment.appointmentTime}'),
                    _iconInfoRow(Icons.location_on, "Center", appointment.appointmentLocation),
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
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    "No Offline Appointments Found!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:13,
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
                      fontSize:11,
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
        itemCount:appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute(
                builder: (context) => AppointmentDetailScreen(
                    appointmentCategory:appointment.pamAppointmentCategory.toString(),
                    appointmentDate:appointment.pamAppDate.toString(),
                    appointmentTime:appointment.pamAppTime.toString(),
                    appointmentDuration:appointment.pamAppointmentDuration.toString(),
                    patientID: getPatientID,appointmentID:appointment.pamId.toString()),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 10),
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
                                    5,(index) => const Icon(
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
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: 'Call doctor');
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.primaryColor),
                          const SizedBox(width: 5),
                          Text(appointment.pamAppDate
                              .toString(),
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
                            _convertTo12HourFormat(appointment.pamAppTime
                                .toString()),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => StatesData(
                                  patientID: getPatientID),
                            ),
                          );
                        },
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
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: 'Cancel appointment');
                            },
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
                                    color:
                                    AppColors.primaryColor)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: 'Reschedule appointment');
                            },
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
            ),
          );
        },
      ),
);
  }
  Widget _iconInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontFamily: 'FontPoppins', fontSize: 13, color: Colors.black),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
