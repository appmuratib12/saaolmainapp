import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';
import 'Magazine/MagazineBlogDetailPage.dart';

class EmagazineScreen extends StatefulWidget {
  const EmagazineScreen({super.key});

  @override
  State<EmagazineScreen> createState() => _EmagazineScreenState();
}

class _EmagazineScreenState extends State<EmagazineScreen> {
  List<String> magaZineAArray = [
    "SAAOL E-Magazine",
    "SAAOL E-Magazine",
    "SAAOL E-Magazine",
    "SAAOL E-Magazine"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL E-Magazine',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: magaZineAArray.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Fluttertoast.showToast(
                    msg: 'Clicked on ${magaZineAArray[index]}');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                            image:
                                AssetImage('assets/images/magazine_image.jpg'),
                            fit: BoxFit.fill,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'SAAOL E-Magzine 2024 July',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const MagazineBlogDetailPage()),
                              );

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Read more',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
