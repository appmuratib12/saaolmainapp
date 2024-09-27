import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class BooksHealthScreen extends StatefulWidget {
  const BooksHealthScreen({super.key});

  @override
  State<BooksHealthScreen> createState() => _BooksHealthScreenState();
}

class _BooksHealthScreenState extends State<BooksHealthScreen> {
  List<String> booksArray = [
    "Zero Oil Cook Book",
    "Diet Tips for Heart Patients",
    "Tips for Diabetes Patients",
    "Tips for Blood Pressure"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL Books',
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
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 700,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: booksArray.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 2,
                          child: Container(
                            height: 460,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/book_Image.jpg',
                                      fit: BoxFit.fill,
                                      height: 350,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      booksArray[index],
                                      style: const TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      height: 35,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        icon: const Image(
                                            image: AssetImage(
                                                'assets/icons/checklist.png'),
                                            width: 20,
                                            height: 20,
                                            color: Colors.white),
                                        label: const Text(
                                          'BUY NOW',
                                          style: TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
    );
  }
}
