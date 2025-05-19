import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../DialogHelper.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';
import '../../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../../data/network/BaseApiService.dart';
import '../AppointmentsScreen.dart';

class LifeStylePageScreen extends StatefulWidget {
  final String id;
  const LifeStylePageScreen({super.key,required this.id});

  @override
  State<LifeStylePageScreen> createState() => _LifeStylePageScreenState();
}

class _LifeStylePageScreenState extends State<LifeStylePageScreen> {

  final List<IconData> icons = [
    Icons.restaurant,
    Icons.directions_run,
    Icons.smoking_rooms,
    Icons.spa,
    Icons.eco,
    Icons.favorite_border,
  ];

  final List<String> titles = [
    'Holistic Nutrition',
    'Active Lifestyle',
    'Freedom from Tobacco',
    'Stress Management',
    'Sustainable Lifestyle Transformations',
    'Routine Health Assessments',
  ];

  final List<String> subtitles = [
    "The foundation of your heart's well-being begins with dietary choices.",
    "Consistent 30 minutes of activity keeps your heart strong.",
    "Avoiding tobacco is critical for heart vitality.",
    "Meditation and heart yoga help reduce stress.",
    "Long-term changes make a healthier you.",
    "Monitor blood pressure and cholesterol to manage risk.",
  ];

  final List<bool> isCompleted = [
    true, true, false, false, false, false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        children: [

          FutureBuilder<TreatmentsDetailResponseData>(
            future: BaseApiService().getTreatmentDetailsData(widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    width: 60, // Set custom width
                    height:60, // Set custom height
                    decoration: BoxDecoration(
                      color:AppColors.primaryColor.withOpacity(0.1), // Background color for the progress indicator
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor, // Custom color
                        strokeWidth:6, // Set custom stroke width
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error loading data"),
                );
              } else if (snapshot.hasData) {
                var lifeStyle = snapshot.data!.data!;
                return Stack(
                  children: [
                    SizedBox(
                      height:260,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(lifeStyle.chooseDescriptionImage.toString()
                          .toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top:30, // Adjust according to your app bar height / status bar
                      left:10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,size:22,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 220.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                               Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Embrace Heart Wellness',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.primaryColor),
                                    ),
                                    const Text(
                                      'Heart Yoga and a Healthy Lifestyle for Your Heart',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      lifeStyle.description.toString().trim(),
                                      style: const TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 13,
                                          letterSpacing:0.2,
                                          height:1.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 15,
                                thickness: 5,
                                color: AppColors.primaryColor
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Our Main Treatment',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                     Text(lifeStyle.advantage.toString().trim(),
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 13,
                                          letterSpacing:0.2,
                                          height:1.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ListView.builder(
                                      itemCount: titles.length,
                                      physics:const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      clipBehavior:Clip.hardEdge,
                                      itemBuilder: (context, index) {
                                        return _buildTimelineTile(
                                          icon: icons[index],
                                          title: titles[index],
                                          subTitle: subtitles[index],
                                          isCompleted: isCompleted[index],
                                          isLast: index == titles.length - 1,
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text("No data found"));
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        width: 0.4, color: Colors.grey.withOpacity(0.6)),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const MyAppointmentsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                onPressed: () {
                  DialogHelper.makingPhoneCall(Consulation_Phone);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTimelineTile({
    required IconData icon,
    required String title,
    required bool isCompleted,
    required String subTitle,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? AppColors.primaryColor.withOpacity(0.2)
                      :AppColors.primaryColor.withOpacity(0.2)
                ),
                child: Icon(
                  icon,
                  color: isCompleted ? AppColors.primaryColor :AppColors.primaryColor,
                  size: 24,
                ),
              ),
              if (!isLast)
                Container(
                  height: 60,
                  width: 2,
                  color: isCompleted
                      ? AppColors.primaryColor
                      : AppColors.primaryColor,
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize:14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subTitle,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
