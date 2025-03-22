import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';
import '../responsemodel/DatabaseHelper.dart';
import '../responsemodel/Medicine.dart';

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
  final List<String> frequencyArray = [
    'Once a Day',
    'Twice a Day',
    'Thrice a Day'
  ];
  final List<String> scheduleArray = ['1 Week', '1 Month', '1 Year'];
  String? selectFrequency;
  bool isSelected = true;
  String? selectSchedule;
  String? selectMedicine = 'Paracetamol';
  final List<String> medicineArray = ['Paracetamol', 'Ibuprofen', 'Aspirin'];

  void _showFrequencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Frequency',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: frequencyArray.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    frequencyArray[index],
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectFrequency = frequencyArray[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Schedule',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: scheduleArray.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    scheduleArray[index],
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectSchedule = scheduleArray[index];
                      Fluttertoast.showToast(msg: selectSchedule.toString());
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<String> notificationTimes = [
    "07:00 am",
    "08:00 am",
  ];
  String? selectedTime;

  void _addNotificationTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      String formattedTime =
          "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? 'am' : 'pm'}";
      setState(() {
        notificationTimes.add(formattedTime);
      });
    }
  }



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
                child: Image(
                  image: AssetImage('assets/icons/medicine_icon.png'),
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
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
              DropdownButtonFormField2<String>(
                value: selectMedicine,
                decoration: InputDecoration(
                  hintText: 'Select Medicine',
                  hintStyle: const TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                ),
                items: medicineArray
                    .map((medicine) => DropdownMenuItem<String>(
                          value: medicine,
                          child: Text(medicine),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectMedicine = value; // Update the selected medicine
                    Fluttertoast.showToast(msg: selectMedicine.toString());
                  });
                },
              ),
              /* SizedBox(
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Abacavir',
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
              ),*/
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
                                          .primaryColor // Change background color if selected
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
                          const SizedBox(width: 5),
                          Text(
                            'Before Meal',
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
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
                            'After Meal',
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Frequency',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'FontPoppins',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: _showFrequencyDialog,
                          child: AbsorbPointer(
                            child: DropdownButtonFormField<String>(
                              value: selectFrequency,
                              decoration: InputDecoration(
                                hintText: 'Select Frequency',
                                hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                              ),
                              items: frequencyArray
                                  .map((frequency) => DropdownMenuItem<String>(
                                        value: frequency,
                                        child: Text(frequency),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'FontPoppins',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: _showScheduleDialog,
                          child: AbsorbPointer(
                            child: DropdownButtonFormField<String>(
                              value: selectSchedule,
                              decoration: InputDecoration(
                                hintText: 'Select Schedule',
                                hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                              ),
                              items: scheduleArray
                                  .map((schedule) => DropdownMenuItem<String>(
                                        value: schedule,
                                        child: Text(schedule),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height:15,
              ),
              const Text(
                'Notification',
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(
                height:15,
              ),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  for (var time in notificationTimes)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTime = time;
                          Fluttertoast.showToast(msg: selectedTime.toString());
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedTime == time
                              ? AppColors.primaryDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedTime == time
                                ? AppColors.primaryDark
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: selectedTime == time
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                            fontFamily:'FontPoppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: _addNotificationTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:AppColors.primaryDark,
                          width: 1.5,
                        ),
                      ),
                      child:  const Icon(
                        Icons.add,
                        color:AppColors.primaryDark,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height:30,),
              SizedBox(
                height: 55,
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
                      MedicineModel newMedicine = MedicineModel(
                        name: selectMedicine.toString(),
                        type: medicineTypeArray[selectedIndex],
                        time: isBeforeSelected ? "Before Meal" : "After Meal",
                        schedule: selectSchedule.toString(),
                      );
                      DatabaseHelper dbHelper = DatabaseHelper();
                      await dbHelper.insertMedicine(newMedicine);
                      // Return the added medicine to the previous screen
                      Navigator.pop(context, newMedicine);
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
