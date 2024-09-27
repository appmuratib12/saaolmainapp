import 'package:flutter/material.dart';
import 'common/app_colors.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({super.key});

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  List<String> medicineTypeArray = [
    "Tablet",
    "Capsule",
    "Injection",
    "Injection"
  ];
  int selectedIndex = -1;

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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Add Medicine',
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /*Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => const PillReminderScreen()),
          );*/
        },
        label: const Text(
          'Add Medicine',
          style: TextStyle(
              fontSize: 13,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primaryDark,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    width: 70,
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
                    width: 70,
                    height: 2, // Height of the line
                    color: AppColors.primaryColor, // Color of the line
                  ),

                  // Step 3 - Incomplete

                  // Solid line between steps
                ],
              ),
              Text('Choose medicine type'),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: medicineTypeArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                     isSelected = selectedIndex == index;

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
            ],
          ),
        ),
      ),
    );
  }
}
