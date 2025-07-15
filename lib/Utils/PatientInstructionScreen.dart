import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/PatientInstructionsResponse.dart';
import '../data/network/BaseApiService.dart';


class PatientInstructionScreen extends StatefulWidget {
  const PatientInstructionScreen({super.key});

  @override
  State<PatientInstructionScreen> createState() =>
      _PatientInstructionScreenState();
}

class _PatientInstructionScreenState extends State<PatientInstructionScreen> {
  int? _expandedTileIndex;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200], // Use a soft background
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        title: const Text(
          "Patient Instructions",
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<PatientInstructionsResponse>(
          future: BaseApiService().patientInstructionsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final errorMessage = snapshot.error.toString();
              if (errorMessage.contains('No internet connection')) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off_rounded,
                          size:30,
                          color: Colors.redAccent,
                        ),
                        SizedBox(height:8),
                        Text(
                          'No Internet Connection',
                          style: TextStyle(
                            fontSize:14,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Please check your network settings and try again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:12,
                            fontFamily: 'FontPoppins',
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('Error: $errorMessage'));
              }
            } else if (!snapshot.hasData ||
                snapshot.data!.data == null ||
                snapshot.data!.data!.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        'No instructions available.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please check back later. New data will be available soon!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'FontPoppins',
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.data!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final instruction = snapshot.data!.data![index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading:const Icon(Icons.circle, size:4, color: Colors.black87),
                        title: Text(
                          instruction.title.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            _expandedTileIndex = isExpanded ? index : null;
                          });
                        },
                        initiallyExpanded: _expandedTileIndex == index,
                        children: [
                          Text(
                            instruction.content.toString(),
                            style: const TextStyle(
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              height: 1.5,
                              color: Colors.black87,
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
    );
  }
}
