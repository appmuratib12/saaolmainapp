import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {

  List<String> roomsArray = ["assets/images/room_image1.jpg","assets/images/room_image2.jpg"];
  final DraggableScrollableController sheetController =
      DraggableScrollableController();
 /* late GoogleMapController mapController;
  final LatLng _center = const LatLng(28.4829, 77.1640); // Example: Dubai
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('Saaol'),
      position: LatLng(28.4829, 77.1640),
      infoWindow: InfoWindow(
          title: 'Saaol',
          snippet:
              'Saaol Heart Centre : EECP Treatment | Best Cardiologist & Heart Specialist in Delhi'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }*/

  final List<String> imagePaths = [
    'assets/images/room_image1.jpg',
    'assets/images/room_image2.jpg',
    'assets/images/room_image1.jpg',
    'assets/images/room_image1.jpg',
    'assets/images/room_image1.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: imagePaths.length, // Number of images
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8), // Space between images
                  child: Image.asset(
                    imagePaths[index], // Load different images based on index
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250, // Adjust height as needed
                  ),
                );
              },
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.3,
            // The initial height of the bottom sheet
            minChildSize: 0.3,
            // The minimum height of the bottom sheet
            maxChildSize: 0.8,
            // The maximum height of the bottom sheet
            expand: true,
            controller: sheetController,
            builder: (BuildContext context, scrollController) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // Drag handle
                    SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    // Content inside the DraggableScrollableSheet
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SAAOL EXPERIENCE CENTER',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                               const Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: AppColors.primaryDark,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Dehradun',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: 'FontPoppins',
                                        color: AppColors.primaryColor),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryDark,
                                    border: Border.all(
                                        color: Colors.white, width: 0.3)),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    centerTxt,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 15,
                                color: Colors.grey,
                                thickness: 0.2,
                              ),
                              const Text(
                                'Features & Facilities',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const AmenitiesItem(
                                  icon: Icons.medical_information,
                                  label: '24/7 Medical Support'),
                              const AmenitiesItem(
                                  icon: Icons.ac_unit,
                                  label: 'Daily housekeeping'),
                              const AmenitiesItem(
                                  icon: Icons.oil_barrel,
                                  label:
                                      'Nutritious meals from our Zero Oil Kitchen'),
                              const AmenitiesItem(
                                  icon: Icons.pool,
                                  label:
                                      'Access to the garden and yoga sessions'),
                              const AmenitiesItem(
                                  icon: Icons.room_service,
                                  label: 'Room Service'),
                              const Divider(
                                height: 15,
                                color: Colors.grey,
                                thickness: 0.2,
                              ),
                              const Text(
                                'Therapies and Treatments',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.primaryDark),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                therapiesTxt,
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black87),
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
                                      'Saaol Natural Bypass (EECP)',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/eecp_image3.jpeg'),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      textAlign: TextAlign.justify,
                                      aboutTherapiesTxt,
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'SAAOL Detox Therapy',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/eecp_image3.jpeg'),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      textAlign: TextAlign.justify,
                                      aboutDetoxTxt,
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Modern Medicine',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/eecp_image3.jpeg'),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      textAlign: TextAlign.justify,
                                      aboutModernMedicineTxt,
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.primaryColor),
                                    ),
                                    const Divider(
                                      height: 15,
                                      color: Colors.grey,
                                      thickness: 0.2,
                                    ),
                                    const Text(
                                      'Lifestyle Optimization',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: AppColors.primaryDark),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 15,
                                color: Colors.grey,
                                thickness: 0.2,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location & nearby',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: AppColors.primaryDark),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Mobile:',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '9953027222,9953027333,9318405275,7683053949',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'Landline:',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '011-44732744/45/46',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'Email:',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'saaol.wellness@saaol.co.in',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'Address:',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Shivpuri,Hariyawala Kalan,Dehradun,Uttrakhand 248141',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 15,
                                color: Colors.grey,
                                thickness: 0.2,
                              ),
                              const Text(
                                'Directions:',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.primaryDark),
                              ),
                              const Text(
                                'You can reach us by road, rail, or air. We are conveniently located and easily accessible:',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const DirectionItem(
                                icon: Icons.play_arrow,
                                description:
                                    'By Road: Follow the 14.4 km highway and look for signs directing you to the SAAOL Institute. The drive typically takes about 43 minutes.',
                              ),
                              const DirectionItem(
                                icon: Icons.play_arrow,
                                description:
                                    'By Train: The nearest railway station is Dehradun, approximately 14.7 km from the institute, with a travel time of about 42 minutes.',
                              ),
                              const DirectionItem(
                                icon: Icons.play_arrow,
                                description:
                                    'By Air: The closest airport is Jolly Grant Airport, situated approximately 48.6 km away. The journey usually takes around 1 hour and 30 minutes.',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Google Map Link',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            /*  ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.3)),
                                  child: GoogleMap(
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: _center,
                                      zoom: 10.0,
                                    ),
                                    markers: _markers,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Positioned(
            top: 40,
            right: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.share),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration:BoxDecoration(
                color:Colors.white,
                border:Border.all(color:Colors.grey.withOpacity(0.4),width:0.6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(
                    icon: Icons.call,
                    label: 'Call',
                    color: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      // Handle Call action
                    },
                  ),
                  _buildButton(
                    icon: Icons.email,
                    label: 'Email',
                    color: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      // Handle Email action
                    },
                  ),
                  _buildButton(
                    icon: Icons.call,
                    label: 'WhatsApp',
                    color: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      // Handle WhatsApp action
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryDark,size:20,),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize:13,fontFamily:'FontPoppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AmenitiesItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const AmenitiesItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryDark, size: 20.0),
          const SizedBox(width: 10.0),
          Text(
            label,
            style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),

        ],
      ),
    );
  }
}

class DirectionItem extends StatelessWidget {
  final IconData icon;
  final String description;

  const DirectionItem(
      {super.key, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryDark, size: 20.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
