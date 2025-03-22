import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/WellnessCenterResponse.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';


class PropertyScreen extends StatefulWidget {
  final Data data;
  const PropertyScreen({super.key, required this.data});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  List<String> roomsArray = [
    "assets/images/room_image1.jpg",
    "assets/images/room_image2.jpg"
  ];
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

   late GoogleMapController mapController;
  final LatLng _center = const LatLng(28.4829, 77.1640); // Example: Dubai
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('Saaol'),
      position: LatLng(28.4829, 77.1640),
      infoWindow: InfoWindow(
          title: 'Saaol',
          snippet: 'Saaol Heart Centre : EECP Treatment | Best Cardiologist & Heart Specialist in Delhi'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  _makingPhoneCall() async {
    var url = Uri.parse("tel:9953027222");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendingMails() async {
    var email = 'saaol.wellness@saaol.co.in';
    var subject = 'Your Subject Here';

    var url = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}');

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendMessage() async {
    var phoneNumber = '9953027222'; // The phone number to send the message to
    var message = 'Hello, this is a message from Flutter!'; // The message you want to send
    var url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String>? amenitiesList = widget.data.content?.split(',').map((e) => e.trim()).toList();

    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.data.images!.length, // Number of images
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8), // Space between images
                  child: Image.network(
                    widget.data.images![index], // ✅ Corrected: Accessing image URL at index
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250, // Adjust height as needed
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.8,
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
                               Text(widget.data.centerName.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                               Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: AppColors.primaryDark,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(widget.data.locationName.toString(),
                                    style: const TextStyle(
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
                                child:  Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    widget.data.content.toString(),
                                    style: const TextStyle(
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
                              // Display amenities dynamically
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: amenitiesList!.length,
                                itemBuilder: (context, index) {
                                  return AmenitiesItem(
                                    icon: _getAmenityIcon(amenitiesList[index]), // Get icon dynamically
                                    label: amenitiesList[index],
                                  );
                                },
                              ),
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
                                            'assets/images/saaol_detox_image.jpg'),
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
                                  /*  const Text(
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
                                            'assets/images/saaol_detox_image.jpg'),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                    ),*/
                                    /*const SizedBox(
                                      height: 10,
                                    ),*/

                                    /*const Text(
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
                                    ),*/
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
                              const SizedBox(
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

                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primaryColor, width: 0.3),
                                  ),
                                  child: GoogleMap(
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                        double.parse(widget.data.lat ?? "0.0"), // ✅ Extracted Latitude
                                        double.parse(widget.data.long ?? "0.0"), // ✅ Extracted Longitude
                                      ),
                                      zoom: 14.0, // Adjust zoom level as needed
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId("wellness_center"),
                                        position: LatLng(
                                          double.parse(widget.data.lat ?? "0.0"),
                                          double.parse(widget.data.long ?? "0.0"),
                                        ),
                                        infoWindow: InfoWindow(title: widget.data.centerName ?? "Center"),
                                      ),
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height:70,),
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4), width: 0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(
                    icon: Icons.call,
                    label: 'Call',
                    color: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      _makingPhoneCall();
                    },
                  ),
                  _buildButton(
                    icon: Icons.email,
                    label: 'Email',
                    color: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      _sendingMails();
                    },
                  ),
                  _buildButton(
                    icon: Icons.call,
                    label: 'WhatsApp',
                    color: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      sendMessage();
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
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.primaryDark,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'FontPoppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Function to return icons dynamically based on amenities
  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case '24/7 medical support':
        return Icons.medical_information;
      case 'daily housekeeping':
        return Icons.cleaning_services;
      case 'nutritious meals from our zero oil kitchen':
        return Icons.restaurant;
      case 'access to the garden and yoga sessions':
        return Icons.spa;
      case 'room service':
        return Icons.room_service;
      default:
        return Icons.check_circle; // Default icon
    }
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
          Expanded(child: Text(
            label,
            style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),),
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
