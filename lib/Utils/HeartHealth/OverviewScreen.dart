import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../data/model/apiresponsemodel/OverviewItemResponse.dart';
import '../../data/model/apiresponsemodel/overviewsResponse.dart';
import '../../data/network/BaseApiService.dart';


class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}


class _OverviewScreenState extends State<OverviewScreen> {
  late Future<OverviewResponse> overviewData;
  late Future<OverviewItemResponse> overviewItemData;
  int selectedIndex = -1;
  String selectedId = "1";


  @override
  void initState() {
    super.initState();
    overviewData = BaseApiService().getOverviewData(); // Fetch API data
    overviewItemData = BaseApiService().getOverviewItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Overview',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: FutureBuilder<OverviewResponse>(
                  future: overviewData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data!.isEmpty) {
                      return const Center(child: Text('No Data Available'));
                    }

                    final overviewItems = snapshot.data!.data;
                    return ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: overviewItems!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        bool isSelected = index == selectedIndex;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedId = overviewItems[index].id.toString();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IntrinsicWidth(
                                  child: Container(
                                    height: 40,
                                    constraints: const BoxConstraints(
                                      minWidth: 200,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          overviewItems[index].title.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
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
                  },
                ),
              ),
              FutureBuilder<OverviewItemResponse>(
                future: overviewItemData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else
                  if (!snapshot.hasData || snapshot.data!.data == null ||
                      snapshot.data!.data!.isEmpty) {
                    return  const Center(child: Text(
                        'No Overview Item available.',style:TextStyle(fontSize:15,
                        fontWeight:FontWeight.w500,fontFamily:'FontPoppins',
                        color:Colors.black),));
                  }

                  final overviewItems = snapshot.data!.data;
                  final filteredItems = overviewItems!.where((item) =>
                  item.overviewId.toString() == selectedId).toList();

                  if (filteredItems.isEmpty) {
                    return  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Table(
                                border:
                                TableBorder.all(color: Colors.grey, width: 0.6),
                                columnWidths: const {
                                  0: FlexColumnWidth(0.5),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1),
                                  3: FlexColumnWidth(1),
                                  // Ensure consistent column count
                                },
                                children: [
                                  // Header Row
                                  TableRow(
                                    decoration: const BoxDecoration(
                                        color: AppColors.primaryDark),
                                    children: [
                                      buildHeaderCell('No'),
                                      buildHeaderCell('Causative Factors'),
                                      buildHeaderCell(
                                          'Usual Cardiology Recommendation'),
                                      buildHeaderCell('SAAOL Recommendation'),
                                    ],
                                  ),
                                  // Data Rows
                                  buildDataRow('1', 'Serum Cholesterol',
                                      '130 - 200 mg/dl', 'Less than 130mg/dl'),
                                  buildDataRow('2', 'Serum Triglycerides',
                                      '60 - 160 mg/dl', 'Less than 100 mg/dl'),
                                  buildDataRow('3', 'Serum HDL Cholesterol',
                                      '30 - 60 mg/dl', 'More than 40 mg/dl'),
                                  buildDataRow('4', 'Cholesterol: HDL', '4 - 5',
                                      'Below 4 Ratio'),
                                  buildDataRow('5', 'Serum LDL Cholesterol',
                                      '30 - 130 mg/dl', 'Less than 70 mg/dl'),
                                  buildDataRow('6', 'Blood Pressure (systolic)',
                                      '120 - 140 mmHg', '120 mmHg or less'),
                                  buildDataRow('7', 'Blood Pressure (diastolic)',
                                      '70 - 90 mmHg', '80 mmHg or less'),
                                  buildDataRow('8', 'Blood Glucose (Fasting)',
                                      '80 - 110 mg/dl', '70 - 100 mg/dl'),
                                  buildDataRow('9', 'Blood Glucose (PP)',
                                      '120 - 160 mg/dl', 'Less than 140 mg/dl'),
                                  buildDataRow('10', 'Smoking/Tobacco',
                                      'To be reduced', 'Banned'),
                                  buildDataRow(
                                      '11',
                                      'Exercise/Walk',
                                      'Should be done',
                                      'Must do, at least one hour'),
                                  buildDataRow(
                                      '12',
                                      'Weight',
                                      '20 - 30% extra (from any chart)',
                                      'Only 2 - 3 Kg extra allowed permitted from Indian Chart'),
                                  buildDataRow('13', 'Fiber intake',
                                      'Not specified', 'Plenty everyday'),
                                  buildDataRow(
                                      '14',
                                      'Stress',
                                      'Not defined, Not available',
                                      'Clearly defined, optimal'),
                                  buildDataRow('15', 'Total fat intake',
                                      '10 - 30% Calories', '10% of total Calories'),
                                  buildDataRow('16', 'Visible-fat intake',
                                      'PUFA, MUFA etc.', 'Banned'),
                                  buildDataRow('17', 'Cholesterol intake/day',
                                      'Not defined', '10 mg/day'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    clipBehavior:Clip.hardEdge,
                    itemCount: filteredItems.length,
                    physics:const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredItems[index].title.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (filteredItems[index].description!
                                    .contains(','))
                                  ...?filteredItems[index].description?.split(
                                      ',').map(
                                        (desc) =>
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.check_circle,
                                                  color: AppColors
                                                      .primaryColor,
                                                  size: 18),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(textAlign: TextAlign.justify,
                                                  desc.trim(),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ).toList()
                                else
                                  Text(textAlign: TextAlign.start,
                                    filteredItems[index].description.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
TableRow buildDataRow(
    String number, String factor, String usual, String saaol) {
  return TableRow(
    children: [
      buildDataCell(number),
      buildDataCell(factor),
      buildDataCell(usual),
      buildDataCell(saaol),
    ],
  );
}
Widget buildHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 13,
        fontFamily: 'FontPoppins',
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget buildDataCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 12,
          fontFamily: 'FontPoppins',
          fontWeight: FontWeight.w500,
          color: Colors.black54),
      textAlign: TextAlign.center,
    ),
  );
}
