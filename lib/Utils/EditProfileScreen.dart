import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saaolapp/constant/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../constant/ApiConstants.dart';
import '../constant/ValidationCons.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ValueNotifier<double> progressNotifier = ValueNotifier<double>(40.0);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> nationalityOptions = ['India','China','Bangladesh','Nepal'];
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
    nameController.removeListener(_updateProgress);
    lastNameController.removeListener(_updateProgress);
    phoneController.removeListener(_updateProgress);
    emailController.removeListener(_updateProgress);
    passwordController.removeListener(_updateProgress);
    progressNotifier.dispose();
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
  String? selectNationality;

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
              fontSize:16,
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
                      fontSize: 14,
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
              fontSize:16,
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
                      fontSize:14,
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
  void _showNationalityPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Nationality',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize:16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nationalityOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    nationalityOptions[index],
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectNationality = nationalityOptions[index];
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
    _loadProfileImage();
    nameController.addListener(_updateProgress);
    lastNameController.addListener(_updateProgress);
    phoneController.addListener(_updateProgress);
    emailController.addListener(_updateProgress);
    passwordController.addListener(_updateProgress);
    _updateProgress();
  }
  void _updateProgress() {
    int filled = 0;
    int total = 5;
    if (nameController.text.trim().isNotEmpty) filled++;
    if (lastNameController.text.trim().isNotEmpty) filled++;
    if (phoneController.text.trim().isNotEmpty) filled++;
    if (emailController.text.trim().isNotEmpty) filled++;
    if (passwordController.text.trim().isNotEmpty) filled++;
    double progress = (filled / total) * 100;
    progressNotifier.value = progress;

  }


  void _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('userProfileImage');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }


  Future<void> _saveUpdatedData() async {
    String updatedName = nameController.text;
    String updatedLastName = lastNameController.text;
    String updatedEmail = emailController.text;
    String updatedPhone = phoneController.text;
    String updatedGender = genderController.text;
    String updatedDob = _dateController.text;


    await sharedPreferences.setString('PatientFirstName', updatedName);
    await sharedPreferences.setString('PatientLastName', updatedLastName);
    await sharedPreferences.setString('PatientContact', updatedPhone);
    await sharedPreferences.setString('patientEmail', updatedEmail);
    await sharedPreferences.setString('PatientGender', updatedGender);
    await sharedPreferences.setString('PatientDob', updatedDob);
    await sharedPreferences.setString('GoogleUserName',updatedName);
    await sharedPreferences.setString('GoogleUserEmail',updatedEmail);
    await sharedPreferences.setString(ApiConstants.APPLE_NAME,updatedName);
    await sharedPreferences.setString(ApiConstants.APPLE_EMAIL,updatedEmail);


    await sharedPreferences.setString(ApiConstants.USER_NAME, updatedName);
    await sharedPreferences.setString(ApiConstants.USER_MOBILE, updatedPhone);
    await sharedPreferences.setString(ApiConstants.USER_EMAIL, updatedEmail);
    await sharedPreferences.setString(ApiConstants.USER_PASSWORD, passwordController.text);
    await sharedPreferences.setString(ApiConstants.LAST_NAME,updatedLastName);
    await sharedPreferences.setString(ApiConstants.GENDER,selectedGender.toString());
    await sharedPreferences.setString(ApiConstants.TITLE,selectTitle.toString());
    await sharedPreferences.setString(ApiConstants.DOB,updatedDob);
    await sharedPreferences.setString(ApiConstants.NATIONALITY,selectNationality.toString());
    if (_image != null) {
      await sharedPreferences.setString('userProfileImage', _image!.path);
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
    getPassword = sharedPreferences.getString(ApiConstants.USER_PASSWORD) ?? '';
    selectNationality = sharedPreferences.getString(ApiConstants.NATIONALITY) ?? '';


    nameController.text = getName;
    emailController.text = getEmail;
    phoneController.text = getPhone;
    lastNameController.text = getLastName;
    genderController.text = selectedGender ?? '';
    _dateController.text = getDob;
    passwordController.text = getPassword;

  }
  void _loadDefaultUserData() {
    final googleName = sharedPreferences.getString('GoogleUserName') ?? sharedPreferences.getString(ApiConstants.APPLE_NAME)?? '';
    final googleEmail = sharedPreferences.getString('GoogleUserEmail') ?? sharedPreferences.getString(ApiConstants.APPLE_EMAIL)?? '';
    getName = sharedPreferences.getString(ApiConstants.USER_NAME) ??  '';
    getPhone = sharedPreferences.getString(ApiConstants.USER_MOBILE) ?? '';
    getEmail = sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '';
    getPassword = sharedPreferences.getString(ApiConstants.USER_PASSWORD) ?? '';
    saveUserID = sharedPreferences.getString(ApiConstants.USER_ID) ?? '';
    getLastName = sharedPreferences.getString(ApiConstants.LAST_NAME) ?? '';
    selectedGender = sharedPreferences.getString(ApiConstants.GENDER) ?? '';
    selectTitle = sharedPreferences.getString(ApiConstants.TITLE) ?? '';
    getDob = sharedPreferences.getString(ApiConstants.DOB) ?? '';
    selectNationality = sharedPreferences.getString(ApiConstants.NATIONALITY) ?? '';
    if (getName.isEmpty) {
      getName = googleName;
    }
    if (getEmail.isEmpty) {
      getEmail = googleEmail;
    }
    nameController.text = getName;
    emailController.text = getEmail;
    phoneController.text = getPhone;
    passwordController.text = getPassword;
    lastNameController.text = getLastName;
    genderController.text = selectedGender ?? '';
    _dateController.text = getDob;
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

    DialogHelper.showLoadingDialog(context);

    var stream = http.ByteStream(_image!.openRead());
    var length = await _image!.length();
    var uri = Uri.parse('https://saaol.org/saaolnewapp/api/update-profile/$id');

    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['password'] = password;
    request.fields['email'] = email;
    request.fields['mobile'] = mobileNumber;
    request.fields['last_name'] = lastName;

    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: path.basename(_image!.path),
    );
    request.files.add(multipartFile);

    try {
      var response = await request.send();
      Navigator.of(context, rootNavigator: true).pop();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('Response: $responseString');

      if (response.statusCode == 200) {
        await _saveUpdatedData();
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
            content: Text('Profile updated successfully!',
              style:
              TextStyle(fontWeight:FontWeight.w500,
                fontSize:14,fontFamily:'FontPoppins',color:Colors.white),),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Failed to upload. Status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Upload failed',
            style:TextStyle(fontWeight:FontWeight.w500,
              fontSize:14,fontFamily:'FontPoppins',color:Colors.white),),backgroundColor:Colors.red,),
        );
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
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
                        color:AppColors.primaryColor.withOpacity(0.5),
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
                                        fontSize: 14,
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
                                        fontSize: 11,
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
                                            fontSize: 16.0,
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
                                      fontSize: 12,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height:5,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:AppColors.primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
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
                                      'Title',
                                      style: TextStyle(
                                          fontSize: 14,
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
                                          child: DropdownButtonFormField<String>(
                                            value: titleArrays.contains(selectTitle) ? selectTitle : null,
                                            decoration: InputDecoration(
                                              hintText: 'Select Title',
                                              hintStyle: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 13,
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
                                                fontSize:14,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w600),
                                            items: titleArrays.map((title) =>
                                                    DropdownMenuItem<String>(
                                                      value: title,
                                                      child: Text(title),
                                                    ))
                                                .toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectTitle = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'First Name',
                                      style: TextStyle(
                                          fontSize: 13,
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
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    const Text(
                                      'Last Name',
                                      style: TextStyle(
                                          fontSize: 13,
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
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                      validator: ValidationCons().validateName,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      mobile_number,
                                      style: TextStyle(
                                          fontSize: 14,
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
                                            fontSize: 13,
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
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Email ID',
                                      style: TextStyle(
                                          fontSize: 14,
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
                                            fontSize: 13,
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
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height:10,),
                                    const Text(
                                      'Password',
                                      style: TextStyle(
                                          fontSize: 14,
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
                                            fontSize: 13,
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
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(gender,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: _showGenderPickerDialog, // your custom dialog if needed
                                      child: AbsorbPointer(
                                        child: SizedBox(
                                          height: 50,
                                          child: DropdownButtonFormField<String>(
                                            value: genderOptions.contains(selectedGender) ? selectedGender : null,
                                            decoration: InputDecoration(
                                              hintText: 'Select Gender',
                                              hintStyle: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 20.0,
                                              ),
                                              filled: true,
                                              fillColor: Colors.lightBlue[50],
                                            ),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                            items: genderOptions.map((gender) {
                                              return DropdownMenuItem<String>(
                                                value: gender,
                                                child: Text(gender),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedGender = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(date_of_birth,
                                      style: TextStyle(
                                          fontSize: 14,
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
                                        readOnly:true,
                                        controller: _dateController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Date',
                                          hintStyle: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 13,
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
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Nationality',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    GestureDetector(
                                      onTap: _showNationalityPickerDialog,
                                      child: AbsorbPointer(
                                        child: SizedBox(
                                          height:50,
                                          child: DropdownButtonFormField<String>(
                                            value: nationalityOptions.contains(selectNationality) ? selectNationality : null,
                                            decoration: InputDecoration(
                                              hintText: 'Select Nationality',
                                              hintStyle: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 20.0,
                                              ),
                                              filled: true,
                                              fillColor: Colors.lightBlue[50],
                                            ),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                            items: nationalityOptions.map((country) {
                                              return DropdownMenuItem<String>(
                                                value: country,
                                                child: Text(country),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectNationality = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            uploadImage(saveUserID.toString());
                            //await _saveUpdatedData();
                            //Navigator.pop(context, true);

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
