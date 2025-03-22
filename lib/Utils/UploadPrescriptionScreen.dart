import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import '../common/app_colors.dart';
import 'PillReminderScreen.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  State<UploadPrescriptionScreen> createState() =>
      _UploadPrescriptionScreenState();
}

class _UploadPrescriptionScreenState extends State<UploadPrescriptionScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _pdfFile;

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
      _pdfFile = null;
    });
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
        _image = null; // Reset image if a PDF is picked
      });
    }
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

  void uploadFile(BuildContext context) async {
    try {
      if (_image != null) {
        await BaseApiService().uploadPrescription(_image!);
      } else if (_pdfFile != null) {
        await BaseApiService().uploadPrescription(_pdfFile!);
      } else {
        Fluttertoast.showToast(msg: 'No file selected.');
        Navigator.of(context).pop(); // Dismiss the progress dialog
        return;
      }
      Fluttertoast.showToast(msg: 'Upload successful.');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Upload failed: $e');
    } finally {
      Navigator.of(context).pop();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal:5),
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
                          _buildVerticalDivider(),
                          _buildUploadOption(
                            icon: FontAwesomeIcons.filePdf,
                            label: 'Pick PDF',
                            onTap: _pickPDF,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_image != null || _pdfFile != null) ...[
                      const Text(
                        'ATTACHED FILE',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          if (_image != null)
                            Image.file(
                              _image!,
                              width: 100,
                              height: 140,
                              fit: BoxFit.cover,
                            )
                          else if (_pdfFile != null)
                            Container(
                              color: Colors.grey[300],
                              width: 100,
                              height: 140,
                              child: const Icon(
                                FontAwesomeIcons.filePdf,
                                size: 50,
                                color: Colors.red,
                              ),
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
                        image: AssetImage('assets/images/Prescription.jpg'),
                        height: 250,
                        width: double.infinity,
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
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(child: Column(
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
                                SizedBox(height:5,),
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
                            ),
                            Image(
                              image:
                                  AssetImage('assets/images/female_dcotor.png'),
                              fit: BoxFit.cover,
                              height:90,
                              width:90,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:10),
                  ],
                ),
              ),

             Padding(padding: EdgeInsets.only(left:10,right:10),child: SizedBox(
               height: 45,
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: () async {
                   if (_image != null || _pdfFile != null) {
                     Fluttertoast.showToast(msg: 'Uploading Prescription');
                     showDialog(
                       context: context,
                       barrierDismissible: false,
                       builder: (BuildContext context) {
                         return const CustomProgressIndicator();
                       },
                     );
                     uploadFile(context);  // Pass context here to dismiss the dialog
                   } else {
                     Fluttertoast.showToast(msg: 'Please select an image or PDF to upload');
                   }
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.primaryColor,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
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
