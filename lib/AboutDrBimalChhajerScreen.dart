import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'common/app_colors.dart';
import 'constant/text_strings.dart';


class AboutDrBimalChhajerScreen extends StatefulWidget {
  const AboutDrBimalChhajerScreen({super.key});

  @override
  State<AboutDrBimalChhajerScreen> createState() =>
      _AboutDrBimalChhajerScreenState();
}

class _AboutDrBimalChhajerScreenState extends State<AboutDrBimalChhajerScreen> {
  int initialLabelIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'About $DrBimal',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/bimal_sir.jpg'),
                width: double.infinity,
                height: 210,
                fit: BoxFit.cover,
              ),

              const SizedBox(
                height: 10,
              ),
               const Text(DrBimal,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              const Text(Mbbs,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
               const Text(
                aboutBimalSirTxt,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                aboutBimalSirTxt1,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ToggleSwitch(
                minWidth: double.infinity,
                cornerRadius: 20.0,
                activeBgColors: const [
                  [AppColors.primaryDark],
                  [AppColors.primaryDark],
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.blue[100],
                inactiveFgColor: AppColors.primaryDark,
                initialLabelIndex: initialLabelIndex,
                totalSwitches: 2,
                labels: const [
                  'Specialisation',
                  'Certificates & Awards',
                ],
                customTextStyles: const [
                  TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                  ),
                  TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                  ),
                ],
                radiusStyle: true,
                onToggle: (index) {
                  setState(() {
                    initialLabelIndex = index!;
                  });
                  print('Switched to: $index');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          initialLabelIndex == 0
                              ? 'Specialisation & Certifications'
                              : 'Awards & Recognition',
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        if (initialLabelIndex == 0)
                          ..._buildSpecialisationItems() // Display Specialisation & Certifications
                        else
                          ..._buildAwardItems() // Display Awards & Recognition
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

  List<Widget> _buildSpecialisationItems() {
    List<String> specialisations = [
      'Rajiv Gandhi Rashtriya Ekta Award, 2002.',
      'Bhaksar Award for the year 2002 by Bharat Nirman.',
      'Samaj Ratna Award by Skjm Samiti, 2004.',
      'Rotary International Vocational Award, 2002.',
      'Swami Vivekanand Memorial Oration Award from Delhi Medical Association, 2004.',
      'MSPI outstanding personalities award by Management Studies Promotion Institute, 1998.',
      'Prominent Doctors Award by Lion’s Club, 1998.',
    ];

    return specialisations
        .map((text) => _buildSpecialisationItem(text))
        .toList();
  }

  List<Widget> _buildAwardItems() {
    List<String> awards = [
      'P.S. Varier memorial speech at Arya Vidya Sala, Kottakkal, 1999.',
      'Kent Memorial lecture at Homeopathy Association, 1995.',
      'IBF Visionary award for, 2009” by Laksha Bharati Foundation.',
      'Sri Raghunath Rai Saraf Smriti Puraskar” on 28th March, 2010 at the FICCI Auditorium, New Delhi.',
      'Health Siromani award on September 5, 2010 by famous “Laughter Club”.',
      'Jeevan Rakshak Award, by Kolkata Maheshwari Samaj in September 2010.',
      'Third A P Dewan Memorial lecture, 2006 by the “Servants of the People Society, Lajpat Bhawan” July, 2006.',
      '“Doctor of the Year 2012” award by the “India Book of Records” presented on 27th February, 2013.',
      '“Banga Seva Samman, 2011” – the prestigious award for the people of Bengal who have reached excellence.',
      '“Banga Seva Samman, 2011” – the prestigious award for the people of Bengal who have reached excellence.',
      '”Manav Seva Ratna Samman” in 2016 by Bhagwan Mahavir Seva Sansthan.',
    ];

    return awards.map((text) => _buildAwardItem(text)).toList();
  }

  Widget _buildAwardItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.emoji_events, // Icon for awards
            color: AppColors.primaryDark,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialisationItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.star, // Change icon for specialisations
            color: AppColors.primaryDark,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
