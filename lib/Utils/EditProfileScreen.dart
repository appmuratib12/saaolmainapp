import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import 'package:saaoldemo/constant/ValidationCons.dart';
import '../common/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


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
  late SharedPreferences sharedPreferences;
  String getName = '';
  String getEmail = '';
  String getPhone = '';
  String getPassword = '';
  String getLastName = '';
  bool _obscureText = true;
  bool value = false;
  bool checkedValue = true;
  String saveUserID = '';
  String getDob = '';


  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;


  String? selectedValue1;
  DateTime selectedDate1 = DateTime.now();


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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:AppColors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: Colors.lightBlue.shade50, // Background color of the calendar
          ),
          child: child!,
        );
      },
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
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library',style:TextStyle(fontWeight:FontWeight.w500,
                    fontFamily:'FontPoppins',fontSize:16,color:Colors.black)),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera',style:TextStyle(fontWeight:FontWeight.w500,
                    fontFamily:'FontPoppins',fontSize:16,color:Colors.black),),
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


  String getPatientID = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }


  void _updateSharedPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _saveUpdatedData() {
    String updatePatientName = nameController.text.trim();
    String updatePatientLastName = lastNameController.text.trim();
    String updatePatientEmail = emailController.text.trim();
    String updatePatientPhone = phoneController.text.trim();
    String updatePatientPassword = passwordController.text.trim();
    String updatePatientDob = _dateController.text.trim();
    String updatePatientGender = selectedGender.toString();

    if (updatePatientName.isNotEmpty && updatePatientEmail.isNotEmpty &&
        updatePatientPhone.isNotEmpty && updatePatientLastName.isNotEmpty &&
        updatePatientPassword.isNotEmpty && updatePatientDob.isNotEmpty &&
        updatePatientGender.isNotEmpty) {

      _updateSharedPreferences('PatientFirstName', updatePatientName);
      _updateSharedPreferences('PatientLastName', updatePatientLastName);
      _updateSharedPreferences('PatientEmailName', updatePatientEmail);
      _updateSharedPreferences('PatientPhoneName', updatePatientPhone);
      _updateSharedPreferences('PatientPassword',  updatePatientPassword);
      _updateSharedPreferences('PatientDob',  updatePatientDob);
      _updateSharedPreferences('PatientGender',  updatePatientGender);
      print("Updated First Name: $updatePatientName");
    } else {
      print("fields is empty, nothing to update.");
    }
  }

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = sharedPreferences.getString('pmId') ?? '';

      if (getPatientID.isNotEmpty) {
        _loadPatientData();
      } else {
        _loadDefaultUserData();
      }
    });
  }

  void _loadPatientData() {
    getName = sharedPreferences.getString('PatientFirstName') ?? '';
    getLastName = sharedPreferences.getString('PatientLastName') ?? '';
    getPhone = sharedPreferences.getString('PatientContact') ?? '';
    getEmail = sharedPreferences.getString('patientEmail') ?? '';
    selectedGender = sharedPreferences.getString('PatientGender') ?? '';
    getDob = sharedPreferences.getString('PatientDob') ?? '';
    selectTitle = sharedPreferences.getString('PatientSalutation') ?? '';
    nameController.text = getName;
    emailController.text = getEmail;
    phoneController.text = getPhone;
    lastNameController.text = getLastName;
    genderController.text = selectedGender ?? '';
    _dateController.text = getDob;

    print('LastName:--> $getLastName');
  }

  void _loadDefaultUserData() {
    getName = sharedPreferences.getString(ApiConstants.USER_NAME) ?? '';
    getPhone = sharedPreferences.getString(ApiConstants.USER_MOBILE) ?? '';
    getEmail = sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '';
    getPassword = sharedPreferences.getString(ApiConstants.USER_PASSWORD) ?? '';
    saveUserID = sharedPreferences.getString(ApiConstants.USER_ID) ?? '';

    nameController.text = getName;
    emailController.text = getEmail;
    phoneController.text = getPhone;
    passwordController.text = getPassword;

    print('userEmail --> $getEmail');
    print('LogOut Message --> $getName');
    print('getTokenStudent --> $getPhone');
  }


  Future<void> uploadImage(String id) async {
    String name = nameController.text.trim();
    String mobileNumber = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String lastName = lastNameController.text.trim();



    if (_image == null) {
      print('No image selected');
      return;
    }

    _showLoadingDialog();
    var stream = http.ByteStream(_image!.openRead());
    var length = await _image!.length();
    var uri = Uri.parse(
        'https://saaol.org/saaolnewapp/api/update-profile/$id');


    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['password'] = password;
    request.fields['email'] = email;
    request.fields['mobile'] = mobileNumber;
    request.fields['last_name'] = lastName;

    var multipartFile = http.MultipartFile('image', stream, length,
        filename: path.basename(_image!.path));
    request.files.add(multipartFile);

    try {
      var response = await request.send();
      Navigator.of(context, rootNavigator: true).pop();

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

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 20,
            ),
          ),
        ),
      ),
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
          icon:  const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                                autovalidateMode: autovalidateMode,
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
                                            onChanged: (String? value) {

                                            },
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
                                    TextFormField(
                                      controller:nameController,
                                      keyboardType:TextInputType.name,
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
                                      validator: ValidationCons().validateName,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller:lastNameController,
                                      keyboardType:TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: 'Last Name',
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
                                      validator: ValidationCons().validateName,
                                    ),
                                    const SizedBox(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller:phoneController,
                                      keyboardType:TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: 'Mobile Number',
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
                                      validator: ValidationCons().validateMobile,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller:emailController,
                                      keyboardType:TextInputType.emailAddress,
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
                                      validator: ValidationCons().validateEmail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height:10,),
                                    const Text(
                                      'Password*',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller:passwordController,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        hintText:'Password',
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
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.primaryDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 20.0),
                                        filled: true,
                                        fillColor: Colors.lightBlue[50],
                                      ),
                                      validator: ValidationCons().validatePassword,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
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
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
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
                                            icon: const Icon(
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
                                    const SizedBox(
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
                  const SizedBox(
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            uploadImage(saveUserID.toString());
                            _saveUpdatedData();


                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
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
