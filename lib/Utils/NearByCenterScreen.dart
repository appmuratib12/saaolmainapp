import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class NearByCenterScreen extends StatefulWidget {
  const NearByCenterScreen({super.key});

  @override
  State<NearByCenterScreen> createState() => _NearByCenterScreenState();
}

class _NearByCenterScreenState extends State<NearByCenterScreen> {
  List<String> nearByCentersArray = [
    "SAAOL Chhatarpur Center...",
    "SAAOL Chhatarpur Center...",
    "SAAOL Chhatarpur Center...",
    "SAAOL Chhatarpur Center...",
    "SAAOL Chhatarpur Center...",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Nearby Centers',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 18,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Your Location',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),

                GestureDetector(
                  onTap: () {
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchBarScreen()),
                    );*/
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Delhi 110001',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Dr. Bimal Chhajer',
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Heart Specialist',
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'MBBS, MD, Founder | SAAOL',
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 0.2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyAppointmentsScreen()),
                                  );*/
                                },
                                child: const Text(
                                  'Book Appointment',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/bima_sir.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: 140,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Centers Near you',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              ListView.builder(
                itemCount: nearByCentersArray.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // Important: Makes ListView take only needed space
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/room_image2.jpg',
                                      height: 65,
                                      width: 65,
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
                                          nearByCentersArray[index],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '21 Km',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              height: 15,
                                              width: 0.8,
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'DLF Phase 1',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 36,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'View Center',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 13,
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
            ],
          ),
        ),
      ),
    );
  }
}
