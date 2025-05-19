import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saaolapp/Utils/UploadPrescriptionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/model/apiresponsemodel/PrescriptionResponse.dart';
import '../data/model/apiresponsemodel/SafetyCircleValuesResponse.dart';
import '../data/network/BaseApiService.dart';
import 'DietPlanScreen.dart';
import 'WebViewScreen.dart';


class StatesData extends StatefulWidget {
  final String patientID;

  const StatesData({super.key, required this.patientID});

  @override
  State<StatesData> createState() => _StatesDataState();
}

class _StatesDataState extends State<StatesData> {
  String getPatientID = '';
  String patientUniqueID = '';
  String? url;
  String tcmID = '';
  late SharedPreferences sharedPreferences;

  String formatDate(String dateTimeString) {
    final DateTime parsedDate = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    _loadPatientID();
  }

  Future<void> _loadPatientID() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = (sharedPreferences.getString('pmId') ?? '');
      patientUniqueID = (sharedPreferences.getString('patientUniqueID') ?? '');
      print('PatientUniqueID:-->$patientUniqueID');
    });
  }

  Future<void> _saveTcmID(String tcmID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiConstants.TCM_ID, tcmID);
    print('tcmID saved: $tcmID');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'View Prescription',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing: 0.2,
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
        child:Padding(padding: const EdgeInsets.all(6),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (getPatientID.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: FutureBuilder<PrescriptionResponse>(
                  future: BaseApiService().getPatientPrescription(getPatientID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error prescription : ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data == null ||
                        snapshot.data!.data!.isEmpty) {
                      return const Center(
                          child: Text('No prescription available.'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String tcmID =
                          snapshot.data!.data![index].tcmId.toString();
                          _saveTcmID(tcmID);
                          String date = formatDate(
                              snapshot.data!.data![index].tcmDatetime.toString());

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              elevation:2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:Colors.white
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Prescription ID:",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily:'FontPoppins',
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                        Text(snapshot.data!.data![index].pmId.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        color: Colors.blueAccent, thickness: 0.5),
                                    const SizedBox(height: 8),
                                    DemoScreen(
                                        tcmID: tcmID,
                                        getPatientID: getPatientID,
                                        patientUniqueID: patientUniqueID,
                                        date: date),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),),
            ] else ...[
              /*const SizedBox(
                height: 150,
              ),
              const Center(
                child: Text(
                  'No Existing data available',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    color: AppColors.primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),*/
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation:2,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryDark.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Consult with prescription',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FontPoppins',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Upload a prescription for your recommended consultations.',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'FontPoppins',
                                fontSize: 11,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 14),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                      const UploadPrescriptionScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryDark.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/icons/prescription_icon.png'),
                                      width: 18,
                                      height: 18,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Upload Prescription',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
           ],
         ),
        ),
      ),
    );
  }
}

class SafetyCircleSection extends StatefulWidget {
  final String tcmID;
  final String getPatientID;
  final String patientUniqueID;

  const SafetyCircleSection({
    super.key,
    required this.tcmID,
    required this.getPatientID,
    required this.patientUniqueID,
  });

  @override
  _SafetyCircleSectionState createState() => _SafetyCircleSectionState();
}

class _SafetyCircleSectionState extends State<SafetyCircleSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Safety circle parameters',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.primaryColor,
                ),
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          if (isExpanded)
            FutureBuilder<SafetyCircleValuesResponse>(
              future: BaseApiService().getSafetyCircleZoneValues('MTI3NjM='),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      width: 50, // Set custom width
                      height: 50, // Set custom height
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        // Background color for the progress indicator
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor, // Custom color
                          strokeWidth: 4, // Set custom stroke width
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final response = snapshot.data!;
                  if (response.safetyRedZoneParam == null &&
                      response.safetyYellowZoneParam == null &&
                      response.safetyGreenZoneParam == null) {
                    return const Center(child: Text('No data available.'));
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    padding: const EdgeInsets.all(8),
                    children: [
                      if (response.safetyRedZoneParam != null &&
                          response.safetyRedZoneParam!.isNotEmpty)
                        buildZoneSection(
                          "Red Zone Parameters",
                          response.safetyRedZoneParam!,
                          Colors.red.shade100,
                        ),
                      const Divider(
                          height: 40, thickness: 5, color: Colors.red),
                      if (response.safetyYellowZoneParam != null &&
                          response.safetyYellowZoneParam!.isNotEmpty)
                        buildZoneSection(
                          "Yellow Zone Parameters",
                          response.safetyYellowZoneParam!,
                          Colors.yellow.shade100,
                        ),
                      const Divider(
                          height: 40, thickness: 5, color: Colors.yellow),
                      if (response.safetyGreenZoneParam != null &&
                          response.safetyGreenZoneParam!.isNotEmpty)
                        buildZoneSection(
                          "Green Zone Parameters",
                          response.safetyGreenZoneParam!,
                          Colors.green.shade100,
                        ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No data found.'));
                }
              },
            ),
        ],
      ),
    );
  }

  Widget buildZoneSection(String title, List<String> items, Color color) {
    Color titleColor;
    // Determine title color based on title
    if (title.contains("Red")) {
      titleColor = Colors.red;
    } else if (title.contains("Yellow")) {
      titleColor = Colors.yellow[800] ?? Colors.yellow;
    } else if (title.contains("Green")) {
      titleColor = Colors.green;
    } else {
      titleColor = Colors.black; // Default color
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
        ),
        ...items.map((item) => buildZoneItem(item, color)).toList(),
      ],
    );
  }

  // Helper method to build each item in the zone
  Widget buildZoneItem(String item, Color color) {
    String formattedItem = item
        .replaceAll('_', ' ') // Replace underscores with spaces
        .split(' ') // Split into words
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : word) // Capitalize each word
        .join(' '); // Join the words back into a sentence

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        formattedItem,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'FontPoppins',
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildParameterRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                value ?? 'N/A',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoScreen extends StatefulWidget {
  final String tcmID;
  final String getPatientID;
  final String patientUniqueID;
  final String date;

  const DemoScreen(
      {super.key,
      required this.tcmID,
      required this.getPatientID,
      required this.patientUniqueID,
      required this.date});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  late SharedPreferences sharedPreferences;

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 20,
            ),
          ),
        ),
      ),
    );
  }

  void handleUrlOpening(
      String tcmID, String getPatientID, String patientUniqueID,
      {bool isSafetyCircle = false}) {
    String encodedTcmID = base64Encode(utf8.encode(tcmID));
    print('CheckTCMID:$encodedTcmID');
    String encodedGetPatientID = base64Encode(utf8.encode(getPatientID));
    String encodedPatientUniqueID = base64Encode(utf8.encode(patientUniqueID));

    String url = isSafetyCircle
        ? 'https://crm.saaol.com/safety_circle_page.php?pdf_id=MTI3NjM&p_id=MTk2MjE&pu_id=T1AtMjk2MTU&app_id=5DCAD06B90925BE3D750837F392A8FC6'
        : 'https://crm.saaol.com/haps_score.php?pdf_id=$encodedTcmID&p_id=$encodedGetPatientID&pu_id=$encodedPatientUniqueID&app_id=5DCAD06B90925BE3D750837F392A8FC6';

    _showLoadingDialog();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Close loading dialog
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url),
        ),
      );
    });
  }

  void handleHapReport(
      String tcmID, String getPatientID, String patientUniqueID) {
    String encodedTcmID = base64Encode(utf8.encode(tcmID));
    String encodedGetPatientID = base64Encode(utf8.encode(getPatientID));
    String encodedPatientUniqueID = base64Encode(utf8.encode(patientUniqueID));
    String url =
        'https://crm.saaol.com/view_casemanager.php?pdf_id=$encodedTcmID&p_id=$encodedGetPatientID&pu_id=$encodedPatientUniqueID&app_id=5DCAD06B90925BE3D750837F392A8FC6';

    _showLoadingDialog();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Close loading dialog
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url),
        ),
      );
    });
  }

  _incrementCounter() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString('tcmID', widget.tcmID);
      print('storeTCMID:${widget.tcmID}');
    });
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Appointment Date:',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.date.toString(),
                style: const TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Expanded(child: Container()),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          if (isExpanded)
            Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    handleHapReport(widget.tcmID, widget.getPatientID,
                        widget.patientUniqueID);
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'View Prescription',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 40, thickness: 5, color: Colors.lightBlue[100]),
                _buildReportButton(
                  context,
                  "View Haps Report",
                  widget.tcmID,
                  widget.getPatientID,
                  widget.patientUniqueID,
                ),
                Divider(height: 40, thickness: 5, color: Colors.lightBlue[100]),
                _buildReportButton(
                  context,
                  "View Safety Circle",
                  widget.tcmID,
                  widget.getPatientID,
                  widget.patientUniqueID,
                  isSafetyCircle: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SafetyCircleSection(
                    tcmID: widget.tcmID,
                    getPatientID: widget.getPatientID,
                    patientUniqueID: widget.patientUniqueID,
                  ),
                ),
                Divider(height: 20, thickness: 5, color: Colors.lightBlue[100]),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                DietPlanScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.next_plan,
                        color: Colors.white),
                    label: const Text('Recommended Diet Plain',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Divider(height: 20, thickness: 5, color: Colors.lightBlue[100]),
                const SizedBox(height: 10),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildReportButton(
    BuildContext context,
    String label,
    String tcmID,
    String getPatientID,
    String patientUniqueID, {
    bool isSafetyCircle = false,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          handleUrlOpening(
              widget.tcmID, widget.getPatientID, widget.patientUniqueID,
              isSafetyCircle: isSafetyCircle);
          _incrementCounter();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(Icons.remove_red_eye_rounded, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
