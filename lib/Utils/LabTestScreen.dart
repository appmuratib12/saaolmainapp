import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    "KFT with Uric Acid",
    "KFT with Uric Acid",
    "KFT with Uric Acid",
    "KFT with Uric Acid",
  ];

  int cartCount = 0;
  double cartTotal = 0;

  // Dummy prices for each item
  List<double> prices = [299, 299, 299, 299, 299];

  // Track which items are in the cart
  List<bool> inCart = [false, false, false, false, false];
  List<int> addedItems = [];

  // To simulate making a phone call
  _makingPhoneCall() async {
    var url = Uri.parse("tel:8447776000");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void addToCart(int index) {
    setState(() {
      if (!addedItems.contains(index)) {
        addedItems.add(index);
        cartCount += 1;
        cartTotal += prices[index];
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

  void removeFromCart(int index) {
    setState(() {
      addedItems.remove(index);
      cartCount -= 1;
      cartTotal -= prices[index];
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
                                removeFromCart(itemIndex);
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
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
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
                    height: 15,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Image(
                            image:
                                AssetImage('assets/images/female_dcotor.png'),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Not sure which test to book?',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              Text(
                                'Free Online Consult with Doctors',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.arrow_circle_right,
                            color: AppColors.primaryDark,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 800,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: labTestArray.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        bool isInCart = addedItems.contains(index);
                        return InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: 'Click');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
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
                              height: 200,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/images/lab_test.jpg',
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
                                              labTestArray[index],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '₹299 ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '₹399 ',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'FontPoppins',
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '25% OFF',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                height: 37,
                                                child: isInCart
                                                    ? ElevatedButton.icon(
                                                        onPressed: () {
                                                          removeFromCart(index);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                side: const BorderSide(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    width:
                                                                        0.4)),
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
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      )
                                                    : ElevatedButton(
                                                        onPressed: () {
                                                          addToCart(index);
                                                        },
                                                        style: ElevatedButton
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
                                                                FontWeight.w600,
                                                            color: Colors.white,
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
                                            'Reports in 15 Hrs',
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
                    ),
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
