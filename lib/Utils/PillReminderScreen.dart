import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../responsemodel/DatabaseHelper.dart';
import '../responsemodel/Medicine.dart';
import 'MedicineReminderDetailScreen.dart';

class PillReminderScreen extends StatefulWidget {
  const PillReminderScreen({super.key});

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  List<String> medicineTypeArray = [
    "Tablet",
    "Capsule",
    "Injection",
    "Injection"
  ];
  int selectedIndex = -1;
  bool isBeforeSelected = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController scheduleController = TextEditingController();
  List<String> medicineIconArray = [
    "assets/icons/medicine_icon.png",
    "assets/icons/drugs.png",
    "assets/icons/syringe.png",
    "assets/icons/syringe.png"
  ];
  bool isSelected = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Pill Reminder',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Add the onPressed action here for the notification icon
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40, // Adjust size as needed
                  backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-psd/expressive-woman-gesturing_23-2150198673.jpg', // Replace with your image URL
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between avatar and name
              const Center(
                child: Text(
                  'Joham Neyal',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Step 1 - Completed
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primaryDark,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(height: 5),
                    ],
                  ),

                  // Solid line between steps
                  Container(
                    width:65,
                    height: 2, // Height of the line
                    color: AppColors.primaryColor, // Color of the line
                  ),

                  // Step 2 - Current step
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isSelected
                            ? Colors.blue.withOpacity(0.2)
                            : AppColors.primaryDark,
                        child: isSelected
                            ? const Text(
                          "2",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                            : const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),

                  // Solid line between steps
                  Container(
                    width:65,
                    height: 2, // Height of the line
                    color: AppColors.primaryColor, // Color of the line
                  ),

                  // Step 3 - Incomplete
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isBeforeSelected
                            ? Colors.blue.withOpacity(0.2)
                            : AppColors.primaryDark,
                        child: isBeforeSelected
                            ? const Text(
                          "3",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                            : const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),

                  // Solid line between steps
                  Container(
                    width: 65,
                    height: 2, // Height of the line
                    color: AppColors.primaryColor, // Color of the line
                  ),

                  // Step 4 - Incomplete
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue.withOpacity(0.2),
                        child: const Text(
                          "4",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: 'FontPoppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              const Text(
                'Medicine Name',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Joham Neyal",
                    hintStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Choose medicine type',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: medicineTypeArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Update the selected index
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              child: Container(
                                height: 70,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors
                                          .primaryDark // Change background color if selected
                                      : Colors.white,
                                  // Default background color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Image(
                                    image: AssetImage(medicineIconArray[index]),
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.cover,
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
              const Text(
                'Time & Schedule',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBeforeSelected = true;
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isBeforeSelected
                              ? AppColors.primaryColor
                              : Colors.grey,
                          width: 2,
                        ),
                        color:
                            isBeforeSelected ? Colors.blue[50] : Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: isBeforeSelected
                                ? AppColors.primaryDark
                                : Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Before',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: isBeforeSelected
                                  ? AppColors.primaryDark
                                  : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBeforeSelected = false;
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isBeforeSelected
                              ? Colors.grey
                              : AppColors.primaryColor,
                          width: 2,
                        ),
                        color:
                            isBeforeSelected ? Colors.white : Colors.blue[50],
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: isBeforeSelected
                                ? Colors.grey
                                : AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'After',
                            style: TextStyle(
                              color: isBeforeSelected
                                  ? Colors.grey
                                  : AppColors.primaryColor,
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              SizedBox(
                height: 100, // You can adjust the height as needed
                child: Row(
                  children: [
                    _buildDropdownSection(
                        "Duration", "1 Month", Icons.calendar_month),
                    SizedBox(width: 16),
                    _buildDropdownSection(
                        "Frequency", "Daily", Icons.access_time),
                  ],
                ),
              ),


              SizedBox(
                height: 50,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 12),
                    ),
                    onPressed: () async {
                      if (selectedIndex != -1) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          // Prevents closing the dialog by tapping outside
                          builder: (BuildContext context) {
                            return const CustomProgressIndicator();
                          },
                        );
                        await Future.delayed(const Duration(seconds: 5));

                        MedicineModel newMedicine1 = MedicineModel(
                          name: nameController.text.toString(),
                          // Replace with actual medicine name
                          type: medicineTypeArray[selectedIndex],
                          time: isBeforeSelected ? "Before" : "After",
                          schedule: "1 Month", // Replace with actual schedule
                        );

                        DatabaseHelper dbHelper = DatabaseHelper();
                        await dbHelper.insertMedicine(newMedicine1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MedicineReminderDetailScreen()),
                        );
                        // You can also show a confirmation message or navigate to another screen
                      }
                    },
                    child: const Text(
                      "Add Reminder",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownSection(String title, String value, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'FontPoppins',
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primaryDark),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Please wait...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
