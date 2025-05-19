import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_colors.dart';
import '../../data/model/apiresponsemodel/AccessRiskQuestionsResponse.dart';
import '../../data/model/requestmodel/AccessRiskAnswerRequest.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/ChangeNotifier.dart';

class HeartHealthAssessmentForm extends StatefulWidget {
  const HeartHealthAssessmentForm({super.key});

  @override
  _HeartHealthAssessmentFormState createState() =>
      _HeartHealthAssessmentFormState();
}

class _HeartHealthAssessmentFormState extends State<HeartHealthAssessmentForm> {
  final _formKey = GlobalKey<FormState>();

  late Future<AccessRiskQuestionsResponse> futureQuestions;
  Map<String, String> answers = {};
  String? getName;
  String? getEmail;
  String? getMobile;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    futureQuestions = BaseApiService().getRiskQuestions();
  }

  String storeID = '';
  String question1 = '';

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getName = sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
      getEmail = sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '';
      getMobile = sharedPreferences.getString(ApiConstants.USER_MOBILE) ?? '';
      getName = sharedPreferences.getString(ApiConstants.USER_MOBILE) ?? '';
      getMobile = sharedPreferences.getString(ApiConstants.USER_MOBILE) ?? '';
      getMobile = sharedPreferences.getString(ApiConstants.USER_MOBILE) ?? '';

    });
  }


  void showAutoDismissAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismissing by tapping outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(
                  color: AppColors.primaryDark,
                  radius: 20,
                ),
                SizedBox(height: 20),
                Text(
                  'Add member...',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FontPoppins'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> addRiskAnswer(String questionId, String selectedAnswer) async {
    showAutoDismissAlert(context);
    AccessRiskAnswerRequest accessRiskAnswerRequest = AccessRiskAnswerRequest(
      question: questionId,
      answer: selectedAnswer,
    );

    var provider = Provider.of<DataClass>(context, listen: false);
    try {
      await provider.accessRiskAnswer(accessRiskAnswerRequest);
      if (provider.isBack) {
        _showMessage('Member added successfully.');
      } else {
        _showMessage('Failed to add member. Please try again.');
      }
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss the dialog on error
      print('Error adding member: $e');
      _showMessage('An error occurred. Please try again later.');
    } finally {
      Navigator.of(context).pop(); // Dismiss the dialog after the API call completes
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Assess Risk',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Heart Health Assessment Form',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'First Name',
                    style: TextStyle(
                        fontSize:14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height:50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Icon(
                          Icons.person,
                          color: AppColors.primaryDark,
                          size: 20,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Email ID',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email ID',
                        hintStyle: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Icon(
                          Icons.email,
                          color: AppColors.primaryDark,
                          size: 20,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Mobile Number',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        hintStyle: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Icon(
                          Icons.call,
                          color: AppColors.primaryDark,
                          size: 20,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        filled: true,
                        fillColor: Colors.white
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            FutureBuilder<AccessRiskQuestionsResponse>(
              future: futureQuestions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    snapshot.data!.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return const Center(child: Text('No questions available.'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      final question = snapshot.data!.data![index].question.toString();
                      question1 = question.toString();
                      return InkWell(
                        onTap: () {
                          storeID = snapshot.data!.data![index].id.toString();

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 95),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    question,
                                    style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 13,
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
                                              activeColor:
                                                  AppColors.primaryDark,
                                              value: 'yes',
                                              groupValue: answers[question],
                                              onChanged: (value) {
                                                setState(() {
                                                  answers[question] = value!;
                                                  storeID = snapshot.data!.data![index].id.toString();
                                                  print('storeID:$storeID');

                                                });
                                              },
                                            ),
                                            const Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Radio<String>(
                                              activeColor: Colors.red,
                                              value: 'no',
                                              groupValue: answers[question],
                                              onChanged: (value) {
                                                setState(() {
                                                  answers[question] = value!;
                                                  storeID = snapshot.data!.data![index].id.toString();
                                                  print('store:$storeID');
                                                });
                                              },
                                            ),
                                            const Text(
                                              'No',
                                              style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
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
                        ),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (storeID.isNotEmpty && answers.containsKey(question1)) {
                    addRiskAnswer(storeID, answers[question1]!);
                  } else {
                    Fluttertoast.showToast(msg: 'Please select answers.');
                  }
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
                      fontSize: 15,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
