import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AppointmentCentersResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AppointmentLocationResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/AvailableAppointmentDateResponse.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import '../data/network/BaseApiService.dart';
import 'AppointmentConfirmScreen.dart';
import 'PillReminderScreen.dart';


class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  int selectedDateIndex = 0;
  final ScrollController dateScrollController = ScrollController();
  final ScrollController dayScrollController = ScrollController();

  List<String> morningTimes = ['6:00 AM', '7:00 AM', '8:00 AM'];
  List<String> afternoonTimes = ['12:00 PM', '1:00 PM', '2:00 PM'];
  List<String> eveningTimes = ['6:00 PM', '7:00 PM', '8:00 PM'];

  List<String> times = []; // This will hold the currently selected time list

  int initialLabelIndex = 0;
  int initialLabelIndex2 = 0;
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


  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (saveTimeValue == null || saveTimeValue.isEmpty) {
      saveTimeValue = times.isNotEmpty
          ? times[0]
          : ''; // Default to first available time or custom time
    }

    setState(() {
      prefs.setString('appointMode', 'Online');
      prefs.setString('scheduleDate', saveDateValue); // Save either selected or current date
      prefs.setString('time', saveTimeValue);
      prefs.setString('ConsultationFees', consultationFess);
      prefs.setString('selectedDate', saveDate);
      prefs.setString('selectedDay', saveDay);

      if (initialLabelIndex2 == 0) {
        prefs.setString('Appointment Type', 'Online');
      } else if (initialLabelIndex2 == 1) {
        prefs.setString('Appointment Type', 'Offline');
        prefs.setString('cityName', saveCityName);
        prefs.setString('centerLocationID', centerID);
        prefs.setString('centerLocationName', saveCenterName);
        prefs.setString('appointmentAvailableDate',appointmentDate);
        prefs.setString('offlineFees',offlineConsultationFess);
      }
    });
  }

  Future<AppointmentCentersResponse>? _futureCenters;
  Future<AvailableAppointmentDateResponse>? _futureAppointments;



  @override
  void initState() {
    super.initState();
    _futureCenters = BaseApiService().getCenterLocation(saveCityName);
    if (centerID.isNotEmpty) {
      _futureAppointments = BaseApiService().getAvailableAppointmentDate(centerID);
    }
  }

  /* _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('appointMode','Online');
      prefs.setString('cityName', saveCityName);

      prefs.setString('scheduleDate',saveDateValue);
      prefs.setString('time', saveTimeValue);
      prefs.setString('ConsultationFees', consultationFess);
      if(initialLabelIndex2 == 0){
        prefs.setString('Appointment Type','Online');
      }else if (initialLabelIndex2 == 1){
        prefs.setString('Appointment Type','Offline');
      }
    });
  }*/

  int? _selectedIndex;
  String appointmentDate = '';

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/bima_sir.png',
                      height: 250,
                      width: 230,
                      fit: BoxFit.cover,
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 70),
                            Text(
                              'Dr.Bimal Chhajer',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'MBBS, MD,(Heart Specialist)',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('assets/icons/star.png'),
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '4.5 (2530)',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 17),
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
                        inactiveBgColor: Colors.blue[50],
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Available Location of SAAOL Center',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 95,
                                    child: FutureBuilder<AppointmentLocationResponse>(
                                      future: BaseApiService().getAppointmentLocation(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (selectCity == -1 && snapshot.data!.data!.isNotEmpty) {
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              setState(() {
                                                selectCity = 0; // Set the first item as selected by default
                                                saveCityName = snapshot.data!.data![0].hmState.toString(); // Save the default city name
                                                _futureCenters = BaseApiService().getCenterLocation(saveCityName);
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
                                                    _futureCenters = BaseApiService().getCenterLocation(saveCityName); // Update Future
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        constraints: const BoxConstraints(
                                                          minHeight: 90,
                                                          maxWidth: 95,
                                                        ),
                                                        width: 95,
                                                        decoration: BoxDecoration(
                                                          color: isSelected ? AppColors.primaryDark : Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image(
                                                              image: const AssetImage('assets/icons/kolkata.png'),
                                                              width: 40,
                                                              height: 40,
                                                              fit: BoxFit.cover,
                                                              color: isSelected ? Colors.white : Colors.black,
                                                            ),
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              snapshot.data!.data![index1].hmState.toString(),
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: 'FontPoppins',
                                                                fontWeight: FontWeight.w500,
                                                                color: isSelected ? Colors.white : Colors.black,
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
                                          return Text('Appointment-->${snapshot.error}');
                                        }
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),


                                 /* SizedBox(
                                    height: 95,
                                    child: FutureBuilder<AppointmentLocationResponse>(
                                      future: _appointmentFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(child: CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          print('Error fetching appointment: ${snapshot.error}');
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.data == null ||
                                            snapshot.data!.data!.isEmpty) {
                                          return const Center(child: Text('No Appointment available.'));
                                        } else {
                                          final appointment = snapshot.data!.data!;
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: appointment.length,
                                            itemBuilder: (context, index) {
                                              bool isSelected = selectCity == index;
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectCity = index;
                                                    saveCityName = appointment[index].hmState.toString();
                                                    print('SelectedCityName:$saveLocationName');
                                                  });
                                                  Fluttertoast.showToast(
                                                      msg: 'Selected city: $saveCityName');
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        constraints: const BoxConstraints(
                                                          minHeight: 90,
                                                          maxWidth: 95,
                                                        ),
                                                        width: 95,
                                                        decoration: BoxDecoration(
                                                          color: isSelected
                                                              ? AppColors.primaryDark
                                                              : Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image(
                                                              image: const AssetImage(
                                                                  'assets/icons/kolkata.png'),
                                                              width: 40,
                                                              height: 40,
                                                              fit: BoxFit.cover,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                            ),
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              appointment[index].hmState.toString(),
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: 'FontPoppins',
                                                                fontWeight: FontWeight.w500,
                                                                color: isSelected
                                                                    ? Colors.white
                                                                    : Colors.black,
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
                                        }
                                      },
                                    ),
                                  ),*/

                                  Divider(
                                    height: 30,
                                    thickness: 5,
                                    color: Colors.lightBlue[50],
                                  ),

                                  const Text(
                                    'Choose the center',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height:60,
                                    child:FutureBuilder<AppointmentCentersResponse>(
                                      future: _futureCenters,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(
                                            child: Container(
                                              width: 60, // Set custom width
                                              height:60, // Set custom height
                                              decoration: BoxDecoration(
                                                color:AppColors.primaryColor.withOpacity(0.1), // Background color for the progress indicator
                                                borderRadius: BorderRadius.circular(30), // Rounded corners
                                              ),
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.primaryColor, // Custom color
                                                  strokeWidth:6, // Set custom stroke width
                                                ),
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          print('Error fetching centers: ${snapshot.error}');
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.data == null ||
                                            snapshot.data!.data!.isEmpty) {
                                          return const Center(child: Text('No Centers available.'));
                                        } else {
                                          final centers = snapshot.data!.data!;
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: centers.length,
                                            itemBuilder: (context, index) {
                                              bool isSelected = centerID == snapshot.data!.data![index].hmId.toString();
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    centerID = snapshot.data!.data![index].hmId.toString();
                                                    print('centerID:$centerID');
                                                    saveCenterName = snapshot.data!.data![index].hmName.toString();
                                                    _futureAppointments = BaseApiService().getAvailableAppointmentDate(centerID); // Fetch new data
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        constraints: const BoxConstraints(
                                                          minHeight: 55, // Minimum height
                                                          maxWidth:155, // Max width for text wrapping
                                                        ),
                                                        width: 150, // Fixed width for consistent design
                                                        padding:const EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          color: isSelected ? AppColors.primaryDark : Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                        child: Center( // Ensures content is centered properly
                                                          child: Text(
                                                            centers[index].hmName.toString(),
                                                            textAlign: TextAlign.center,
                                                            maxLines: 2, // Prevents overflow by limiting text to 2 lines
                                                            overflow: TextOverflow.ellipsis, // Adds "..." if text is too long
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'FontPoppins',
                                                              fontWeight: FontWeight.w500,
                                                              color: isSelected ? Colors.white : Colors.black,
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

                                ],
                              ),
                          ),
                          Divider(
                            height: 35,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Available Dates',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                appointmentDate.isNotEmpty
                                    ? DateFormat('dd MMMM yyyy').format(DateTime.parse(appointmentDate))
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /* SizedBox(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dateList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    saveDateValue = DateFormat('MMMM dd')
                                        .format(dateList[index]);
                                    Fluttertoast.showToast(msg: saveDateValue);
                                    setState(() {
                                      selectedDateIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    width: 105,
                                    // Fixed width for alignment
                                    decoration: BoxDecoration(
                                      color: selectedDateIndex == index
                                          ? AppColors.primaryDark
                                          : Colors.blue[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatDate(dateList[index]),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'FontPoppins',
                                            color: selectedDateIndex == index
                                                ? Colors.white
                                                : AppColors.primaryDark,
                                          ),
                                        ),
                                        */ /*Text(
                                            dates[index]['day'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'FontPoppins',
                                              color: selectedDateIndex == index
                                                  ? Colors.white
                                                  : AppColors.primaryDark,
                                            ),
                                            textAlign: TextAlign
                                                .center, // Center align text
                                          ),*/ /*
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),*/


                          SizedBox(
                            height: 75,
                            child: centerID.isEmpty
                                ? const Center(
                              child: Text(
                                'Online appointment date is not available!',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                ),
                              ),
                            )
                                : FutureBuilder<AvailableAppointmentDateResponse>(
                              future: _futureAppointments,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: Container(
                                      width: 60, // Set custom width
                                      height:60, // Set custom height
                                      decoration: BoxDecoration(
                                        color:AppColors.primaryColor.withOpacity(0.1), // Background color for the progress indicator
                                        borderRadius: BorderRadius.circular(30), // Rounded corners
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor, // Custom color
                                          strokeWidth:6, // Set custom stroke width
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data!.length,
                                    itemBuilder: (context, index) {
                                      bool isSelected = _selectedIndex == index;
                                      DateTime date = DateTime.parse(snapshot.data!.data![index].slotDate.toString());
                                      String dayName = DateFormat('EEEE').format(date);
                                      String formattedDate = DateFormat('dd MMM').format(date);

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;
                                             appointmentDate = snapshot.data!.data![index].slotDate.toString();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints: const BoxConstraints(
                                                  minHeight: 60,
                                                  maxWidth: 120,
                                                ),
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: isSelected ? AppColors.primaryDark : Colors.grey.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    width: 0.6,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      dayName, // Display day name (e.g., Monday)
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'FontPoppins',
                                                        fontWeight: FontWeight.w600,
                                                        color: isSelected ? Colors.white : Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      formattedDate, // Display formatted date (e.g., 05 Mar)
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'FontPoppins',
                                                        fontWeight: FontWeight.w500,
                                                        color: isSelected ? Colors.white : Colors.black,
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
                                  return Center(
                                    child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)),
                                  );
                                }
                                return const Center(child: CircularProgressIndicator());
                              },
                            ),
                          ),


                         /* SizedBox(
                            height: 75,
                            child: centerID.isEmpty
                                ? const Center(
                              child: Text(
                                'Online appointment date is not available!',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                ),
                              ),
                            ) :FutureBuilder<AvailableAppointmentDateResponse>(
                              future: _futureAppointments,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  print('Error fetching appointment dates: ${snapshot.error}');
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.data == null ||
                                    snapshot.data!.data!.isEmpty) {
                                  return const Center(child: Text('No appointment date available.'));
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data!.length,
                                    itemBuilder: (context, index) {
                                      DateTime date = DateTime.parse(snapshot.data!.data![index].slotDate.toString());
                                      String dayName = DateFormat('EEEE').format(date);
                                      String formattedDate = DateFormat('dd MMM').format(date);

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;
                                            appointmentDate = snapshot.data!.data![index].slotDate.toString();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints: const BoxConstraints(
                                                  minHeight: 60,
                                                  maxWidth: 120,
                                                ),
                                                width: 120,
                                                decoration: BoxDecoration(color:Colors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    width: 0.6,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      dayName, // Display day name (e.g., Monday)
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'FontPoppins',
                                                        fontWeight: FontWeight.w600,
                                                        color:Colors.black87
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      formattedDate, // Display formatted date (e.g., 05 Mar)
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'FontPoppins',
                                                        fontWeight: FontWeight.w500,
                                                        color:Colors.black87
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
                                }
                              },
                            ),
                          ),*/

                          Divider(
                            height: 30,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          const Row(
                            children: [
                              Text(
                                'Available Slots',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.alarm,
                                size: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                          /*  const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Mon - Sat(9:00 AM - 10:00 AM)',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            ),*/

                          const SizedBox(
                            height: 15,
                          ),
                          ToggleSwitch(
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
                            labels: const ['Morning', 'Afternoon', 'Evening'],
                            customTextStyles: const [
                              TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                              ),
                              TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                              ),
                              TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                            radiusStyle: true,
                            onToggle: (index) {
                              setState(() {
                                initialLabelIndex = index!;
                                if (index == 0) {
                                  times = morningTimes;
                                } else if (index == 1) {
                                  times = afternoonTimes;
                                } else if (index == 2) {
                                  times = eveningTimes;
                                }
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${initialLabelIndex == 0 ? 'Morning' : initialLabelIndex == 1 ? 'Afternoon' : 'Evening'} Schedule',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    height: 40,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: times.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex1 = index;
                                              saveTimeValue = times[index];
                                              print('time:$saveTimeValue',);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: selectedIndex1 ==
                                                            index
                                                        ? AppColors.primaryDark
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      times[index],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'FontPoppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: selectedIndex1 ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Fees',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 70,
                                padding:const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Book Online Consult',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    if (initialLabelIndex2 == 0) ...[
                                      Text(
                                        consultationFess,
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ] else ...[
                                      Text(offlineConsultationFess,
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Dr. Bimal Chhajer Biography',
                            style: TextStyle(
                                fontSize: 17,
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
                            // Number of lines to display before showing 'Read More'
                            colorClickableText: AppColors.primaryColor,
                            // Text color of 'Read More/Read Less'
                            trimMode: TrimMode.Line,
                            // Trim mode: trims by lines
                            trimCollapsedText: 'Read More',
                            // Text when collapsed
                            trimExpandedText: 'Read Less',
                            // Text when expanded
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors
                                  .black87, // Text style for the main text
                            ),
                            moreStyle: TextStyle(
                              fontSize: 13,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const CustomProgressIndicator();
                                  },
                                );
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                await _incrementCounter();
                                Navigator.pop(context);
                                Navigator.push(context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                         AppointmentConfirmScreen(centerID:centerID,
                                           centerLocationName:saveCenterName,appointmentDate:appointmentDate,
                                             saveTimeValue:saveTimeValue),
                                  ),
                                );
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
          ),
        ],
      ),
    );
  }
}
