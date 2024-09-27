import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../common/app_colors.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  State<UploadPrescriptionScreen> createState() =>
      _UploadPrescriptionScreenState();
}

class _UploadPrescriptionScreenState extends State<UploadPrescriptionScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }


  void _showRemoveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Are you sure you want to remove this prescription?",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      // Close the dialog
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _removeImage(); // Call your remove function
                      },
                      child: const Text(
                        "Remove",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Upload Prescription',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
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
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Have a prescription? Upload here',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'FontPoppins',
                          color: Colors.black),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildUploadOption(
                            icon: FontAwesomeIcons.camera,
                            label: 'Camera',
                            onTap: () => _pickImage(ImageSource.camera),
                          ),
                          _buildVerticalDivider(),
                          _buildUploadOption(
                            icon: FontAwesomeIcons.image,
                            label: 'Gallery',
                            onTap: () => _pickImage(ImageSource.gallery),
                          ),
                          _buildVerticalDivider(),
                          _buildUploadOption(
                            icon: FontAwesomeIcons.filePrescription,
                            label: 'My Prescription',
                            onTap: () => _pickImage(ImageSource.gallery),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_image == null) ...[
                      const Row(
                        children: [
                          Icon(Icons.security, color: Colors.grey, size: 40),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your attached prescription will be secure and private.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      const Text(
                        'ATTACHED PRESCRIPTION',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Image.file(
                            _image!,
                            width: 100,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.cancel,
                                  color: Colors.red, size: 25),
                              onPressed: () {
                                _showRemoveConfirmationDialog(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 15),
                    const Text(
                      'What is Valid Prescription?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Image(
                        image:
                            AssetImage('assets/images/Prescription.jpg'),
                        height: 250,
                        width:double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primaryDark,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Upload Clear Image',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Do not crop the Image',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Don't have a valid prescription?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Tap here to book a tele-consultation now!',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor),
                                )
                              ],
                            ),
                            Image(
                              image:
                                  AssetImage('assets/images/female_dcotor.png'),
                              fit: BoxFit.fill,
                              height: 60,
                              width: 60,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: 'Click');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'UPLOAD PRESCRIPTION',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 25),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 25,
      width: 1,
      color: Colors.white,
    );
  }
}
