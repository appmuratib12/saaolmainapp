import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import 'package:saaoldemo/responsemodel/AppointmentDatabaseHelper.dart';
import 'package:saaoldemo/responsemodel/PatientAppointmentModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import 'package:http/http.dart' as http;
import '../data/model/requestmodel/PaymentRecordRequest.dart';
import '../data/network/ChangeNotifier.dart';
import 'ChooseMemberScreen.dart';
import 'PaymentHistoryScreen.dart';

class AppointmentConfirmScreen extends StatefulWidget {
  final String centerID;
  final String centerLocationName;
  final String appointmentDate;
  final String saveTimeValue;
  const AppointmentConfirmScreen({super.key,required this.appointmentDate,
    required this.centerID,required this.centerLocationName, required this.saveTimeValue});

  @override
  State<AppointmentConfirmScreen> createState() =>
      _AppointmentConfirmScreenState();
}

class _AppointmentConfirmScreenState extends State<AppointmentConfirmScreen> {
  bool value = false;
  bool checkedValue = true;
  String getValue = '';
  String getDate = '';
  String getCityName = '';
  String getAppointment = '';
  String getConsultationFees = '';
  String appointmentType = '';
  String getUserName = '';
  String getDataValue = '';
  String getDayValue = '';
  final TextEditingController patientController = TextEditingController(text: 'Mohd Muratib'); // Default value
  late Razorpay razorpay;
  String RazorpayApiKey = 'rzp_test_PpBV2fG1JPCaUQ';
  String mobileNumber = '';
  String totalAmount = '';
  String paidAmount = '';
  String savePaymentID = '';
  String saveOrderID = '';
  String saveSignature = '';
  String patientEmail = '';
  String getOfflineFees = '';
  String fees = '';
  late AppointmentDatabaseHelper appointmentDatabaseHelper;
  
  
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

  void showAutoDismissAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds:4), () {
          Navigator.pop(context);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const MyPurchase(),
            ),
          );

        });
        return Center(
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: CupertinoActivityIndicator(
                color: AppColors.primaryDark,
                radius: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  _saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('PaymentID', savePaymentID.toString());
      print('paymentID:$savePaymentID');
      prefs.setString('orderID', saveOrderID.toString());
      prefs.setString('signatureID', saveSignature.toString());
      prefs.setString('appointmentDate', widget.appointmentDate);
      prefs.setString('appointmentTime', widget.saveTimeValue);
      print('AppointmentSaveDate${widget.appointmentDate}');
    });
  }

   void addPayment() async {
     final appointment = PatientAppointmentModel(
       date: widget.appointmentDate,  // Assume you have these variables
       time: widget.saveTimeValue,
       mode: appointmentType,
       centerLocation:widget.centerLocationName,totalAmount:fees,paymentID:savePaymentID);
     await AppointmentDatabaseHelper().insertAppointment(appointment);
  }



  @override
  void dispose() {
    razorpay.clear(); // Disposing the Razorpay instance
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  /*  appointmentDatabaseHelper = AppointmentDatabaseHelper();
    appointmentDatabaseHelper.initializedDB().whenComplete(() async {
      await addPayment();
      setState(() {});
    });*/
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
  }

  void errorHandler(PaymentFailureResponse response) {
   // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription:
    // ""${response.message}\nMetadata:${response.error.toString()}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message!),
      backgroundColor: Colors.red,
    ));
  }


  void successHandler(PaymentSuccessResponse response) {
    savePaymentID = response.paymentId.toString();
    saveOrderID = response.orderId.toString();
    saveSignature = response.signature.toString();
    if(response.paymentId != null){
        savePayment();
        showAutoDismissAlert(context);
        _saveValue();
         addPayment();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.paymentId!),
          backgroundColor: Colors.green,
        ));
    }
  }
  void externalWalletHandler(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.walletName!),
      backgroundColor: Colors.green,
    ));
  }
  void openCheckout() {
    if(appointmentType == 'Offline'){
       fees = getOfflineFees.toString();
    }else if(appointmentType == 'Online'){
      fees = getConsultationFees.toString();
    }
    var options = {
      "key": "rzp_live_k1Q4kKwidvbaAl",
      "amount":num.parse(fees) * 100,
      "name": "Saaol Health Pvt Ltd",
      "description": "Live Payment",
      "send_sms_hash": true,
      "timeout": "180",
      "currency": 'INR',
      "amount_paid": 0,
      "amount_due": 100,
      "status": "created",
      "attempts": 0,
      "prefill": {
        "contact": "9068544483",
        "email": "mohdmuratib0@gmail.com",
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print('Error opening Razorpay: $e');
    }
  }






  void showAlertDialog(BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
      getDataValue = (prefs.getString('selectedDate') ?? '');
      getDayValue = (prefs.getString('selectedDay') ?? '');
      patientEmail = (prefs.getString(ApiConstants.USER_EMAIL) ?? '');
      patientEmail = (prefs.getString('patientEmail') ?? '');
      getOfflineFees = (prefs.getString('offlineFees') ?? '');
      print('OfflineFees:$getOfflineFees');

    });
  }



  bool isLoading = false;

  final String apiKey = 'b6b01cd4f6d5559eb180cf0e63d26435';
  final String authToken = 'ed5d4f5dda8e9551722b5ae97ff2b5c4';
  final String paymentUrl = 'https://www.instamojo.com/api/1.1/payment-requests/';


  Future<void> savePayment() async {
    final paymentRecordRequest = PaymentRecordRequest(
      appointment_mode: appointmentType,
      total_amount: getConsultationFees,
      pending_amount: '1',
      paid_amount: getConsultationFees,
      email: patientEmail,
      date: widget.appointmentDate,
      txn_id: savePaymentID,
    );

    final provider = Provider.of<DataClass>(context, listen: false);
    await provider.saveUserPaymentRecord(paymentRecordRequest);
    if (provider.isBack && context.mounted) {
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Confirm Appointment',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size:20,),
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
                    padding: const EdgeInsets.all(10),
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
                            Row(
                              children: [
                                Text(widget.appointmentDate,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            const Text('',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
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
                            style:  const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: widget.centerLocationName.toString(),
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
                height: 15,
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
              Padding(
                padding: const EdgeInsets.all(4),
                child: GestureDetector(
                  onTap: () async {
                    // Navigate to Member Selection Screen and await the selected result
                    final selectedPatient = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectMemberScreen(),
                      ),
                    );

                    // Update the TextField with the selected patient
                    if (selectedPatient != null) {
                      setState(() {
                        patientController.text = selectedPatient;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          patientController.text.isEmpty
                              ? 'Select Patient'
                              : patientController.text,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'FontPoppins',
                            color: patientController.text.isEmpty
                                ? Colors.black54
                                : Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 22,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),

              /*   Card(
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
                          onChanged: (value) =>
                              setState(() {
                                _selectedGender = value!;
                              }),
                          items: const ["Mohd Muratib"],
                          itemBuilder: (item) =>
                              RadioButtonBuilder(
                                item,
                              ),
                          activeColor: AppColors
                              .primaryDark, // Change this to your desired active color
                        ),
                        RadioGroup<String>.builder(
                          groupValue: _selectedGender,
                          onChanged: (value) =>
                              setState(() {
                                _selectedGender = value!;
                              }),
                          items: const ["Someone Else"],
                          itemBuilder: (item) =>
                              RadioButtonBuilder(
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
              ),*/
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    if (appointmentType == 'Online') {
                        openCheckout(); // Navigate to payment screen
                    } else if (appointmentType == 'Offline') {
                     /* print('AppointmentTime:${widget.saveTimeValue}');
                      final appointment = PatientAppointmentModel(
                        date: widget.appointmentDate,  // Assume you have these variables
                        time: widget.saveTimeValue,
                        mode: appointmentType,
                        centerLocation:widget.centerLocationName,
                        totalAmount:'2000',
                        paymentID:'543213'
                      );
                      await AppointmentDatabaseHelper().insertAppointment(appointment);
                      _incrementCounter();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppointmentBookScreen(),
                        ),
                      );*/
                      openCheckout();
                    }
                  },
                  child: Text(
                    appointmentType == 'Online' ? 'Pay Now' : 'Confirm Now',
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
