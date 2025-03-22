import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/DiseaseResponseData.dart';
import '../data/network/BaseApiService.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Disease Screen',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Diseases We Treat',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Expanded(child: Container()),
                const Text(
                  'View All',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Upcoming Appointment',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    // Add navigation or action for 'View All'
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            // The GridView is now part of the scrollable content.
            FutureBuilder<DiseaseResponseData>(
              future: BaseApiService().getDiseaseData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    shrinkWrap: true, // Ensures the GridView is part of the scrollable content
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Add navigation or action for the grid item
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Center(
                                  child: Image.network(
                                    snapshot.data!.data![index].icon.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Expanded(
                              child: Text(
                                snapshot.data!.data![index].title.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Row(
              children: [
                const Text(
                  'Diseases We Treat',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Expanded(child: Container()),
                const Text(
                  'View All',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(height:20,),
            Row(
              children: [
                const Text(
                  'Upcoming Appointment',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    // Add navigation or action for 'View All'
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height:20,),
            Row(
              children: [
                const Text(
                  'Diseases We Treat',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Expanded(child: Container()),
                const Text(
                  'View All',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(height:20,),
            Row(
              children: [
                const Text(
                  'Upcoming Appointment',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    // Add navigation or action for 'View All'
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height:20,)
          ],
        ),
      ),
    );
  }
}
