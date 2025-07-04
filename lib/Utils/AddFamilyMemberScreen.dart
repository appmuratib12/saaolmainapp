import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/constant/ValidationCons.dart';
import 'package:saaolapp/data/model/FamilyMember.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../data/model/requestmodel/AddMemberRequest.dart';
import '../data/network/ChangeNotifier.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  final Map<String, String>? memberToEdit;
  final int? editIndex;
  const AddFamilyMemberScreen({super.key,this.memberToEdit, this.editIndex});

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  String selectedRelation = 'Select Relation*';
  List<String> relationOptions = [
    'Spouse',
    'Child',
    'Brother',
    'Parent',
    'Grand Parent',
    'Sibling',
    'Friend',
    'Relative',
    'Neighbour',
    'Colleague',
    'Others'
  ];
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String saveDate = '';
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.memberToEdit != null) {
      Map<String, String> member = widget.memberToEdit!;
      nameController.text = member['name'] ?? '';
      selectedRelation = member['relation'] ?? 'Select Relation*';
      selectedGender = member['gender'];
      ageController.text = member['age'] ?? '';
      phoneController.text = member['mobile_number'] ?? '';
      emailController.text = member['email'] ?? '';
      saveDate = member['dob'] ?? '';
    }
  }

  void _showGenderPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontSize:16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
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
                      print('Select Gender:$selectedGender');
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
  void _showRelationPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Relation',
              style: TextStyle(
                fontFamily: 'FontPoppins',
                fontSize:18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => Navigator.pop(context),
            ),
          ],
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
      initialDate: DateTime(1995, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:AppColors.primaryColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // ✅ Save formatted DOB (for backend or display)
        saveDate = DateFormat('dd-MM-yyyy').format(picked);

        // ✅ Calculate accurate age based on year, month, day
        DateTime today = DateTime.now();
        int age = today.year - picked.year;
        if (today.month < picked.month || (today.month == picked.month && today.day < picked.day)) {
          age--;
        }

        ageController.text = age.toString();
      });
    }
  }


  bool isMaleSelected = true;

  Future<void> addMember2() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String age = ageController.text.trim();

    if (selectedRelation == 'Select Relation*') {
      _showMessage('Please select a relation.');
      return;
    }
    if (selectedGender == null) {
      _showMessage('Please select a gender.');
      return;
    }

    DialogHelper.showAutoDismissAlert(context);
    AddMemberRequest addMemberRequest = AddMemberRequest(
      name: name,
      mobile_number: phone,
      email: email,
      member_relation: selectedRelation,
      dob: saveDate,
      age: age,
      gender: selectedGender,
    );

    var provider = Provider.of<DataClass>(context, listen: false);

    try {
      await provider.addMemberData(addMemberRequest);
      print("Member API response: ${provider.isBack}");

      Navigator.of(context).pop(); // Dismiss loading dialog

      if (provider.isBack) {
        FamilyMember newMember = FamilyMember(
          name: name,
          relation: selectedRelation,
          gender: selectedGender!,
          age: age,
          emailID:email,
          mobileNumber:phone,
          dateOfBirth:saveDate ?? '',
        );

        print('CheckFamilyMember:${newMember.mobileNumber}');
        print('Saved JSON: ${jsonEncode(newMember.toJson())}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> memberList = prefs.getStringList('members') ?? [];

        if (widget.editIndex != null) {
          // Edit mode
          memberList[widget.editIndex!] = jsonEncode(newMember.toJson());
        } else {
          // Add mode
          memberList.add(jsonEncode(newMember.toJson()));
        }

        await prefs.setStringList('members', memberList);

        Navigator.pop(context, {
          'member': newMember.toJson(),
          'index': widget.editIndex,
        });

        _showMessage(widget.editIndex != null
            ? 'Member updated successfully.'
            : 'Member added successfully.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add member.Please try again.',
              style:TextStyle(fontWeight:FontWeight.w500,fontSize:15,
              color:Colors.white,fontFamily:'FontPoppins'))
            ,backgroundColor:Colors.red,),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss loading dialog
      _showMessage('An error occurred. Please try again later.');
    }
  }


  /*Future<void> addMember() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String age = ageController.text.trim();

    if (selectedRelation == 'Select Relation*') {
      _showMessage('Please select a relation.');
      return;
    }
    if (selectedGender == null) {
      _showMessage('Please select a gender.');
      return;
    }

    DialogHelper.showAutoDismissAlert(context);

    FamilyMember member = FamilyMember(
      name: name,
      relation: selectedRelation,
      gender: selectedGender!,
      age: age,
      emailID:'',
        mobileNumber:phoneController.text.toString(),
        dateOfBirth:_selectedDate.toString()
    );

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> memberList = prefs.getStringList('members') ?? [];

      if (widget.editIndex != null) {
        // Edit mode
        memberList[widget.editIndex!] = jsonEncode(member.toJson());
      } else {
        // Add mode
        memberList.add(jsonEncode(member.toJson()));
      }

      await prefs.setStringList('members', memberList);

      Navigator.of(context).pop(); // close loading dialog
      Navigator.pop(context, {
        'member': member.toJson(),
        'index': widget.editIndex,
      });
    } catch (e) {
      Navigator.of(context).pop(); // close loading dialog
      _showMessage('An error occurred. Please try again later.');
    }
  }*/


  Future<void> saveMemberToPrefs(FamilyMember member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> memberList = prefs.getStringList('members') ?? [];

    memberList.add(jsonEncode(member.toJson()));
    await prefs.setStringList('members', memberList);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style:const TextStyle(fontWeight:FontWeight.w500,fontSize:15,
          color:Colors.white,fontFamily:'FontPoppins'))
        ,backgroundColor:Colors.green,),
    );
  }



  @override
  Widget build(BuildContext context) {
    bool isEditMode = widget.memberToEdit != null;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          isEditMode ? 'Edit Family Member' : 'Add Family Member',
          style: const TextStyle(
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
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Form(
               key:_formKey,
               autovalidateMode: autovalidateMode,
             child:Column(
               crossAxisAlignment:CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 const Text(
                   'Name',
                   style: TextStyle(
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       color: Colors.black,
                       fontFamily: 'FontPoppins'),
                 ),
                 const SizedBox(
                   height:10,
                 ),
                 TextFormField(
                   controller: nameController,
                   keyboardType: TextInputType.name,
                   inputFormatters: [
                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                     LengthLimitingTextInputFormatter(30),
                   ],
                   decoration: InputDecoration(
                     hintText:'Enter your name',
                     hintStyle: const TextStyle(
                         fontSize:14,
                         fontWeight: FontWeight.w500,
                         color: Colors.black54,
                         fontFamily: 'FontPoppins'),
                     prefixIcon: const Icon(Icons.contact_page,
                         color: AppColors.primaryColor),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10.0),
                         borderSide: BorderSide.none),
                     contentPadding:
                     const EdgeInsets.symmetric(vertical:16.0, horizontal: 20.0),
                     filled: true,
                     fillColor: Colors.lightBlue[50],
                   ),
                   validator:ValidationCons().validateName,
                   style: const TextStyle(
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       fontFamily: 'FontPoppins',
                       color: Colors.black),
                 ),
                 /*Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.4)),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

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
              ),*/
                 const SizedBox(
                   height: 10,
                 ),
                 const Text(
                   'Select Your Relation',
                   style: TextStyle(
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       color: Colors.black,
                       fontFamily: 'FontPoppins'),
                 ),
                 const SizedBox(
                   height: 15,
                 ),
                 GestureDetector(
                   onTap: _showRelationPickerDialog,// your custom dialog if needed
                   child: AbsorbPointer(
                     child: SizedBox(
                       child: DropdownButtonFormField<String>(
                         value: relationOptions.contains(selectedRelation) ? selectedRelation : null,
                         decoration: InputDecoration(
                           hintText: 'Select Relation',
                           hintStyle: const TextStyle(
                             fontFamily: 'FontPoppins',
                             fontSize:14,
                             fontWeight: FontWeight.w500,
                             color: Colors.black54,
                           ),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                             borderSide: BorderSide.none,
                           ),
                           contentPadding: const EdgeInsets.symmetric(
                             vertical: 16.0,
                             horizontal: 20.0,
                           ),
                           filled: true,
                           fillColor: Colors.lightBlue[50],
                         ),
                         style: const TextStyle(
                           color: Colors.black,
                           fontSize: 15,
                           fontFamily: 'FontPoppins',
                           fontWeight: FontWeight.w600,
                         ),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please select a relation';
                           }
                           return null;
                         },
                         items: relationOptions.map((relation) {
                           return DropdownMenuItem<String>(
                             value: relation,
                             child: Text(relation),
                           );
                         }).toList(),
                         onChanged: (String? value) {
                           setState(() {
                             selectedRelation = value!;
                           });
                         },
                       ),
                     ),
                   ),
                 ),

                 /* Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.4)),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
              ),*/
                /* const SizedBox(
                   height:10,
                 ),
                 const Text(
                   'Date of birth',
                   style: TextStyle(
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       color: Colors.black,
                       fontFamily: 'FontPoppins'),
                 ),
                 const SizedBox(
                   height:10,
                 ),
                 Row(
                   children: [
                     Expanded(child: TextFormField(
                       readOnly:true,
                       controller:dateController,
                       onTap: (){
                         FocusScope.of(context).requestFocus(FocusNode());
                         _selectDate(context);
                       },
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
                           BorderRadius.circular(10.0),
                           borderSide: BorderSide.none,
                         ),
                         contentPadding:
                         const EdgeInsets.symmetric(
                           vertical:17.0,
                           horizontal: 20.0,
                         ),
                         filled: true,
                         fillColor: Colors.lightBlue[50],
                         suffixIcon:const Icon(
                           Icons.calendar_month,
                           color: AppColors.primaryColor,
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
                   ],
                 ),*/
                 const SizedBox(
                   height:15,
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             'Select Date',
                             style: TextStyle(
                               fontFamily: 'FontPoppins',
                               fontSize: 13,
                               fontWeight: FontWeight.w600,
                               color: Colors.black,
                             ),
                           ),
                           const SizedBox(height: 5),
                          /* GestureDetector(
                             onTap: () => _selectDate(context),
                             child: Container(
                               height:50,
                               decoration: BoxDecoration(
                                 color: Colors.blue[50],
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               padding: const EdgeInsets.all(15),
                               child: Text(
                                 _selectedDate != null
                                     ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                                     : 'Select Date',
                                 style: TextStyle(
                                   fontFamily: 'FontPoppins',
                                   fontSize: 15,
                                   fontWeight: FontWeight.w500,
                                   color:
                                   _selectedDate != null ? Colors.black : Colors.black54,
                                 ),
                               ),
                             ),
                           ),*/

                           FormField<DateTime>(
                             validator: (value) {
                               if (_selectedDate == null) {
                                 return 'Please select a date';
                               }
                               return null;
                             },
                             builder: (FormFieldState<DateTime> state) {
                               return Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   GestureDetector(
                                     onTap: () async {
                                       await _selectDate(context); // sets _selectedDate
                                       state.didChange(_selectedDate); // Notify FormField of change
                                       print('Select Date:$_selectedDate');
                                     },
                                     child: Container(
                                       width:155,
                                       height: 50,
                                       decoration: BoxDecoration(
                                         color: Colors.blue[50],
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       padding: const EdgeInsets.all(15),
                                       child: Text(
                                         (saveDate == null || saveDate.isEmpty) ? 'Select Date' : saveDate,
                                         style: TextStyle(
                                           fontFamily: 'FontPoppins',
                                           fontSize: 15,
                                           fontWeight: FontWeight.w500,
                                           color: (saveDate == null || saveDate.isEmpty) ? Colors.black54 : Colors.black,
                                         ),
                                       ),
                                     ),
                                   ),
                                   if (state.hasError)
                                     Padding(
                                       padding: const EdgeInsets.only(top: 5, left: 8),
                                       child: Text(
                                         state.errorText!,
                                         style: const TextStyle(color: Colors.red, fontSize: 12),
                                       ),
                                     ),
                                 ],
                               );
                             },
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(width:5),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             'Enter Age',
                             style: TextStyle(
                               fontFamily: 'FontPoppins',
                               fontSize: 13,
                               fontWeight: FontWeight.w600,
                               color: Colors.black,
                             ),
                           ),
                           const SizedBox(height: 5),
                           TextFormField(
                             controller: ageController,
                             readOnly: true,
                             keyboardType: TextInputType.number,
                             inputFormatters: [
                               FilteringTextInputFormatter.digitsOnly, // Only allows numbers
                               LengthLimitingTextInputFormatter(2),    // Limit to 2 digits
                             ],
                             decoration: InputDecoration(
                               hintText: 'Enter your age',
                               hintStyle: const TextStyle(
                                 fontFamily: 'FontPoppins',
                                 fontSize: 13,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black54,
                               ),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.0),
                                 borderSide: BorderSide.none,
                               ),
                               contentPadding: const EdgeInsets.symmetric(
                                 vertical: 14.0,
                                 horizontal: 20.0,
                               ),
                               filled: true,
                               fillColor: Colors.lightBlue[50],
                             ),
                             validator: ValidationCons().validateAge,
                             style: const TextStyle(
                               color: Colors.black,
                               fontSize: 14,
                               fontFamily: 'FontPoppins',
                               fontWeight: FontWeight.w600,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),

                 const SizedBox(
                   height: 15,
                 ),
                 const Text('Gender',
                   style: TextStyle(
                       fontFamily: 'FontPoppins',
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       color: Colors.black),
                 ),
                 const SizedBox(height: 10),
                 GestureDetector(
                   onTap: _showGenderPickerDialog, // your custom dialog if needed
                   child: AbsorbPointer(
                     child: SizedBox(
                       child: DropdownButtonFormField<String>(
                         value: genderOptions.contains(selectedGender) ? selectedGender : null,
                         decoration: InputDecoration(
                           hintText: 'Select Gender',
                           hintStyle: const TextStyle(
                             fontFamily: 'FontPoppins',
                             fontSize:14,
                             fontWeight: FontWeight.w500,
                             color: Colors.black54,
                           ),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                             borderSide: BorderSide.none,
                           ),
                           contentPadding: const EdgeInsets.symmetric(
                             vertical: 16.0,
                             horizontal: 20.0,
                           ),
                           filled: true,
                           fillColor: Colors.lightBlue[50],
                         ),
                         style: const TextStyle(
                           color: Colors.black,
                           fontSize: 15,
                           fontFamily: 'FontPoppins',
                           fontWeight: FontWeight.w600,
                         ),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please select a gender';
                           }
                           return null;
                         },
                         items: genderOptions.map((gender) {
                           return DropdownMenuItem<String>(
                             value: gender,
                             child: Text(gender),
                           );
                         }).toList(),
                         onChanged: (String? value) {
                           setState(() {
                             selectedGender = value;
                             //print('Select Gender:$selectedGender');
                           });
                         },
                       ),
                     ),
                   ),
                 ),
                 /* Row(
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
              ),*/
                 const SizedBox(height:15),
                 const Text('Mobile number',
                   style: TextStyle(
                       fontFamily: 'FontPoppins',
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       color: Colors.black),
                 ),
                 const SizedBox(height:15),
                 TextFormField(
                   controller:phoneController,
                   keyboardType: TextInputType.phone,
                   inputFormatters: [
                     FilteringTextInputFormatter.digitsOnly,
                     LengthLimitingTextInputFormatter(10),
                   ],
                   decoration: InputDecoration(
                     hintText: 'Enter your mobile number',
                     hintStyle: const TextStyle(
                       fontFamily: 'FontPoppins',
                       fontSize: 14,
                       fontWeight: FontWeight.w500,
                       color: Colors.black54,
                     ),
                     prefixIcon: const Icon(Icons.phone, color: AppColors.primaryColor),
                     filled: true,
                     fillColor: Colors.lightBlue[50],
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15.0),
                       borderSide: BorderSide.none,
                     ),
                     contentPadding: const EdgeInsets.symmetric(
                         vertical: 15.0, horizontal: 20.0),
                   ),
                   validator: ValidationCons().validateMobile,
                   style: const TextStyle(
                     fontWeight: FontWeight.w600,
                     fontFamily: 'FontPoppins',
                     fontSize: 16,
                     color: Colors.black,
                   ),
                 ),
                 const SizedBox(height:15),
                 const Text('Email ID',
                   style: TextStyle(
                       fontFamily: 'FontPoppins',
                       fontSize:15,
                       fontWeight: FontWeight.w600,
                       color: Colors.black),
                 ),
                 const SizedBox(height:15),
                 TextFormField(
                   keyboardType: TextInputType.emailAddress,
                   controller:emailController,
                   inputFormatters: [
                     LengthLimitingTextInputFormatter(30),
                     FilteringTextInputFormatter.allow(
                       RegExp(r'[a-zA-Z0-9@._\-+]'),
                     ),
                   ],
                   decoration: InputDecoration(
                     hintText: 'Enter your email',
                     hintStyle: const TextStyle(
                         fontFamily: 'FontPoppins',
                         fontSize: 14,
                         fontWeight: FontWeight.w500,
                         color: Colors.black54),
                     prefixIcon: const Icon(Icons.mail,
                         color: AppColors.primaryColor),
                     filled: true,
                     fillColor: Colors.lightBlue[50],
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15.0),
                       borderSide: BorderSide.none,
                     ),
                     contentPadding: const EdgeInsets.symmetric(
                         vertical: 15.0, horizontal: 20.0),
                   ),
                   style: const TextStyle(
                       fontWeight: FontWeight.w600,
                       fontFamily: 'FontPoppins',
                       fontSize: 16,
                       color: Colors.black),
                   validator: ValidationCons().validateEmail,
                 ),
                 /*  CupertinoTextField.borderless(
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
              ),*/
                 const SizedBox(
                   height: 15,
                 ),


                 /*CupertinoTextField.borderless(
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
              ),*/
               ],
             ),
             ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          //addMember1();
                          addMember2();
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        minimumSize: const Size(150, 40),
                      ),
                      child: Text(isEditMode ? 'Update' : 'Add Member',
                          style: const TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ),
                 /* Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                                addMember();

                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
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
                  ),*/
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
