import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../common/app_colors.dart';
import 'AppointmentDetailsScreen.dart';

class AppointmentBookScreen extends StatefulWidget {
  const AppointmentBookScreen({super.key});

  @override
  State<AppointmentBookScreen> createState() => _AppointmentBookScreenState();
}

class _AppointmentBookScreenState extends State<AppointmentBookScreen> {
  List<String> appointmentArray = ["Upcoming", "Upcoming","Upcoming","Upcoming"];
  int initialLabelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'My Appointments',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ToggleSwitch(
              minWidth: double.infinity,
              cornerRadius: 20.0,
              activeBgColors: const [
                [AppColors.primaryDark],
                [AppColors.primaryDark],
                [AppColors.primaryDark],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.blue[50],
              inactiveFgColor: AppColors.primaryDark,
              initialLabelIndex: initialLabelIndex,
              totalSwitches: 3,
              labels: const [
                'Upcoming',
                'Completed',
                'Cancelled',
              ],
              customTextStyles: const [
                TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
                TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
                TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
              ],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  initialLabelIndex = index!;
                });
                print('switched to: $index');
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: appointmentArray.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                          const AppointmentDetailScreen()),
                    );
                    Fluttertoast.showToast(msg: 'Click');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 185,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Image(
                                          image: AssetImage('assets/images/bima_sir.png'),
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dr.Bimal Chhajer',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Heart Specialist',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage('assets/icons/star.png'),
                                                width: 10,
                                                height: 10,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 3),
                                              Image(
                                                image: AssetImage('assets/icons/star.png'),
                                                width: 10,
                                                height: 10,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 3),
                                              Image(
                                                image: AssetImage('assets/icons/star.png'),
                                                width: 10,
                                                height: 10,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 3),
                                              Image(
                                                image: AssetImage('assets/icons/star.png'),
                                                width: 10,
                                                height: 10,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 3),
                                              Image(
                                                image: AssetImage('assets/icons/star.png'),
                                                width: 10,
                                                height: 10,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor.withOpacity(0.2),
                                        ),
                                        child: const Icon(
                                          Icons.call,
                                          color: AppColors.primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    height: 10,
                                    thickness: 0.2,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Monday, July 12',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.access_time,
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '11:00pm to 12:00pm',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            side: const BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          onPressed: () {
                                            Fluttertoast.showToast(msg: 'click');
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        height: 35,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primaryDark,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          onPressed: () {
                                            Fluttertoast.showToast(msg: 'click');
                                          },
                                          child: const Text(
                                            'Reschedule',
                                            style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
    );
  }
}