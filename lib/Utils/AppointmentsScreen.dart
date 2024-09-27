import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  int selectedDateIndex = 0;
  final ScrollController dateScrollController = ScrollController();
  final ScrollController dayScrollController = ScrollController();

  /*List<Map<String, dynamic>> dates = [
    {
      'day': 'Today',
      'date': 15,
    },
    {
      'day': 'Tomorrow',
      'date': 16,
    },
    {
      'day': 'Wed',
      'date': 17,
    },
    {
      'day': 'Thu',
      'date': 18,
    },
    {
      'day': 'Fri',
      'date': 19,
    },
    {
      'day': 'Sat',
      'date': 20,
    },
    {
      'day': 'Sun',
      'date': 21,
    },
  ];*/
  List<String> times = [
    "09-10 AM",
    "09-10 AM",
    "09-10 AM",
    "09-10 AM",
  ];
  List<String> citiesArray = [
    "Kolkata",
    "Chennai",
    "Bangalore",
    "Dehradun",
    "Itanagar"
  ];

  int initialLabelIndex = 0;
  int initialLabelIndex2 = 0;
  int? selectedIndex;
  int? selectedIndex1 = 0;
  int selectCity = 0;
  String saveTimeValue = '';
  String saveDateValue = '';
  String saveCityName = '';
  String consultationFess = '5000';

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // If no date is selected, use the current date as the default
    if (saveDateValue.isEmpty) {
      saveDateValue = DateFormat('MMMM dd').format(DateTime.now());
    }
    if (saveTimeValue == null || saveTimeValue.isEmpty) {
      saveTimeValue = times.isNotEmpty ? times[0] : ''; // Default to first available time or custom time
    }


    setState(() {
      prefs.setString('appointMode', 'Online');
      prefs.setString('scheduleDate', saveDateValue); // Save either selected or current date
      prefs.setString('time', saveTimeValue);
      prefs.setString('ConsultationFees', consultationFess);


      if (initialLabelIndex2 == 0) {
        prefs.setString('Appointment Type', 'Online');
      } else if (initialLabelIndex2 == 1) {
        prefs.setString('Appointment Type', 'Offline');
        prefs.setString('cityName', saveCityName);
      }
    });
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
  DateTime selectedDate = DateTime.now();
  int selectedDateIndex2 = 0; // Default selected date index (first date)
  int selectedTimeIndex = 0; // Default selected time index (08:00 AM)


  List<DateTime> dateList = [];
  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  // Generate 5 dates starting from the current date
  void _generateDateList() {
    dateList.clear();
    for (int i = 0; i < 5; i++) {
      dateList.add(selectedDate.add(Duration(days: i)));
    }
  }

  // Function to show the date picker and update the date list
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // Disable dates before today
      lastDate: DateTime.now().add(const Duration(days: 4)), // Disable dates after 4 days from now
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _generateDateList();
        selectedDateIndex = 0; // Reset the selected date to the first one
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('E\nd').format(date); // Formats the date like 'Wed\n20'
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
                /*const Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),*/
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
                        // Add some padding to separate text from the image
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align text to the start
                          children: [
                            SizedBox(height: 70),
                            Text(
                              'Dr. Bimal Chhajer',
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 99,
                                width: 88,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/icons/patient.png'),
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                        color: AppColors.primaryDark,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '1000+',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        'Patients',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 99,
                                width: 88,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/icons/patient.png'),
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                        color: AppColors.primaryDark,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '20+',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        'Experience',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 99,
                                width: 88,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/icons/patient.png'),
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                        color: AppColors.primaryDark,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '5.0',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        'Rating',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 99,
                                width: 88,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/icons/patient.png'),
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                        color: AppColors.primaryDark,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '800+',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        'Reviews',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child:  Row(
                              children: [
                                const Text(
                                  'Schedule Date',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Expanded(child: Container()),
                                const Icon(
                                  Icons.calendar_today,
                                  color: AppColors.primaryDark,
                                  size: 18,
                                ),
                                const SizedBox(width: 5,),
                                const Text(
                                  'September',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                                const SizedBox(width:5,),
                                const Icon(Icons.keyboard_arrow_down_rounded,
                                  color:Colors.grey,size:20,),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 70,
                            // Adjusted height to fit both dates and days
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dateList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    saveDateValue = DateFormat('MMMM dd').format(dateList[index]);
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
                                    child:Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatDate(dateList[index]),
                                          textAlign:TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'FontPoppins',
                                            color: selectedDateIndex == index
                                                ? Colors.white
                                                : AppColors.primaryDark,
                                          ),
                                        ),
                                        /*Text(
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
                                          ),*/
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          Visibility(
                              visible: initialLabelIndex2 == 1,
                              child:Column(crossAxisAlignment:CrossAxisAlignment.start,
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
                                    height: 80,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: citiesArray.length,
                                      itemBuilder: (context, index) {
                                        bool isSelected = selectCity == index;
                                        return GestureDetector(
                                          onTap: () {
                                            saveCityName = citiesArray[index];
                                            Fluttertoast.showToast(msg: citiesArray[index]);
                                            setState(() {
                                              selectCity = index;
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
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? AppColors.primaryDark
                                                        : Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        width: 0.2),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        citiesArray[index],
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
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Available Time',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                            labels: const [
                              'Morning',
                              'Afternoon',
                              'Evening',
                            ],
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
                              });
                              print('switched to: $index');
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
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Morning Schedule',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
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
                                                        ? AppColors
                                                        .primaryDark
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
                                                        color:
                                                        selectedIndex1 ==
                                                            index
                                                            ? Colors.white
                                                            : Colors
                                                            .black,
                                                      ),
                                                    ),
                                                  ),
                                                )
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

                          Visibility(
                              visible: initialLabelIndex2 == 0,
                              child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Fees',
                                    style:TextStyle(fontFamily:'FontPoppins',fontSize:18,
                                      fontWeight:FontWeight.w600,color:Colors.black),),
                                  const SizedBox(height:10,),
                                  Container(
                                    height:65,
                                    width:115,
                                    decoration:BoxDecoration(
                                      color:AppColors.primaryDark,
                                      borderRadius:BorderRadius.circular(8),
                                    ),
                                    child: Column(crossAxisAlignment:CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Consultation',
                                          style:TextStyle(fontFamily:'FontPoppins',
                                            fontSize:13,fontWeight:FontWeight.w500,color:Colors.white),),
                                        const SizedBox(height:5,),
                                        Text(consultationFess,
                                          style:const TextStyle(fontFamily:'FontPoppins',
                                            fontSize:16,
                                            fontWeight:FontWeight.w700,color:Colors.white),)
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                          const SizedBox(height:15,),
                          const Text(
                            'Doctor Biography',
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
                            trimLines:2,
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
                        /*  SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                await Future.delayed(const Duration(seconds: 2));
                                await _incrementCounter();
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const AppointmentConfirmScreen(),
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
                          ),*/

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
