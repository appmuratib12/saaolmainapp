import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/app_colors.dart';

class HeartHealthAssessmentForm extends StatefulWidget {
  const HeartHealthAssessmentForm({super.key});

  @override
  _HeartHealthAssessmentFormState createState() =>
      _HeartHealthAssessmentFormState();
}

class _HeartHealthAssessmentFormState extends State<HeartHealthAssessmentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // To store the selected answers
  Map<String, String> answers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Assess Risk',
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Heart Health Assessment Form',
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),
              const Text(
                'First Name*',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    hintStyle: const TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon:const Icon(Icons.person,color:AppColors.primaryDark,size:20,),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Email ID*',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    hintStyle: const TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon:const Icon(Icons.email,color:AppColors.primaryDark,size:20,),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Mobile Number*',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    hintStyle: const TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon:const Icon(Icons.call,color:AppColors.primaryDark,size:20,),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600),
                ),
              ),


              const SizedBox(height: 20),
              // Questionnaire
              _buildQuestion(
                  'Do you have high blood pressure?', 'highBloodPressure'),
              _buildQuestion('Do you have diabetes?', 'diabetes'),
              _buildQuestion(
                  'Do you have a family history of heart-related issues?',
                  'familyHistory'),
              _buildQuestion('Are you overweight/obese?', 'overweight'),
              _buildQuestion('Do you smoke?', 'smoke'),
              _buildQuestion(
                  'Do you walk for at least 30 minutes every day?', 'walk'),
              _buildQuestion('Do you eat non-vegetarian food?', 'nonVeg'),
              _buildQuestion(
                  'Do you regularly eat fruits and salads?', 'fruitsSalads'),
              _buildQuestion(
                  'Do you have persistent stress in your daily life?',
                  'stress'),
              _buildQuestion(
                  'Do you have high cholesterol or triglyceride levels?',
                  'cholesterol'),
              SizedBox(height: 20),

              SizedBox(
                height:45,
                width:double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: 'Submit');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 16,
                        letterSpacing:0.3,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 95, // Minimum height to avoid overflow
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.5),width:0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              activeColor: AppColors.primaryDark,
                              // Change radio color here
                              value: 'yes',
                              groupValue: answers[key],
                              onChanged: (value) {
                                setState(() {
                                  answers[key] = value!;
                                });
                              },
                            ),
                            const Text(
                              'Yes',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              activeColor: Colors.red,
                              // Change radio color here
                              value: 'no',
                              groupValue: answers[key],
                              onChanged: (value) {
                                setState(() {
                                  answers[key] = value!;
                                });
                              },
                            ),
                            const Text(
                              'No',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
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
