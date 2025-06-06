import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/constant/text_strings.dart';
import 'package:saaolapp/data/model/FamilyMember.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../data/model/requestmodel/AddMemberRequest.dart';
import '../data/network/ChangeNotifier.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  const AddFamilyMemberScreen({super.key});

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  String selectedRelation = 'Select Relation*';
  List<String> relationOptions = [
    'Spouse',
    'Child',
    'Parent',
    'Brother'
    'Grand Parent',
    'Sibling',
    'Friend',
    'Relative',
    'Neighbour',
    'Colleague',
    'Others'
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String saveDate = '';



  void _showRelationPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Relation',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors
                  .primaryColor, // Replace with AppColors.primaryColor if needed
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: relationOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    relationOptions[index],
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedRelation = relationOptions[index];
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

  DateTime? _selectedDate; // Holds the selected date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the current date as the initial date
      firstDate: DateTime(1900), // Set the earliest date for selection
      lastDate: DateTime.now(), // Set the latest date for selection
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        int age = DateTime.now().year - picked.year;
        ageController.text = age.toString();
        saveDate = age.toString();
      });
    }
  }

  bool isMaleSelected = true;


  Future<void> addMember() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String age = ageController.text.trim();

    DialogHelper.showAutoDismissAlert(context);
    AddMemberRequest addMemberRequest = AddMemberRequest(
      name: name,
      mobile_number: phone,
      email: email,
      member_relation: selectedRelation,
      dob: saveDate,
      age: age,
      gender: isMaleSelected ? 'Male' : 'Female',
    );

    var provider = Provider.of<DataClass>(context, listen: false);
    try {
      await provider.addMemberData(addMemberRequest);
      print("Member response: ${provider.isBack}");
      Navigator.of(context).pop();
      if (provider.isBack) {
        FamilyMember newMember = FamilyMember(
          name: name,
          relation: selectedRelation,
          gender: isMaleSelected ? 'Male' : 'Female',
          age: age,
        );
        await saveMemberToPrefs(newMember);
        Navigator.pop(context, newMember.toJson()); // Pass back for screen update
        _showMessage('Member added successfully.');

      } else {
        _showMessage('Failed to add member. Please try again.');
      }
    } catch (e) {
      Navigator.of(context).pop();
      _showMessage('An error occurred. Please try again later.');
    }
  }


  Future<void> saveMemberToPrefs(FamilyMember member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> memberList = prefs.getStringList('members') ?? [];

    memberList.add(jsonEncode(member.toJson()));
    await prefs.setStringList('members', memberList);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Add Family Member',
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.4)),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     const CupertinoTextField.borderless(
                       readOnly: true,
                      padding: EdgeInsets.only(
                          left: 65, top: 10, right: 6, bottom: 10),
                      prefix: Text(name,
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    CupertinoTextField.borderless(
                      controller: nameController,
                      padding:
                          const EdgeInsets.only(top: 10, right: 6, bottom: 10),
                      placeholder: 'Enter member name',
                      placeholderStyle: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.4)),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CupertinoTextField.borderless(
                      readOnly: true,
                      padding: EdgeInsets.only(
                          left: 65, top: 10, right: 6, bottom: 10),
                      prefix: Text(
                        'Member Relation*',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    GestureDetector(
                      onTap: _showRelationPickerDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedRelation,
                              style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 16,
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              color: AppColors.primaryDark,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 0.4,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(date_of_birth,
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[300],
                            ),
                            Text(
                              _selectedDate != null
                                  ? DateFormat('dd-MM-yyyy')
                                      .format(_selectedDate!)
                                  : 'DD-MM-YYYY',
                              style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.4,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(age,
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CupertinoTextField.borderless(
                            controller: ageController,
                            placeholder: 'Ex. - 5 years',
                            placeholderStyle: const TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                gender,
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMaleSelected = true;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isMaleSelected
                            ? AppColors.primaryDark
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isMaleSelected
                              ? AppColors.primaryDark
                              : Colors.grey.withOpacity(0.5),
                          width: 0.4,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            color:
                                isMaleSelected ? Colors.white : Colors.black54,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isMaleSelected
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMaleSelected = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        color: !isMaleSelected
                            ? AppColors.primaryDark
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: !isMaleSelected
                              ? AppColors.primaryDark
                              : Colors.grey.withOpacity(0.5),
                          width: 0.4,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            color:
                                !isMaleSelected ? Colors.white : Colors.black54,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: !isMaleSelected
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.4)),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CupertinoTextField.borderless(
                      readOnly: true,
                      padding: EdgeInsets.only(
                          left: 65, top: 10, right: 6, bottom: 10),
                      prefix: Text(mobile_number,
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    CupertinoTextField.borderless(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      padding:
                          const EdgeInsets.only(top: 10, right: 6, bottom: 10),
                      placeholder: 'Enter mobile number',
                      placeholderStyle: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.4)),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CupertinoTextField.borderless(
                      readOnly: true,
                      padding: EdgeInsets.only(
                          left: 65, top: 10, right: 6, bottom: 10),
                      prefix: Text(email,
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    CupertinoTextField.borderless(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      padding:
                          const EdgeInsets.only(top: 10, right: 6, bottom: 10),
                      placeholder: 'Enter email id',
                      placeholderStyle: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        minimumSize:
                            const Size(150, 40), // Set minimum width and height
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addMember();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        minimumSize:
                            const Size(150, 40), // Set minimum width and height
                      ),
                      child: const Text(
                        'Add Member',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
