import 'package:flutter/material.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/PatientInstructionsResponse.dart';
import '../common/app_colors.dart';
import '../data/network/BaseApiService.dart';


class PatientInstructionScreen extends StatefulWidget {
  const PatientInstructionScreen({super.key});

  @override
  State<PatientInstructionScreen> createState() =>
      _PatientInstructionScreenState();
}

class _PatientInstructionScreenState extends State<PatientInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Instructions for Patient's",
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<PatientInstructionsResponse>(
                future: BaseApiService().patientInstructionsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error fetching classes: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data == null ||
                      snapshot.data!.data!.isEmpty) {
                    return const Center(child: Text('No classes available.'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                            child: ExpansionTile(
                              leading: Image.asset(
                                'assets/icons/walk_everyday_icon.png',
                                width: 30,
                                height: 30,
                              ),
                              title: Text(
                                snapshot.data!.data![index].title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    snapshot.data!.data![index].content
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black87,
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
            ],
          ),
        ),
      ),
    );
  }
}
