import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import '../common/app_colors.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final String patientID;
  final String appointmentCategory;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentDuration;
  final String appointmentID;

  const AppointmentDetailScreen({super.key, required this.appointmentCategory,
    required this.appointmentDate,required this.appointmentDuration,required this.appointmentTime,
    required this.appointmentID,
    required this.patientID});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {

  final Map<String, String> propertyDetails = {};

  late GoogleMapController mapController;
  late SharedPreferences sharedPreferences;

  final LatLng _center = const LatLng(28.4829, 77.1640); // Example: Dubai
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('Saaol'),
      position: LatLng(28.4829, 77.1640),
      infoWindow: InfoWindow(
          title: 'Saaol',
          snippet:
          'Saaol Heart Centre : EECP Treatment | Best Cardiologist & Heart Specialist in Delhi'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  String getPatientID = '';
  String? patientName;
  String? patientGender;
  String? patientAge;
  String? patientLastName;
  String? patientMiddleName;


  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = sharedPreferences.getString('pmId') ?? '';
      if (getPatientID == widget.patientID && widget.patientID != null && widget.appointmentID != null) {
        patientName = sharedPreferences.getString('PatientFirstName') ?? '';
        patientLastName = sharedPreferences.getString('PatientLastName') ?? '';
        patientAge = sharedPreferences.getString('PatientDob') ?? '';
        patientGender = sharedPreferences.getString('PatientGender') ?? '';
        patientMiddleName = sharedPreferences.getString('PatientMiddleName') ?? '';

      } else {
        patientName = sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
        patientMiddleName = sharedPreferences.getString(ApiConstants.USER_MIDDLE_NAME) ?? '';
        patientLastName = sharedPreferences.getString(ApiConstants.USER_LASTNAME) ?? '';
      }
      // Update propertyDetails map
      propertyDetails['Full Name'] = '${patientName ?? ''} ${patientMiddleName ?? ''} ${patientLastName ?? ''}'.trim();
      propertyDetails['Gender'] = patientGender ?? '';
      propertyDetails['Age'] = patientAge ?? '';

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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Appointment Details',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.2), width: 0.2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/bima_sir.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Bimal Chhajer',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                'MBBS, MD | Cardiology',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              /*SizedBox(
                                height: 36,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),
                                  onPressed: () {
                                    Fluttertoast.showToast(msg: 'click');
                                  },
                                  child: const Text(
                                    'Call now',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Row(
                        children: [
                          const Text(
                            'Appointment Mode:',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 5,
                          ),


                          if (widget.appointmentID.isNotEmpty) ...[
                               Text(
                              widget.appointmentCategory == '1'
                                  ? 'Online'
                                  : widget.appointmentCategory == '0'
                                  ? 'Offline'
                                  : 'Unknown',
                              style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ] else ...[
                            const Text('Online',
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(
                        height:6,
                      ),
                       Row(
                         children: [
                           const Text(
                             'Appointment Duration:',
                             style: TextStyle(
                                 fontFamily: 'FontPoppins',
                                 fontSize: 15,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black),
                           ),
                           const SizedBox(
                             width: 5,
                           ),
                           if (widget.appointmentID.isNotEmpty) ...[
                             Text(
                               getPatientID == widget.patientID
                                   ? '${widget.appointmentDuration.toString()} minutes'
                                   : 'Appointment Duration:${'30'}',
                               style:  const TextStyle(
                                 fontSize: 15,
                                 letterSpacing:0.1,
                                 fontFamily: 'FontPoppins',
                                 fontWeight: FontWeight.w600,
                                 color:AppColors.primaryDark,
                               ),
                             ),
                           ] else ...[
                             const Text('40 minutes',
                               style:  TextStyle(
                                 fontSize: 15,
                                 letterSpacing:0.1,
                                 fontFamily: 'FontPoppins',
                                 fontWeight: FontWeight.w600,
                                 color:AppColors.primaryDark,
                               ),
                             ),
                           ],
                         ],
                       ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Schedule Appointment',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Date & Time',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Expanded(child: Container()),
                          Column(
                            children: [
                              if (widget.appointmentID.isNotEmpty) ...[
                                Text(
                                  getPatientID == widget.patientID
                                      ? widget.appointmentDate.toString()
                                      : '24-11-2024',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ] else ...[
                                Text(widget.appointmentDate,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],

                              const SizedBox(
                                height: 6,
                              ),

                              if (widget.appointmentID.isNotEmpty) ...[
                                Text(
                                  getPatientID == widget.patientID
                                      ? _convertTo12HourFormat(widget.appointmentTime.toString())
                                      : '12:00 PM',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ] else ...[
                                Text(widget.appointmentTime,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Patient Information',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: propertyDetails.entries.map((entry) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    color: Colors.black87),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: AppColors.primaryDark,
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Please reach 10 mins before your\nslot time',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'LOCATION',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'E-3, Kailash Colony Rd, Block E, Kailash Colony, New Delhi, Delhi 110048.',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryColor, width: 0.3)),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 10.0,
                    ),
                    markers: _markers,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
