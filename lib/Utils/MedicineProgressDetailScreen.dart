import 'package:flutter/material.dart';
import '../common/app_colors.dart';


class MedicineProgressDetailScreen extends StatelessWidget {
  const MedicineProgressDetailScreen({super.key});


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /* SizedBox(
                    height: 10,
                  ),
                  PieChart(
                    dataMap: percentageDataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 20,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 28,
                    centerText: "Attendance",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),*/

                const Center(
                  child: Image(
                    image: AssetImage('assets/icons/medicine_icon.png'),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
                const Text(
                  'Antiplatelet drugs',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  'Antiplatelet drugs are medications that prevent blood clots from forming by stopping platelets from sticking together. They can help prevent heart attacks and strokes',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    buildTimeButton('After Breakfast', Colors.blue[100]!,
                        AppColors.primaryColor),
                    SizedBox(width: 10),
                    buildTimeButton(
                        'After Dinner', AppColors.primaryDark, Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoCard(
                      'This Month',
                      '4/31 Taken',
                      Icons.article,
                      Colors.redAccent,
                      Colors.redAccent,
                    ),
                    buildInfoCard(
                      'Amount',
                      '2 Pills/day',
                      Icons.shopping_bag,
                      AppColors.primaryColor,
                      AppColors.primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoCard(
                      'Cause',
                      'High Fever',
                      Icons.ac_unit,
                      Colors.blueAccent,
                      Colors.blueAccent,
                    ),
                    buildInfoCard(
                      'Cap Size',
                      '120 mg',
                      Icons.cloud,
                      Colors.orangeAccent,
                      Colors.orangeAccent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                            horizontal: 90, vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Edit Schedule",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.2,
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
        ));
  }

  Widget buildTimeButton(String text, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'FontPoppins',
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String value, IconData icon,
      Color iconColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'FontPoppins'),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'FontPoppins'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
