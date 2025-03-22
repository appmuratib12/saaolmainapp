import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saaoldemo/Utils/UploadPrescriptionScreen.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CRMLabTestResponse.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';



class LabTestScreen extends StatefulWidget {
  const LabTestScreen({super.key});

  @override
  State<LabTestScreen> createState() => _LabTestScreenState();
}

class _LabTestScreenState extends State<LabTestScreen> {
  List<String> labTestArray = [
    "KFT with Uric Acid",
    "LFT",
    "Serum Electrolyte",
    "Troponin -T",
    "Troponin -I",
    "Cardiac marker(CPK)",
    "Cardiac marker(CKMB)",
    "Cardiac marker(HOMOCYSTEINE)",
    "CRP",
  ];

  int cartCount = 0;
  double cartTotal = 0;
  List<bool> inCart = [false, false, false, false, false];
  List<int> addedItems = [];
  late double price;


  // To simulate making a phone call
  _makingPhoneCall() async {
    var url = Uri.parse("tel:8447776000");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  void sendWhatsAppMessage(String message) async {
    String phoneNumber = "9068544483"; // Add the recipient's phone number (without '+').
    var whatsappUrl = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }


  void addToCart(int index, double price) {
    setState(() {
      if (!addedItems.contains(index)) {
        addedItems.add(index);
        cartCount += 1;
        cartTotal += price;
      }
    });
    Fluttertoast.showToast(msg: "Item added to cart");
  }

  /*void addToCart(int index) {
    setState(() {
      inCart[index] = true;
      cartCount += 1;
      cartTotal += prices[index];
    });
    Fluttertoast.showToast(msg: "Item added to cart");
  }*/

  void removeFromCart(int index, double price) {
    setState(() {
      addedItems.remove(index);
      cartCount -= 1;
      cartTotal -= price;
    });
    Fluttertoast.showToast(msg: "Item removed from cart");
  }

  /* void removeFromCart(int index) {
    setState(() {
      inCart[index] = false;
      cartCount -= 1;
      cartTotal -= prices[index];
    });
    Fluttertoast.showToast(msg: "Item removed from cart");
  }*/

  
  void showCart() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tests/Packages added',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'FontPoppins',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (addedItems.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: addedItems.length,
                      itemBuilder: (context, index) {
                        int itemIndex = addedItems[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/lab_test.jpg',
                              height: 60,
                              width: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            labTestArray[itemIndex],
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          subtitle: const Text(
                            'Contains X tests',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.black87,
                              size: 25,
                            ),
                            onPressed: () {
                              setState(() {
                                removeFromCart(itemIndex, price);
                              });
                            },
                          ),
                        );
                      },
                    )
                  else
                    const Center(
                      child: Text(
                        'No items in the cart',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'LAB TEST',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: Colors.white,
                onPressed: () {
                  // Handle shopping cart icon click
                },
              ),
              if (cartCount > 0)
                Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Lab Test with SAAOL',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height:10,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/female_dcotor.png'),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not sure which test to book?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Free Online Consult with Doctors',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_circle_right,
                            color: AppColors.primaryDark,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:10,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey.shade300),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "OR YOU CAN ORDER VIA",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FontPoppins',
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            // WhatsApp Button
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.call,
                                color: AppColors.primaryDark,
                                size: 20,
                              ),
                              label: const Text(
                                "WhatsApp",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                sendWhatsAppMessage("Hello, I would like to place an order.");
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),

                            // Prescription Button
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 20,
                              ),
                              label: const Text(
                                "Prescription",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                      const UploadPrescriptionScreen()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),

                            // Call Button
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.black,
                                size: 20,
                              ),
                              label: const Text(
                                "Call",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  FutureBuilder<CRMLabTestResponse>(
                    future: BaseApiService().getLabTestRecord(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        snapshot.data!.data!.sort((a, b) => a.testName.toString().compareTo(b.testName.toString()));
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isInCart = addedItems.contains(index);
                            double price;

                            try {
                              price = double.parse(snapshot.data!.data![index].totalPrice.toString());
                            } catch (e) {
                              price = 0.0;
                            }

                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.4),
                                      width: 0.4,
                                    ),
                                  ),
                                  height: 210,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset('assets/images/lab_test.jpg'
                                                  .toString(),
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.data![index].testName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '₹${price.toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: '₹399 ',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'FontPoppins',
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: '25% OFF',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: SizedBox(
                                                    height: 37,
                                                    child: isInCart
                                                        ? ElevatedButton.icon(
                                                            onPressed: () {
                                                              removeFromCart(
                                                                  index, price);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              side:
                                                                  const BorderSide(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                width: 0.4,
                                                              ),
                                                            ),
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color: AppColors
                                                                  .primaryDark,
                                                              size: 20,
                                                            ),
                                                            label: const Text(
                                                              'Remove',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'FontPoppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          )
                                                        : ElevatedButton(
                                                            onPressed: () {
                                                              addToCart(
                                                                  index, price);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .primaryDark,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'FontPoppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        height: 30,
                                        thickness: 1,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.fastfood,
                                                  color: Colors.grey),
                                              SizedBox(width: 5),
                                              Text(
                                                'Fasting required',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.list_alt,
                                                  color: Colors.grey),
                                              SizedBox(width: 5),
                                              Text(
                                                "Report in 24 hours",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
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
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Center(
                          child: Container(
                            width: 60, // Set custom width
                            height:60, // Set custom height
                            decoration: BoxDecoration(
                              color:AppColors.primaryColor.withOpacity(0.1), // Background color for the progress indicator
                              borderRadius: BorderRadius.circular(30), // Rounded corners
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor, // Custom color
                                strokeWidth:6, // Set custom stroke width
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          if (cartCount > 0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹${cartTotal.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text: '₹900 ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FontPoppins',
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const TextSpan(
                                text: '25% OFF',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*Text(
                          '₹${cartTotal.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),*/
                        Row(
                          children: [
                            Text(
                              '$cartCount Items',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'FontPoppins',
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                showCart();
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: 'Proceed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Proceed To Cart',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'FontPoppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                onPressed: () {
                  _makingPhoneCall();
                  Fluttertoast.showToast(msg: 'Call');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
