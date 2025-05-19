import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';
import '../../data/model/apiresponsemodel/TreatmentsResponseData.dart';
import '../../data/network/BaseApiService.dart';
import '../SafetyCircleScreen.dart';
import '../TreatmentDetailsPageScreen.dart';
import 'DetoxScreen.dart';
import 'LifeStylePageScreen.dart';
import 'TreatmentsOverviewScreen.dart';
import 'ZeroOilPageScreen.dart';

class ExpandableListView extends StatefulWidget {
  const ExpandableListView({super.key});

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {

  List<String> ourTreatmentArray = [
    'Education & Lifestyle Management',
    'Optimum Allopathic Medical Management',
    'Natural Bypass or ECP/EECP',
    'Saaol Detox Therapy',
  ];

  String stripHtml(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? ''; // Extracts plain text from parsed HTML
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 50, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Overview Section
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _overviewCard(),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.4)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Our Main Treatment',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          fontSize:15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Our specialized team focuses on non-invasive treatments for heart health, combining modern science with traditional wisdom.',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          fontSize:11,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _treatmentCarousel(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Our Treatments',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                const SizedBox(height:10,),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder<TreatmentsResponseData>(
                        future: BaseApiService().getTreatmentsData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.data == null) {
                            return const Center(child: Text("Unable to load treatments."));
                          }

                          final treatments = snapshot.data!.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: treatments.length,
                            padding: const EdgeInsets.symmetric(horizontal:3),
                            itemBuilder: (context, index) {
                              final treatment = treatments[index];
                              return GestureDetector(
                                onTap: () {
                                  String id = treatment.id.toString();
                                  Widget screen;
                                  switch (id) {
                                    case '14': screen = ZeroOilPageScreen(id: id); break;
                                    case '15': screen = DetoxScreen(id: id); break;
                                    case '16': screen = TreatmentDetailsPageScreen(id: id); break;
                                    case '13': screen = LifeStylePageScreen(id: id); break;
                                    case '17': screen = TreatmentsOverviewScreen(id: id); break;
                                    default: return;
                                  }
                                  Navigator.of(context, rootNavigator: true).push(
                                    CupertinoPageRoute(builder: (context) => screen),
                                  );
                                },
                                child: Container(
                                  width: 260,
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(
                                          treatment.image ?? '',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Container(color: Colors.grey.shade300),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black.withOpacity(0.7),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                treatment.title ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                stripHtml(treatment.description ?? ''),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:11,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'SAAOL Safety Circle',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize:16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildSafetyItem(
                                      'Red (means high risk)', Colors.red),
                                  _buildSafetyItem(
                                      'Yellow (moderate risk)', Colors.orange),
                                  _buildSafetyItem(
                                      'Green (lowest risk)', Colors.green),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/icons/safety_circle.jpg',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Explore Button
                        SizedBox(
                          height: 47,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const SafetyCircleScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 2,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Explore Now',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
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
  Widget _overviewCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saaol Medical Treatment',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w700,
                  fontSize:13,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                treatmentOverviewTxt,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                  fontSize:11,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _treatmentCarousel() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 260,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      itemCount: ourTreatmentArray.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          height:170,
          width:210,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/icons/presentation.png'),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  ourTreatmentArray[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    fontSize:13,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'A non-invasive approach to heart treatment with modern medical advancements.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize:11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSafetyItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'FontPoppins',
              fontSize:13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
