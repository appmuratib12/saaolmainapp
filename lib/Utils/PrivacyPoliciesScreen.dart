import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

class PrivacyPoliciesScreen extends StatefulWidget {
  const PrivacyPoliciesScreen({super.key});

  @override
  State<PrivacyPoliciesScreen> createState() => _PrivacyPoliciesScreenState();
}

class _PrivacyPoliciesScreenState extends State<PrivacyPoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing:0.2,
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
        physics:const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child:  Column(crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSectionTitle('Privacy Policy'),
              buildBodyText(privacyPolicyTxt),
              const Divider(
                height:20,
                thickness:0.2,
                color:Colors.grey,
              ),
              buildSectionTitle('Data security & electronic data encryption:'),
              buildBodyText(privacyDataSecurityTxt),
              const Divider(
                height:20,
                thickness:0.2,
                color:Colors.grey,
              ),
              buildSectionTitle('Purpose and use of information:'),
              buildBodyText(privacyInformationTxt),
              const Divider(
                height:20,
                thickness:0.2,
                color:Colors.grey,
              ),
              buildSectionTitle('Disclosure/sharing of information:'),
              buildBodyText(privacySharingInformationTxt)

            ],
          ),
        ),
      ),
    );
  }
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontFamily:'FontPoppins',
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildBodyText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        textAlign:TextAlign.justify,
        style: const TextStyle(
          fontSize:14,
          fontFamily:'FontPoppins',
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
}
