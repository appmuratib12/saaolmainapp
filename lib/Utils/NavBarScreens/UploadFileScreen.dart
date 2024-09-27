import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import '../../common/app_colors.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  File? _pickedFile;
  File? _image1;
  final picker = ImagePicker();

  Future<File?> pickFile() async {
    // Request storage permissions
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission denied');
      return null;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      // User canceled the picker
      return null;
    }
  }

  Future<void> uploadFile(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://saaol.org/saaolapp/api/test'), // Replace with your server URL
    );
    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully.');
    } else {
      print('File upload failed.');
    }
  }

  Future<void> _pickFile() async {
    File? file = await pickFile();
    if (file != null) {
      setState(() {
        _pickedFile = file;
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_pickedFile != null) {
      await uploadFile(_pickedFile!);
    } else {
      print('No file picked');
    }
  }

  Future<void> uploadImage1() async {
    String name = nameController.text.trim();
    String content = contentController.text.trim();

    if (_image1 == null) {
      print('No image selected');
      return;
    }

    var stream = http.ByteStream(_image1!.openRead());
    var length = await _image1!.length();
    var uri = Uri.parse('https://saaol.org/saaolapp/api/test');

    var request = http.MultipartRequest('POST', uri);
    request.fields['link'] = name;
    request.fields['content'] = content;

    var multipartFile = http.MultipartFile('image', stream, length,
        filename: path.basename(_image1!.path));
    request.files.add(multipartFile);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print('Response data: $responseString');
        print('Image uploaded');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        setState(() {
          // showSpinner = false;
        });
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick and Upload File'),
      ),
      body: Scaffold(
        appBar: AppBar(
          title: Text('Pick and Upload File'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: (_image1 == null)
                      ? const AssetImage('assets/images/call_center.png')
                      : FileImage(_image1!) as ImageProvider,
                  child: GestureDetector(
                    onTap: () {
                      getImageFromGallery();
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          height: 30,
                          width: 50,
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              'EDIT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'FontPoppins',
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                  prefixIcon: const Icon(Icons.contact_page,
                      color: AppColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.lightBlue[50],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'Enter your content',
                  hintStyle: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                  prefixIcon: const Icon(Icons.contact_page,
                      color: AppColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.lightBlue[50],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                onPressed: () {
                  uploadImage1();
                },
                child: const Text(
                  'upload',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              if (_pickedFile != null) ...[
                if (_pickedFile!.path.endsWith('.pdf'))
                  Text('Picked PDF: ${_pickedFile!.path}')
                else
                  Image.file(
                    _pickedFile!,
                    height: 200,
                  ),
                SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Pick File'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Upload File'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
