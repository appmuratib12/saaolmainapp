import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:saaolapp/data/network/BaseApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import 'ConfirmDeleteAccountScreen.dart';
import 'DemoScreen.dart';


class SupportAndHelpScreen extends StatefulWidget {
  const SupportAndHelpScreen({super.key});

  @override
  State<SupportAndHelpScreen> createState() => _SupportAndHelpScreenState();
}

class _SupportAndHelpScreenState extends State<SupportAndHelpScreen> {
  TextEditingController reasonController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final BaseApiService _apiService = BaseApiService();
  final List<File> _images = [];

  Future<void> pickImage() async {
    final pickedFiles =
        await _picker.pickMultiImage(); // Allow multiple image selection

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      List<File> selectedImages = [];

      for (var pickedFile in pickedFiles) {
        File originalFile = File(pickedFile.path);
        print("Original Image Path: ${originalFile.path}"); // Print image path
        int maxSizeInBytes = 2048 * 1024; // 2MB
        if (originalFile.lengthSync() > maxSizeInBytes) {
          File? compressedImage = await compressImage(originalFile);

          if (compressedImage != null &&
              compressedImage.lengthSync() <= maxSizeInBytes) {
            selectedImages.add(compressedImage);
          } else {
            showSnackBar("Some images exceed 2MB and were not added");
          }
        } else {
          selectedImages.add(originalFile);
        }
      }

      setState(() {
        _images.addAll(selectedImages); // Append images to the list
      });
    }
  }

  Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        "${dir.absolute.path}/compressed_${file.path.split('/').last}";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
    );

    return result != null ? File(result.path) : null;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info@saaol.com',
      query: 'subject=Support Request&body=Hi, I need help with...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client');
    }
  }

  Future<void> submitFeedback() async {
    String reason = reasonController.text.trim();
    if (reason.isEmpty) {
      showSnackBar("Please enter a reason");
      return;
    }
    if (_images.isEmpty) {
      showSnackBar("Please select at least one image");
      return;
    }
    DialogHelper.showLoadingDialog(context);
    await _apiService.feedback(context, reason, _images);
    Navigator.pop(context); // Close the loading dialog
    Navigator.pop(context); // Navigate back to the previous screen
  }

  bool isExpanded = false;
  bool isExpanded1 = false;
  late SharedPreferences sharedPreferences;
  String getPatientID = '';
  String userToken = '';
  String googleUserID = '';
  String userID = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      //showVerifyButton = (loginMethod == 'google' || appleLoginMethod == 'apple');
      getPatientID = sharedPreferences.getString('pmId') ?? '';
      userID = sharedPreferences.getString(ApiConstants.USER_ID) ?? '';
      googleUserID = sharedPreferences.getString('GoogleUserID') ?? sharedPreferences.getString(ApiConstants.IDENTIFIER_TOKEN) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Support & Help',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing: 0.2,
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
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Help & Support',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              fontSize:14,
                              color: Colors.black87,
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0, // Rotate 180 degrees
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: _buildExpandedContent(context),
                      secondChild: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height:15),
              googleUserID.isNotEmpty && getPatientID.isEmpty && userID.isEmpty
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child:Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            side: BorderSide(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DemoScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Please verify patient',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              )
                  : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConfirmDeleteAccountScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'If you want to delete your account',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/icons/help_and_support.png'),
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Text(
                'Hello, How can we\nhelp you?',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton.icon(
              onPressed: () => DialogHelper.makingPhoneCall(Consulation_Phone),
              icon: const Icon(Icons.call, color: AppColors.primaryDark),
              label: const Text('Call',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.primaryDark)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.primaryDark),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => launchEmail(),
              icon: const Icon(Icons.email, color: AppColors.primaryDark),
              label: const Text('Email',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.primaryDark)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.primaryDark),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Reason',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'FontPoppins',
              fontSize: 16,
              color: Colors.black87),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: reasonController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Enter your reason",
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'FontPoppins',
                fontSize: 15,
                color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 1.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'FontPoppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 30, 149, 195),
                    Color.fromARGB(250, 30, 149, 195),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, size: 24, color: Colors.white),
                onPressed: pickImage,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Add & Upload Images',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'FontPoppins'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _images.isNotEmpty
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _images.asMap().entries.map((entry) {
                  int index = entry.key;
                  File image = entry.value;
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close,
                                size: 13, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )
            : Container(),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(250, 30, 149, 195),
                  Color.fromARGB(200, 30, 149, 195),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ElevatedButton(
              onPressed: submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.white, width: 0.1),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
