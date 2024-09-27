import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final propertyDetails = {
    'Full Name': 'Mohd Muratib',
    'Gender': 'Male',
    'Age': '24',
    'Problem.': 'Fever',
  };
  /*late GoogleMapController mapController;

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
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Appointment Details',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
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
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.2), width: 0.2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/bima_sir.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Bimal Chhajer',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                'MBBS, MD | Cardiology',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              /*SizedBox(
                                height: 36,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),
                                  onPressed: () {
                                    Fluttertoast.showToast(msg: 'click');
                                  },
                                  child: const Text(
                                    'Call now',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),*/

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height:10,),
                      Row(
                        children: [
                          Text('Appointment Mode:',
                            style:TextStyle(fontFamily:'FontPoppins',
                                fontSize:15,fontWeight:FontWeight.w500,color:Colors.black),),
                          SizedBox(width:5,),
                          Text('Offline',style:TextStyle(fontFamily:'FontPoppins',fontSize:15,
                              letterSpacing:0.1,
                              fontWeight:FontWeight.w600,color:AppColors.primaryDark),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Schedule Appointment',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Date & Time',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Expanded(child: Container()),
                          const Column(
                            children: [
                              Text(
                                'Today,20 August,2024',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                '9 AM - 10 AM(1 hour)',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Patient Information',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: propertyDetails.entries.map((entry) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    color: Colors.black87),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: AppColors.primaryDark,
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Please reach 10 mins before your\nslot time',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'LOCATION',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'E-3, Kailash Colony Rd, Block E, Kailash Colony, New Delhi, Delhi 110048.',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 20,
              ),
              /*ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
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
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}