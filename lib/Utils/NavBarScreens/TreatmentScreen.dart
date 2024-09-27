import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';

class ExpandableListView extends StatefulWidget {
  const ExpandableListView({super.key});

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  List<String> treatmentsArray = [
    'EECP Treatment',
    'SAAOL Detox',
    'Zero oil cooking',
    'Life Style',
    'OverView'
  ];
  List<String> imageUrls = [
    'https://www.mirakleihc.com/wellness_admin/resource/uploads/srcimg/1MYiNSWnzn23032024025902mirakle-eecp.jpeg',
    'https://www.nightingaledubai.com/wp-content/uploads/2023/05/iv-drip-detox.jpg',
    'https://www.mirakleihc.com/wellness_admin/resource/uploads/srcimg/1MYiNSWnzn23032024025902mirakle-eecp.jpeg',
    'https://img.freepik.com/free-photo/young-beautiful-woman-doing-yoga-nature_1139-909.jpg?t=st=1721718678~exp=1721722278~hmac=65a9b900e0b3dfdfd5e389b028796e6a9298430e93915a50c41127d86cbc8a5d&w=1480',
    'https://www.nightingaledubai.com/wp-content/uploads/2023/05/iv-drip-detox.jpg'
  ];
  List<String> ourTreatmentArray = [
    'Education & Lifestyle Management',
    'Optimum Allopathic Medical Management',
    'Natural Bypass or ECP/EECP',
    'Saaol Detox Therapy',
  ];

  final List<Map<String, String>> cities = [
    {'name': 'EECP Treatment', 'image': 'assets/images/surgeon_Image.jpg'},
    {'name': 'SAAOL Detox', 'image': 'assets/images/surgeon_Image.jpg'},
    {'name': 'Zero oil cooking', 'image': 'assets/images/surgeon_Image.jpg'},
    {'name': 'Life Style', 'image': 'assets/images/hospital_image.jpg'},
    {'name': 'Overview', 'image': 'assets/images/banglore_image.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 50, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Overview',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/treatment_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        // Semi-transparent overlay
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saaol Medical Treatment',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            treatmentOverviewTxt,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                              // Change text color to white
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 410,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Our Main Treatment',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Our highly-specialized team firmly believes in non-invasive methods for treating heart-related problems across all age groups.'
                        'Our medical treatment is based on the ancient wisdom shared over generations.',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: ourTreatmentArray.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                              /*  Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const TreatmentDetailsPageScreen()),
                                );*/
                                Fluttertoast.showToast(msg: 'click');
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 250,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 5, right: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/icons/presentation.png'),
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              ourTreatmentArray[index],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              'Modern medicines from the Allopathic system are prescribed to heart patients to reduce Angina & other risk factors.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: Colors.black),
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
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: treatmentsArray.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const TreatmentDetailsPageScreen()),
                            );*/
                            Fluttertoast.showToast(msg: 'click');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.3))),
                                  child: Padding(
                                    padding:  EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child:  Image(
                                            image: NetworkImage(imageUrls[index]),
                                            width: 140,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                treatmentsArray[index],
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Flexible(
                                                child: Text(
                                                  'This treatment is a highly accepted UD FDA-approved scientific and non-invasive way to treat heart disease.',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                    letterSpacing: 0.1,
                                                    color: Colors.black54,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
                                          color: Colors.black54,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SAAOL Safety Circle',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Red (means high risk)',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black87),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Red (means high risk)',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black87),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Green (lowest risk or reversal)',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black87),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.white, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/icons/safety_circle.jpg',
                                  height: 70,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                           /* Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const SafetyCircleScreen()),
                            );*/
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Explore now',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*SizedBox(
                height:750,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing:13.0,
                    childAspectRatio:0.9,
                  ),
                  itemCount: cities.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: 'Click');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.asset(
                            cities[i]['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(1),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              child: Text(
                                cities[i]['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
