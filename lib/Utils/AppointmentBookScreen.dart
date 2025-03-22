import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/PatientAppointmentResponseData.dart';
import '../data/network/BaseApiService.dart';
import '../responsemodel/AppointmentDatabaseHelper.dart';
import '../responsemodel/PatientAppointmentModel.dart';
import 'AppointmentDetailsScreen.dart';
import 'StatesData.dart';


class AppointmentBookScreen extends StatefulWidget {
  const AppointmentBookScreen({super.key});

  @override
  State<AppointmentBookScreen> createState() => _AppointmentBookScreenState();
}

class _AppointmentBookScreenState extends State<AppointmentBookScreen> {
  int initialLabelIndex = 0; // 0 = Upcoming, 1 = Completed, 2 = Cancelled
  String getPatientID = '';
  late Future<List<PatientAppointmentModel>> medicineList;

  @override
  void initState() {
    super.initState();
    _loadPatientID();
    medicineList = AppointmentDatabaseHelper().getAppointments();
  }

  Future<void> _loadPatientID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = (sharedPreferences.getString('pmId') ?? '');
      print('PatientID:-->$getPatientID');
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

  List<PatientAppointmentModel> _filterAppointments(List<PatientAppointmentModel> allAppointments) {
    DateTime today = DateTime.now();
    if (initialLabelIndex == 0) {
      // Upcoming: Appointments on or after today
      return allAppointments
          .where((appointment) =>
              DateFormat('yyyy-MM-dd').parse(appointment.date).isAfter(today) ||
              DateFormat('yyyy-MM-dd')
                  .parse(appointment.date)
                  .isAtSameMomentAs(today))
          .toList();
    } else if (initialLabelIndex == 1) {
      // Completed: Appointments before today
      return allAppointments
          .where((appointment) =>
              DateFormat('yyyy-MM-dd').parse(appointment.date).isBefore(today))
          .toList();
    }
    return [];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'My Appointments',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body:Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ToggleSwitch(
              minWidth: double.infinity,
              cornerRadius: 20.0,
              activeBgColors: const [
                [AppColors.primaryDark],
                [AppColors.primaryDark],
                [AppColors.primaryDark],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.blue[50],
              inactiveFgColor: AppColors.primaryDark,
              initialLabelIndex: initialLabelIndex,
              totalSwitches: 3,
              labels: const ['Upcoming', 'Completed', 'Cancelled'],
              customTextStyles: const [
                TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
                TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
                TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
              ],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  initialLabelIndex = index!;
                  print('switched to: $index');
                });
              },
            ),
          ),
          if (initialLabelIndex == 1)
            FutureBuilder<PatientAppointmentResponseData>(
              future: BaseApiService().patientAppointmentRecord(getPatientID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                  return const Center(child: Text('No Appointment available.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    scrollDirection:Axis.vertical,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                            builder: (context) => AppointmentDetailScreen(
                                appointmentCategory:snapshot.data!.data![index].pamAppointmentCategory.toString(),
                                appointmentDate:snapshot.data!.data![index].pamAppDate.toString(),
                                appointmentTime:snapshot.data!.data![index].pamAppTime.toString(),
                                appointmentDuration:snapshot.data!.data![index].pamAppointmentDuration.toString(),
                                patientID: getPatientID,appointmentID:snapshot.data!.data![index].pamId.toString()),
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
                                      Text(
                                        snapshot.data!.data![index].pamAppDate
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
                                        _convertTo12HourFormat(snapshot
                                            .data!.data![index].pamAppTime
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
                                      Fluttertoast.showToast(
                                          msg: 'Prescription');
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
                  );
                }
              },
            ),
            Expanded(child: FutureBuilder<List<PatientAppointmentModel>>(
            future: medicineList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text(''));
              } else {
                final filteredAppointments = _filterAppointments(snapshot.data!);

                if (filteredAppointments.isEmpty) {
                  return  const Center(
                    child: Text('No appointments available.',
                      style:TextStyle(fontFamily:'FontPoppins',
                          fontWeight:FontWeight.w600,fontSize:16,color:Colors.black87),),
                  );
                }

                return ListView.builder(
                  itemCount: filteredAppointments.length,
                  scrollDirection:Axis.vertical,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final appointment = filteredAppointments[index];
                    PatientAppointmentModel medicine = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(CupertinoPageRoute(
                          builder: (context) => AppointmentDetailScreen(
                              appointmentCategory:'Online',
                              appointmentDate:appointment.date.toString(),
                              appointmentTime:appointment.time,
                              appointmentDuration:'',
                              patientID:'',appointmentID:'',),
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
                                    const Icon(Icons.calendar_month_outlined,
                                        color: AppColors.primaryColor),
                                    const SizedBox(width: 5),
                                    Text(appointment.date,
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
                                    Text(appointment.time,
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
                                    Fluttertoast.showToast(
                                        msg: 'View Prescription');
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
                                              color: AppColors.primaryColor)),
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
                );
              }
            },
          ),)
        ],
      ),
    );
  }
}
