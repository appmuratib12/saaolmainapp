import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_colors.dart';
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

  List<String> medicineArray = ["Captopril", "Enalapril"];
  late Future<List<MedicineModel>> medicineList;


  @override
  void initState() {
    super.initState();
    medicineList = DatabaseHelper().getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    var currentDate = DateTime.now();
    var dateFormatter = DateFormat('MMMM dd, yyyy');
    var formattedDate = dateFormatter.format(currentDate);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 205,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
          color: AppColors.primaryDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formattedDate,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hello 👋, John Smith",
                    style: TextStyle(
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
                    bool isSelected =
                        index == 4; // Mark "Fri" as selected for example
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: isSelected
                                  ? null
                                  : Border.all(color: Colors.white, width: 1),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                child:FutureBuilder<List<MedicineModel>>(
                  future: medicineList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No medicines found.'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          MedicineModel medicine = snapshot.data![index];
                          // Get the full width of the screen
                          double screenWidth = MediaQuery.of(context).size.width;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                    const MedicineProgressDetailScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160,
                                    width: screenWidth * 0.8,
                                    // Adjust width to 80% of screen width
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Top Section: "Intake completed!!" and check icon
                                          const Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Intake completed!!",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'FontPoppins',
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(
                                                Icons.check_box,
                                                color: AppColors.primaryDark,
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
                                                backgroundImage: NetworkImage(
                                                  'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', // Replace with actual image URL
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              // Medicine Info
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(medicine.name,
                                                          style: const TextStyle(
                                                            fontSize: 18,
                                                            fontFamily: 'FontPoppins',
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15,
                                                              vertical: 4),
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue
                                                                .withOpacity(0.2),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                          ),
                                                          child: Text(
                                                            medicine.type,
                                                            style: const TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 13,
                                                              fontFamily:
                                                              'FontPoppins',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.access_time,
                                                            size: 16,
                                                            color: AppColors
                                                                .primaryDark),
                                                        const SizedBox(width: 5),
                                                        const Text(
                                                          "9:00 AM",
                                                          style: TextStyle(
                                                            color: Colors.black87,
                                                            fontSize: 12,
                                                            fontFamily: 'FontPoppins',
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Image.asset(
                                                          'assets/icons/drugs.png',
                                                          width: 16,
                                                          height: 16,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          medicine.time,
                                                          style: const TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 12,
                                                              fontFamily:
                                                              'FontPoppins',
                                                              fontWeight:
                                                              FontWeight.w500),
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
                                                child: LinearProgressIndicator(
                                                  value: 0.45,
                                                  // 45% progress
                                                  backgroundColor: Colors.grey[300],
                                                  color: AppColors.primaryColor,
                                                  minHeight: 5,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "45%",
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.w600,
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
                        },
                      );
                    }
                  },
                ),
              ),
              Row(
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  itemCount: medicineArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Get the full width of the screen
                    double screenWidth = MediaQuery.of(context).size.width;

                    return InkWell(
                      onTap: () {
                        // Handle tap event
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 160,
                              width: screenWidth * 0.8,
                              // Adjust width to 80% of screen width
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 0.2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Section: "Intake completed!!" and check icon
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Intake completed!!",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(
                                          Icons.check_box,
                                          color: AppColors.primaryDark,
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
                                          backgroundImage: NetworkImage(
                                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', // Replace with actual image URL
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // Medicine Info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Peracitamole",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: const Text(
                                                      "1 Tablet",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        fontFamily:
                                                            'FontPoppins',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time,
                                                      size: 16,
                                                      color: AppColors
                                                          .primaryDark),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "9:00 AM",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                    'assets/icons/drugs.png',
                                                    width: 16,
                                                    height: 16,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Before Meal",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'FontPoppins',
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                          child: LinearProgressIndicator(
                                            value: 0.45,
                                            // 45% progress
                                            backgroundColor: Colors.grey[300],
                                            color: AppColors.primaryColor,
                                            minHeight: 5,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          "45%",
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w600,
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
                  },
                ),
              ),
              Row(
                children: [
                  const Image(
                    image: AssetImage('assets/icons/night.png'),
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Night',
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  itemCount: medicineArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Get the full width of the screen
                    double screenWidth = MediaQuery.of(context).size.width;

                    return InkWell(
                      onTap: () {
                        // Handle tap event
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 160,
                              width: screenWidth * 0.8,
                              // Adjust width to 80% of screen width
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 0.2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Section: "Intake completed!!" and check icon
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Intake time left out in 30 mins",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(
                                          Icons.check_box,
                                          color: Colors.grey,
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
                                          backgroundImage: NetworkImage(
                                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', // Replace with actual image URL
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // Medicine Info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Peracitamole",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: const Text(
                                                      "1 Tablet",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        fontFamily:
                                                            'FontPoppins',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time,
                                                      size: 16,
                                                      color: AppColors
                                                          .primaryDark),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "9:00 AM",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                    'assets/icons/drugs.png',
                                                    width: 16,
                                                    height: 16,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Before Meal",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'FontPoppins',
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                          child: LinearProgressIndicator(
                                            value: 0.45,
                                            // 45% progress
                                            backgroundColor: Colors.grey[300],
                                            color: AppColors.primaryColor,
                                            minHeight: 5,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          "45%",
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w600,
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
