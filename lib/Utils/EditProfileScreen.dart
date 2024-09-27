import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../common/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ValueNotifier<double> progressNotifier = ValueNotifier<double>(40.0);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  List<String> countriesArray = ["India", "Bangladesh", "Nepal"];
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  List<String> titleArrays = ["Mrs.", "Mr.", "Ms", "Dr."];

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  String? selectedGender;
  String? selectTitle;

  void _showGenderPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Gender',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: genderOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    genderOptions[index],
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedGender = genderOptions[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showTitlePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Title',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: titleArrays.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    titleArrays[index],
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectTitle = titleArrays[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 2,
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Please complete your profile',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Share your email address to receive booking updates and other critical communication',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SimpleCircularProgressBar(
                                      size: 70.0,
                                      progressStrokeWidth: 8.0,
                                      backStrokeWidth: 7.0,
                                      progressColors: const [
                                        Colors.white,
                                        AppColors.primaryColor,
                                        AppColors.primaryColor
                                      ],
                                      mergeMode: true,
                                      valueNotifier: progressNotifier,
                                      onGetText: (double value) {
                                        return Text(
                                          '${value.toStringAsFixed(1)}%',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'Complete',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.blue[50],
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Basic Information',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: _image != null
                                          ? Image.file(
                                              _image!,
                                              fit: BoxFit.cover,
                                              height: 75,
                                              width: 75,
                                            )
                                          : Image.asset(
                                              'assets/images/profile.png',
                                              fit: BoxFit.cover,
                                              height: 75,
                                              width: 75,
                                            ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40, top: 50),
                                      child: GestureDetector(
                                        onTap: () =>
                                            _showImagePickerOptions(context),
                                        child: Container(
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              width: 0.3,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 18,
                                              color: Colors
                                                  .blue, // Replace AppColors.primaryColor with Colors.blue or your desired color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Title*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: _showTitlePickerDialog,
                                      child: AbsorbPointer(
                                        child: SizedBox(
                                          height: 48,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: selectTitle,
                                            decoration: InputDecoration(
                                              hintText: 'Select Title',
                                              hintStyle: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 20.0,
                                              ),
                                              filled: true,
                                              fillColor: Colors.lightBlue[50],
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w600),
                                            items: ["Mrs.", "Mr.", "Ms", "Dr."]
                                                .map((gender) =>
                                                    DropdownMenuItem<String>(
                                                      value: gender,
                                                      child: Text(gender),
                                                    ))
                                                .toList(),
                                            onChanged: (String? value) {},
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'First Name*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'First Name',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 20.0),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Middle Name*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Middle Name',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 20.0),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Last Name*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Middle Name',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 20.0),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Mobile Number*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Middle Name',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 20.0),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Email ID*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Email ID',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 20.0),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Gender*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedGender,
                                        decoration: InputDecoration(
                                          hintText: 'Middle Name',
                                          hintStyle: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 20.0,
                                          ),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600),
                                        items: ['Male', 'Female', 'Other']
                                            .map((gender) =>
                                                DropdownMenuItem<String>(
                                                  value: gender,
                                                  child: Text(gender),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Date of  Birth*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextFormField(
                                        controller: _dateController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Date',
                                          hintStyle: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 20.0,
                                          ),
                                          filled: true,
                                          fillColor: Colors.lightBlue[50],
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: AppColors.primaryColor,
                                            ),
                                            onPressed: () =>
                                                _selectDate(context),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Nationality*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: _showGenderPickerDialog,
                                      child: AbsorbPointer(
                                        child: SizedBox(
                                          height: 48,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: selectedGender,
                                            decoration: InputDecoration(
                                              hintText: 'Select Gender',
                                              hintStyle: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 20.0,
                                              ),
                                              filled: true,
                                              fillColor: Colors.lightBlue[50],
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w600),
                                            items: ['Male', 'Female', 'Other']
                                                .map((gender) =>
                                                    DropdownMenuItem<String>(
                                                      value: gender,
                                                      child: Text(gender),
                                                    ))
                                                .toList(),
                                            onChanged: (String? value) {},
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
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
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 250,
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
                          'Save',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 16,
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
        ],
      ),
    );
  }
}
