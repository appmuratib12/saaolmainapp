import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import 'HeartHealth/AssessRiskScreen.dart';
import 'HeartHealth/CausesHealthScreen.dart';
import 'HeartHealth/KnowYourHeartScreen.dart';
import 'HeartHealth/OverviewScreen.dart';
import 'SaaolBooksScreen.dart';

class HeartHealthScreen extends StatefulWidget {
  const HeartHealthScreen({super.key});

  @override
  State<HeartHealthScreen> createState() => _HeartHealthScreenState();
}

class _HeartHealthScreenState extends State<HeartHealthScreen> {
  final List<Map<String, String>> heartArray = [
    {'name': 'Overview', 'image': 'assets/images/india_gate.png'},
    {'name': 'Assess Risk', 'image': 'assets/images/india_gate.png'},
    {'name': 'Know Your Heart', 'image': 'assets/images/india_gate.png'},
    {'name': 'Heart Health Causes', 'image': 'assets/images/india_gate.png'},
    {'name': 'SAAOL Books', 'image': 'assets/images/india_gate.png'},
  ];

  List<String> healthArray = [
    "Overview",
    "Assess Risk",
    "Know Your Heart",
    "Heart Health Causes",
    "SAAOL Books"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Heart Health',
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
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* SizedBox(
                height: 500,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: heartArray.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image(
                                image: AssetImage(
                                    'assets/icons/heartbeat_icon.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height:10,),
                          Text(heartArray[i]['name']!,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: healthArray.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const OverviewScreen()),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const HeartHealthAssessmentForm ()),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const KnowYourHeartScreen ()),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const CausesHealthScreen ()),
                            );
                            break;
                          case 4:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const BooksHealthScreen()),
                            );
                            break;
                          default:

                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 0.5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      healthArray[index],
                                      style: const TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Expanded(child: Container()),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: AppColors.primaryDark,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
