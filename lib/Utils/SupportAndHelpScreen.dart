import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';



class SupportAndHelpScreen extends StatefulWidget {
  const SupportAndHelpScreen({super.key});

  @override
  State<SupportAndHelpScreen> createState() => _SupportAndHelpScreenState();
}

class _SupportAndHelpScreenState extends State<SupportAndHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Support & Help',
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
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const Image(
                    image: AssetImage('assets/icons/call_icon.png'),
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Hello,How Can we\n Help you?',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 2,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            iconSize: 22,
                            icon: const Icon(
                              Icons.call,
                              color: AppColors.primaryDark,
                            ),
                            onPressed: () {
                              Fluttertoast.showToast(msg: 'Call');
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Our Customer Service',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '011-44732744',
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        )

                        /* Image(
                          image: AssetImage('assets/icons/support_icon.png'),
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Contact Live Chat',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        )*/
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 1,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/icons/email_icon.png'),
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sent us an E-mail',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              'info@saaol.com',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 1,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/icons/email_icon.png'),
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Sent us an E-mail',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        )
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
}
