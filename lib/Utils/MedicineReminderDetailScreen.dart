import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/Utils/PillReminderScreen.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../responsemodel/DatabaseHelper.dart';
import '../responsemodel/Medicine.dart';
import 'MedicineProgressDetailScreen.dart';

class MedicineReminderDetailScreen extends StatefulWidget {
  const MedicineReminderDetailScreen({super.key});

  @override
  State<MedicineReminderDetailScreen> createState() =>
      _MedicineReminderDetailScreenState();
}

class _MedicineReminderDetailScreenState
    extends State<MedicineReminderDetailScreen> {
  final List<String> daysOfWeek = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

  final List<String> datesOfWeek = ["03", "04", "05", "06", "07", "08", "09"];

  int selectedIndex = 0;
  late Future<List<MedicineModel>> medicineList;
  String getPatientID = '';
  String userName = '';
  String googleUserID = '';
  String googlePatientName = '';

  @override
  void initState() {
    super.initState();
    _loadSavedAppointment();
    medicineList = DatabaseHelper().getMedicines();
  }

  void _refreshMedicineList() {
    setState(() {
      medicineList = DatabaseHelper().getMedicines();
    });
  }

  Future<void> _loadSavedAppointment() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = prefs.getString('pmId') ?? '';
      googleUserID = prefs.getString('GoogleUserID') ?? '';
      googlePatientName = prefs.getString('GoogleUserName') ?? '';

      if (getPatientID.isNotEmpty) {
        userName = (prefs.getString('PatientFirstName') ?? '');
      } else {
        userName = (prefs.getString(ApiConstants.USER_NAME) ?? '');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryDark,
        onPressed: () async {
          final newMedicine = await Navigator.of(context).push<MedicineModel>(
            MaterialPageRoute(builder: (context) => const PillReminderScreen()),
          );
          if (newMedicine != null) {
            _refreshMedicineList();
          }
        },
        label: const Text(
          'Add Reminder',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 260,
                  padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hello 👋, $userName",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'FontPoppins',
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: daysOfWeek.length,
                          itemBuilder: (context, index) {
                            // Check if the current item is selected
                            final bool isSelected = selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Update the selected index
                                  selectedIndex = index;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      daysOfWeek[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: isSelected
                                            ? null
                                            : Border.all(
                                                color: Colors.white, width: 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          datesOfWeek[index],
                                          style: TextStyle(
                                            color: isSelected
                                                ? const Color(
                                                    0xFF70C9F9) // Blue color for selected date
                                                : Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
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
                      const Center(
                        child: Icon(
                          Icons.keyboard_double_arrow_down,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<MedicineModel>>(
              future: medicineList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text(
                    textAlign:TextAlign.center,
                      'No medicines found.',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else {
                  // Separate medicines by time
                  List<MedicineModel> morningMedicines = snapshot.data!
                      .where((medicine) => medicine.time == 'Before Meal')
                      .toList();
                  List<MedicineModel> afternoonMedicines = snapshot.data!
                      .where((medicine) => medicine.time == 'After Meal')
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Morning Section
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child:  Row(
                          children: [
                            const Image(
                              image: AssetImage('assets/icons/morning.png'),
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              'Morning',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Expanded(child: Container()),
                            const Text(
                              'View All',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),

                      Padding(padding: EdgeInsets.symmetric(horizontal:15),child:  SizedBox(
                        height: 170,
                        child: ListView.builder(
                          itemCount: morningMedicines.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildMedicineCard(
                                context, morningMedicines[index]);
                          },
                        ),
                      ),),

                      // Afternoon Section
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage('assets/icons/afternoon.png'),
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              'Afternoon',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Expanded(child: Container()),
                            const Text(
                              'View All',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding:const EdgeInsets.symmetric(horizontal:15),child:SizedBox(
                        height: 170,
                        child: ListView.builder(
                          itemCount: afternoonMedicines.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildMedicineCard(
                                context, afternoonMedicines[index]);
                          },
                        ),
                      ),),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
  Widget buildMedicineCard(BuildContext context, MedicineModel medicine) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
              const MedicineProgressDetailScreen()), // Replace with your screen
        );
      },
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: screenWidth * 0.8,
              // Adjust width to 80% of screen width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 0.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // Top Section: "Intake completed!!" and check icon


                    const Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Text(
                          "Intake completed!!",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'FontPoppins',
                            color: AppColors
                                .primaryColor,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.check_box,
                          color:
                          AppColors.primaryDark,
                          size: 22,
                        ),
                      ],
                    ),

                    const Divider(
                      thickness: 0.2,
                      height: 18,
                      color: Colors.grey,
                    ),
                    // Main Info Section
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        // Profile Image
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          NetworkImage(
                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', // Replace with actual image URL
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Medicine Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    medicine.name,
                                    style:
                                    const TextStyle(
                                      fontSize: 18,
                                      fontFamily:
                                      'FontPoppins',
                                      fontWeight:
                                      FontWeight
                                          .w500,
                                      color: Colors
                                          .black,
                                    ),
                                  ),
                                  const SizedBox(
                                      width: 10),
                                  Container(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        15,
                                        vertical:
                                        4),
                                    decoration:
                                    BoxDecoration(
                                      color: Colors
                                          .blue
                                          .withOpacity(
                                          0.2),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          15),
                                    ),
                                    child: Text(
                                      medicine.type,
                                      style:
                                      const TextStyle(
                                        color: AppColors
                                            .primaryColor,
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                        fontSize: 13,
                                        fontFamily:
                                        'FontPoppins',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 5),
                              Row(
                                children: [
                                  const Icon(
                                      Icons
                                          .access_time,
                                      size: 16,
                                      color: AppColors
                                          .primaryDark),
                                  const SizedBox(
                                      width: 5),
                                  if (medicine.time == 'Before Meal') ...[
                                    const Text(
                                      "9:00 AM",
                                      style: TextStyle(
                                        color: Colors
                                            .black87,
                                        fontSize: 12,
                                        fontFamily:
                                        'FontPoppins',
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                      ),
                                    ),
                                  ] else if(medicine.time == 'After Meal')...[
                                    const Text(
                                      "12:00 PM",
                                      style: TextStyle(
                                        color: Colors
                                            .black87,
                                        fontSize: 12,
                                        fontFamily:
                                        'FontPoppins',
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(
                                      width: 10),
                                  Image.asset(
                                    'assets/icons/drugs.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                      width: 5),
                                  Text(
                                    medicine.time,
                                    style: const TextStyle(
                                        color: Colors
                                            .black87,
                                        fontSize: 12,
                                        fontFamily:
                                        'FontPoppins',
                                        fontWeight:
                                        FontWeight
                                            .w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Progress Bar Section
                    Row(
                      children: [
                        Expanded(
                          child:
                          LinearProgressIndicator(
                            value: 0.45,
                            // 45% progress
                            backgroundColor:
                            Colors.grey[300],
                            color: AppColors
                                .primaryColor,
                            minHeight: 5,
                            borderRadius:
                            BorderRadius.circular(
                                10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "45%",
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight:
                            FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'FontPoppins',
                          ),
                        ),
                      ],
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

