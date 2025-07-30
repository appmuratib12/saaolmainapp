import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import '../data/model/apiresponsemodel/CenterDetailsResponse.dart';
import '../data/network/BaseApiService.dart';
import 'AppointmentsScreen.dart';


class CenterDetailsPageScreen extends StatefulWidget {
  final String centerName;
  const CenterDetailsPageScreen({super.key, required this.centerName});

  @override
  State<CenterDetailsPageScreen> createState() => _CenterDetailsPageScreenState();
}

class _CenterDetailsPageScreenState extends State<CenterDetailsPageScreen> {

  String? getLocationLat;
  String? getLocationLong;

  final List<Map<String, String>> items = [
    {
      "title": "Non-Invasive",
      "description": benefit1,
    },
    {
      "title": "Painless Procedure:",
      "description": benefit2,
    },
    {
      "title": "No Hospitalization Required",
      "description": benefit3,
    },
    {
      "title": "No Risk of Infection:",
      "description": benefit4,
    },
    {
      "title": "No Side Effects:",
      "description": benefit5,
    },
    {
      "title": "Cost-Effective Solution:",
      "description": benefit5,
    },
  ];
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getLocationLat = prefs.getString('lat') ?? '';
    getLocationLong = prefs.getString('long') ?? '';
    print('LocationLat:$getLocationLat');

  }

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
  }

  String storePhone = '';

  void openGoogleMap() async {
    final url = Uri.parse(
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d224613.04467973346!2d77.00722519231887!3d28.401786416064873!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1e4cf24cfafb%3A0xc36e9ab2e960b500!2sSaaol%20Heart%20Centre%20%3A%20EECP%20Treatment%20%7C%20Best%20Cardiologist%20%26%20Heart%20Specialist%20in%20Delhi!5e0!3m2!1sen!2sus!4v1704447278841!5m2!1sen!2sus");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }
  final DraggableScrollableController sheetController =
  DraggableScrollableController();
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          FutureBuilder<CenterDetailsResponse>(
            future: BaseApiService().centerDetailsData(widget.centerName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load data'));
              } else if (snapshot.hasData &&
                  snapshot.data!.data != null) {
                final details = snapshot.data!.data!;
                final phoneNumbers = RegExp(r'\d{10,}')
                    .allMatches(details.phoneNo
                    .toString()) // Extracts all valid numbers
                    .map((match) => match.group(0)) // Converts to a list
                    .where((num) => num != null) // Removes nulls
                    .toList();
                storePhone = phoneNumbers.isNotEmpty
                    ? phoneNumbers.first!
                    : 'N/A'; // Get first number
                print('StorePhone: $storePhone'); // Debugging

                return Stack(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/eecp_image3.jpeg'),
                      fit: BoxFit.fill, // Cover to fill the rounded area properly
                      width: double.infinity,
                      height:260,
                    ),
                    Positioned(
                      top:35, // Adjust according to your app bar height / status bar
                      left:12,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,size:22,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),

                    DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.7,
                      maxChildSize: 0.9,
                      expand: true,
                      controller: sheetController,
                      builder: (BuildContext context, scrollController) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: CustomScrollView(
                            controller: scrollController,
                            slivers: [
                              SliverToBoxAdapter(
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Transformative EECP Treatment Center${details.cityAddr}',
                                              style: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              aboutCenterTxt.trim(),
                                              style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:12,
                                                  letterSpacing:0.2,
                                                  color: Colors.black),
                                              softWrap:true,
                                            ),
                                            const Divider(
                                              height: 30,
                                              thickness: 5,
                                              color: AppColors.primaryColor,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    aboutEECP.trim(),
                                                    textAlign: TextAlign.justify,
                                                    style: const TextStyle(
                                                        fontFamily: 'FontPoppins',
                                                        height: 1.5,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize:12,
                                                        letterSpacing:0.2,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Column(
                                                    children: [
                                                      _buildTimelineTile(
                                                        icon: Icons.check_circle,
                                                        title: 'No Pain',
                                                        isCompleted: true,
                                                      ),
                                                      _buildTimelineTile(
                                                        icon: Icons.check_circle,
                                                        title: 'No Surgery',
                                                        isCompleted: true,
                                                      ),
                                                      _buildTimelineTile(
                                                        icon: Icons.check_circle,
                                                        title: 'No Hospitalization',
                                                        isCompleted: true,
                                                      ),
                                                      _buildTimelineTile(
                                                        icon: Icons.check_circle,
                                                        title: 'US-FDA Approved',
                                                        isCompleted: true,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                                height: 30,
                                                thickness: 5,
                                                color: AppColors.primaryDark),
                                            const Text(
                                                'Benefits of EECP Therapy Compared to Bypass Surgery (CABG)',
                                                style: TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                            SingleExpansionList(items: items),
                                            /* const Text(
                                        'Location',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),*/
                                            /* const SizedBox(
                                        height: 15,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 250,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.primaryColor, width: 0.3)),
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
                                            const SizedBox(
                                              height: 70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No Data Found'));
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                      width: 0.4, color: Colors.grey.withOpacity(0.6)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                const MyAppointmentsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                  ],
                ),
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
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                onPressed: () {
                  DialogHelper.makingPhoneCall(Consulation_Phone);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTile({
    required IconData icon,
    required String title,
    required bool isCompleted,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              icon,
              color: isCompleted ? AppColors.primaryColor : Colors.grey,
            ),
            Container(
              height: 40,
              width: 2,
              color: isCompleted ? AppColors.primaryColor : Colors.grey,
            ),
          ],
        ),
        const SizedBox(width: 13),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.trim(),
              style: const TextStyle(
                  fontSize:12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'FontPoppins',
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}

class SingleExpansionList extends StatefulWidget {
  final List<Map<String, String>> items;
  const SingleExpansionList({super.key, required this.items});
  @override
  _SingleExpansionListState createState() => _SingleExpansionListState();
}

class _SingleExpansionListState extends State<SingleExpansionList> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      itemBuilder: (context, index) {
        final isExpanded = _expandedIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    widget.items[index]['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FontPoppins',
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.items[index]['description']!,
                      style: const TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                  crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
