import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import 'package:http/http.dart' as http;
import 'MyHomePageScreen.dart';


class AppointmentConfirmScreen extends StatefulWidget {
  const AppointmentConfirmScreen({super.key});

  @override
  State<AppointmentConfirmScreen> createState() =>
      _AppointmentConfirmScreenState();
}

class _AppointmentConfirmScreenState extends State<AppointmentConfirmScreen> {
  String _selectedGender = "Riya Jain";
  bool value = false;
  bool checkedValue = true;
  String getValue = '';
  String getDate = '';
  String getCityName = '';
  String getAppointment = '';
  String getConsultationFees = '';
  String appointmentType = '';
  String getUserName = '';

  Future<void> initiatePayment() async {
    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> paymentData = {
      'purpose': 'Appointment',
      'amount': getConsultationFees,
      'buyer_name': 'Mohd Muratib',
      'email': 'mohdmuratib0@gmail.com',
      'phone': '9068544483',
      'redirect_url': 'https://yourdomain.com/payment/callback',
      'send_email': true,
      'send_sms': true,
      'allow_repeated_payments': false,
    };

    try {
      final response = await http.post(
        Uri.parse(paymentUrl),
        headers: {
          'X-Api-Key': apiKey,
          'X-Auth-Token': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(paymentData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final paymentRequestUrl = responseData['payment_request']['longurl'];
        if (await canLaunch(paymentRequestUrl)) {
          await launch(paymentRequestUrl);
        } else {
          throw 'Could not launch $paymentRequestUrl';
        }
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      getDate = (prefs.getString('scheduleDate') ?? '');
      getCityName = (prefs.getString('cityName') ?? '');
      getValue = (prefs.getString('time') ?? '');
      getAppointment = (prefs.getString('appointMode') ?? '');
      getConsultationFees = (prefs.getString('ConsultationFees') ?? '');
      appointmentType = (prefs.getString('Appointment Type') ?? '');
      getUserName = (prefs.getString('userName') ?? '');
    });
  }


  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('appointmentDate', getDate.toString());
      prefs.setString('appointmentTime',  getValue.toString());
    });
  }


  bool isLoading = false;

  final String apiKey = 'b6b01cd4f6d5559eb180cf0e63d26435';
  final String authToken = 'ed5d4f5dda8e9551722b5ae97ff2b5c4';
  final String paymentUrl =
      'https://www.instamojo.com/api/1.1/payment-requests/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          '',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
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
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.asset(
                                  'assets/images/bima_sir.png',
                                  width: 70.0,
                                  height: 70.0,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dr. Bimal Chhajer',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                const Text(
                                  'MBBS, MD | Heart Specialist',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (appointmentType == 'Online') ...[
                                  Text(
                                    "Consultation Fees: $getConsultationFees",
                                    style: const TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                ],
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 0.3,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Date & Time',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Expanded(child: Container()),
                            Column(
                              children: [
                                Text("$getDate,2024",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(getValue,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Appointment mode: ",
                            style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: appointmentType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Center Location: ",
                            style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: getCityName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'This is in-clinic appointment for:',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                  height: 170,
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
                        RadioGroup<String>.builder(
                          groupValue: _selectedGender,
                          onChanged: (value) => setState(() {
                            _selectedGender = value!;
                          }),
                          items: const ["Mohd Muratib"],
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                          activeColor: AppColors
                              .primaryDark, // Change this to your desired active color
                        ),
                        RadioGroup<String>.builder(
                          groupValue: _selectedGender,
                          onChanged: (value) => setState(() {
                            _selectedGender = value!;
                          }),
                          items: const ["Someone Else"],
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                          activeColor: AppColors
                              .primaryDark, // Change this to your desired active color
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.value = value!;
                                });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                "Send me Updates On Whatsapp.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  onPressed: () {
                    //initiatePayment();
                    _incrementCounter();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const HomePage(initialIndex:0),
                      ),
                    );
                  },
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
