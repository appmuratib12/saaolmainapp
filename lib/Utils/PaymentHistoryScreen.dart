import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class MyPurchase extends StatefulWidget {
  const MyPurchase({super.key});

  @override
  State<MyPurchase> createState() => _HomeState();
}

class _HomeState extends State<MyPurchase> {
  String userEmail = '';
  String userPaymentID = '';
  List<String> paymentDetails = ["Payment1", "Payment2"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
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
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: paymentDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                height: 220,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'assets/images/profile.png'),
                                                    height: 60,
                                                    width: 60,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                const Column(
                                                  children: [
                                                    Text(
                                                      'Coronary Artery Disease',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'Appointment mode: Offline',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black87),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 10,
                                              thickness: 0.2,
                                              color: AppColors.primaryColor,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Dated on',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      '21 Jan 2023',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'FontPoppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets.only(
                                                            left: 85),
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Amount:',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  '₹5000',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14,
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Pending:',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  '₹2000',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14,
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Paid:',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  '₹3000',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14,
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                            Divider(
                                              height: 10,
                                              thickness: 0.2,
                                              color: AppColors.primaryColor,
                                            ),
                                            const Row(
                                              children: [
                                                Text(
                                                  'status:',
                                                  style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'success',
                                                  style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .primaryColor),
                                                ),
                                              ],
                                            ),
                                            const Row(
                                              children: [
                                                Text(
                                                  'Email Id:',
                                                  style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'mohdmuratib0@gmail.com',
                                                  style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .primaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
