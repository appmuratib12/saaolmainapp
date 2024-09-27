import 'package:flutter/material.dart';
import '../common/app_colors.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notificationArray = ["Appointment Update","New Service Available","Reschedule Appointment"];
  List<String> notificationArray2 = ["New Feature Available","Appointment Alarm","Appointment Confirmed"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Notifications',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing:0.2,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Today,August 20,2024',
                style:TextStyle(fontSize:16,fontFamily:'FontPoppins',
                  fontWeight:FontWeight.w600,color:Colors.black87),),
              const SizedBox(height:20,),
              SizedBox(
                height:300,
                child: ListView.builder(
                  itemCount: notificationArray2.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical:5),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:80,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.notification_add,
                                    color: AppColors.primaryColor,
                                    size:25,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notificationArray2[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4), // Added space between the texts
                                      const Text(
                                        'Your appointment will start after 15 minutes. Stay with the app and take care of it.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Just now',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height:10,
                            thickness:0.2,
                            color:AppColors.primaryColor,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text('Yesterday,August 18,2024',
                style:TextStyle(fontSize:16,
                  fontFamily:'FontPoppins',fontWeight:FontWeight.w600,color:Colors.black),),
              const SizedBox(height:20,),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: notificationArray2.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical:5),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:80,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.notification_add,
                                    color: AppColors.primaryColor,
                                    size:25,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notificationArray2[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4), // Added space between the texts
                                      const Text(
                                        'Your appointment will start after 15 minutes. Stay with the app and take care of it.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Just now',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height:10,
                            thickness:0.2,
                            color:AppColors.primaryColor,
                          )
                        ],
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
