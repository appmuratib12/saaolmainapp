import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Give feedback',
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
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 3,
                child: Container(
                  height: 530,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Review',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Help us improve by telling us how was your experience with',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Dr. Bimal Chhajer',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                            image: AssetImage('assets/images/bima_sir.png'),
                            fit: BoxFit.cover,
                            width: 110,
                            height: 110,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                            size: 7,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Comment...',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () {
                                  Fluttertoast.showToast(msg: 'Click');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryDark),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () {
                                  showThankYouDialog(context);
                                  Fluttertoast.showToast(msg: 'Click');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 14,
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
      ),
    );
  }

  void showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: Colors.blue[200],
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank you!',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your review has been submitted, your feedback is important to us as to the doctors and the community.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.primaryColor,
                size: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
