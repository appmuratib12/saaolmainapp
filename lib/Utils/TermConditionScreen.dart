import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';


class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}


class _TermConditionScreenState extends State<TermConditionScreen> {
  String termsTxt =
      "BY ACCESSING OR USING THIS WEBSITE, YOU AGREE TO BE BOUND BY THESE TERMS AND CONDITIONS AND ACCEPT THEM IN FULL, AS THEY MAY BE MODIFIED BY SAAOL Heart Center FROM TIME-TO-TIME AND POSTED ON THIS WEBSITE.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Terms And Conditions',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing: 0.2,
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
              buildSectionTitle('DESCRIPTION OF SERVICES'),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Standard color for the text
                    height: 1.5, // Line height for better readability
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'All visitors to our Website should adhere to the following terms and conditions: ',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        // Bold for emphasis
                        decoration:
                            TextDecoration.underline, // Underline for emphasis
                      ),
                    ),
                    TextSpan(
                      text:
                          'BY ACCESSING OR USING THIS WEBSITE, YOU AGREE TO BE BOUND BY THESE TERMS AND CONDITIONS AND ACCEPT THEM IN FULL, ',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500, fontSize: 14,
                        color: Colors.black54, // Red color to draw attention
                      ),
                    ),
                  ],
                ),
                textAlign:
                    TextAlign.justify, // Align text for a professional look
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Standard color for the text
                    height: 1.5, // Line height for better readability
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Applicability:',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        // Bold for emphasis
                        decoration:
                            TextDecoration.underline, // Underline for emphasis
                      ),
                    ),
                    TextSpan(
                      text:
                          'These website terms and condition are applicable to all transactions including online appointment booking, bill payments, advance payment against services and/or any other transactions through this website or through its hyperlink(s) and authorized third party websites.',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500, fontSize: 14,
                        color: Colors.black54, // Red color to draw attention
                      ),
                    ),
                  ],
                ),
                textAlign:
                    TextAlign.justify, // Align text for a professional look
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Information provided by you:',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),

              buildBulletPoint(informationTxt1),
              buildBulletPoint(informationTxt2),
              buildBulletPoint(informationTxt4),
              buildBulletPoint(informationTxt4),
              buildBulletPoint(informationTxt5),
              buildBulletPoint(informationTxt6),
              buildBulletPoint(informationTxt7),
              buildBulletPoint(informationTxt8),
              buildBulletPoint(informationTxt9),
              buildBulletPoint(informationTxt10),
              buildBulletPoint(informationTxt11),
              buildBulletPoint(informationTxt12),
              buildBulletPoint(informationTxt13),
              const SizedBox(height:15),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Standard color for the text
                    height: 1.5, // Line height for better readability
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hyperlinks and third party websites: ',
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        // Bold for emphasis
                        decoration:
                        TextDecoration.underline, // Underline for emphasis
                      ),
                    ),
                    TextSpan(
                      text:hyperlinkThirdPartyTxt,
                      style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500, fontSize: 14,
                        color: Colors.black54, // Red color to draw attention
                      ),
                    ),
                  ],
                ),
                textAlign:
                TextAlign.justify, // Align text for a professional look
              ),
              buildSectionTitle('AVAILABILITY'),
              buildBodyText(availabilityTxtContent),

              buildSectionTitle('INTELLECTUAL PROPERTY RIGHTS'),
              buildBodyText(intellectualTxt),
              buildSectionTitle('LIMITATION OF LIABILITY FOR USE OF THE SITE'),
              buildBodyText(limitationTxt),
              buildSectionTitle('DATA PROTECTION'),
              buildBulletPoint(dataProtectionTxt1),
              buildBulletPoint(dataProtectionTxt2),
              buildBulletPoint(dataProtectionTxt3),
              buildBulletPoint(dataProtectionTxt4),
              buildBulletPoint(dataProtectionTxt5),
              buildSectionTitle('Gateway Security'),
              buildBulletPoint(gatewayTxt1),
              buildBulletPoint(gatewayTxt2),
              buildBulletPoint(gatewayTxt3),
              buildBulletPoint(gatewayTxt4),
              buildBulletPoint(gatewayTxt5),
              buildSectionTitle('Payment'),
              Text(paymentTxt,
                textAlign:TextAlign.justify,style:TextStyle(fontSize:14,
                  fontFamily:'FontPoppins',fontWeight:FontWeight.w500,color:Colors.black54),),
              buildSectionTitle('GENERAL TERMS AND CONDITIONS'),
              buildBulletPoint(generalTermsTxt1),
              buildBulletPoint(generalTermsTxt2),
              buildBulletPoint(generalTermsTxt3),
              buildBulletPoint(generalTermsTxt4),
              buildBulletPoint(generalTermsTxt5),
              buildBulletPoint(generalTermsTxt6),
              buildBulletPoint(generalTermsTxt7),
              buildSectionTitle('FORWARD LOOKING INFORMATION'),
              buildBodyText(forwardInformationTxt),
              buildSectionTitle('PRESS RELEASES'),
              buildBodyText(pressTxt),
              buildSectionTitle('VIOLATIONS OF RULES AND REGULATIONS'),
              buildBodyText(violationTxt),
              buildSectionTitle('JURISDICTION AND GOVERNING LAW'),
              buildBodyText(jurisdictionTxt),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        textAlign:TextAlign.justify,
        text,
        style: const TextStyle(
          fontSize:14,
          fontFamily:'FontPoppins',
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left:5,right:5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/icons/checked.png',width:20,height:20,),
          const SizedBox(width:10),
          Expanded(
            child: Text(
              textAlign:TextAlign.justify,
              text,
              style: const TextStyle(
                  fontSize:14,fontFamily:'FontPoppins',fontWeight:FontWeight.w500,color:Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
