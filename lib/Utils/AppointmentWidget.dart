import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/PatientAppointmentResponseData.dart';
import '../data/network/BaseApiService.dart';
import 'AppointmentsScreen.dart';

class AppointmentWidget extends StatefulWidget {
  const AppointmentWidget({super.key});

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  String? getPatientID;
  @override
  void initState() {
    super.initState();
    _loadSavedAppointment();
  }

  Future<void> _loadSavedAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = prefs.getString('pmId') ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PatientAppointmentResponseData>(
      future: BaseApiService().patientAppointmentRecord(getPatientID.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.data == null) {
          return _noAppointmentScheduled(context);
        }
        List<Data> appointments = snapshot.data!.data!;
        DateTime now = DateTime.now();
        List<Data> upcomingAppointments = appointments
            .where((appointment) =>
                appointment.pamAppDate != null &&
                DateTime.tryParse(appointment.pamAppDate!)?.isAfter(now) ==
                    true)
            .toList();
        upcomingAppointments.sort((a, b) => DateTime.parse(a.pamAppDate!)
            .compareTo(DateTime.parse(b.pamAppDate!)));

        if (upcomingAppointments.isEmpty) {
          return _noAppointmentScheduled(context);
        }
        Data upcomingAppointment = upcomingAppointments.first;
        String appointmentDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(upcomingAppointment.pamAppDate!));
        String appointmentTime = upcomingAppointment.pamAppTime ?? "N/A";
        return _appointmentCard(appointmentDate, appointmentTime);
      },
    );
  }

  Widget _noAppointmentScheduled(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 30,
              color: AppColors.primaryDark,
            ),
            const SizedBox(height: 10),
            const Text(
              'No Appointment Scheduled',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const MyAppointmentsScreen()),
                );
              },
              icon: const Icon(
                Icons.calendar_today,
                size: 18,
                color: Colors.white,
              ),
              label: const Text(
                'Book Appointment',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'FontPoppins',
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appointmentCard(String saveDate, String saveTime) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            offset: const Offset(0, 30),
            blurRadius: 1,
            spreadRadius: -10,
          ),
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            offset: const Offset(0, 20),
            blurRadius: 1,
            spreadRadius: -10,
          ),
        ],
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(250, 30, 149, 195),
            const Color.fromARGB(200, 30, 149, 195).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/bima_sir.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Bimal Chhajer',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Cardiology',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                const Row(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/star.png'),
                      width: 15,
                      height: 15,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      saveDate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      saveTime,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
