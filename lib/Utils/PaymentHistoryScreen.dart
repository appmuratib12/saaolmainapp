import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import 'package:saaoldemo/responsemodel/AppointmentDatabaseHelper.dart';
import '../common/app_colors.dart';
import '../responsemodel/PatientAppointmentModel.dart';

class MyPurchase extends StatefulWidget {
  const MyPurchase({super.key});

  @override
  State<MyPurchase> createState() => _HomeState();
}

class _HomeState extends State<MyPurchase> {
  String userEmail = '';
  String userPaymentID = '';
  List<String> paymentDetails = ["Payment1", "Payment2"];
  late Future<List<PatientAppointmentModel>> medicineList;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userPaymentID = (prefs.getString('PaymentID') ?? '');
      userEmail = (prefs.getString(ApiConstants.USER_EMAIL) ?? '');
      userEmail = (prefs.getString('GoogleUserEmail') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
    medicineList = AppointmentDatabaseHelper().getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Payment History',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (userPaymentID.isEmpty) ...[
                const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment_outlined,
                        color: AppColors.primaryDark,
                        size: 35,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'No Payment History...',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ] else ...[
                SizedBox(
                  height: 600,
                  child: FutureBuilder<List<PatientAppointmentModel>>(
                    future: medicineList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Payment Saved!'));
                      } else {
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final appointment = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: const Image(
                                              image: AssetImage('assets/images/profile.png'),
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  appointment.centerLocation.toString(),
                                                  style: const TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  'Appointment mode: ${appointment.mode}',
                                                  style: const TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        height: 10,
                                        thickness: 0.2,
                                        color: AppColors.primaryColor,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Dated on',
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                appointment.date.toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                               const Text(
                                                'Paid Amount',
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(snapshot.data![index].totalAmount.toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        height: 10,
                                        thickness: 0.2,
                                        color: AppColors.primaryColor,
                                      ),
                                       Row(
                                        children: [
                                          const Text(
                                            'Status:',
                                            style: TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data![index].paymentID.isNotEmpty ? 'Success' : 'Failed',
                                            style: TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: snapshot.data![index].paymentID.isNotEmpty
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                       Row(
                                        children: [
                                          const Text(
                                            'Email Id:',
                                            style: TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text('mohdmuratib0@gmail.com',
                                            style: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
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
