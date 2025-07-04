import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saaolapp/Utils/SignInScreen.dart';
import 'package:saaolapp/common/app_colors.dart';
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:saaolapp/constant/text_strings.dart';
import 'package:saaolapp/data/network/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'LocationScreen.dart' as DialogHelper;

class ConfirmDeleteAccountScreen extends StatefulWidget {
  const ConfirmDeleteAccountScreen({super.key});

  @override
  State<ConfirmDeleteAccountScreen> createState() =>
      _ConfirmDeleteAccountScreenState();
}

class _ConfirmDeleteAccountScreenState
    extends State<ConfirmDeleteAccountScreen> {
  Future<void> _showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/question_mark_icon.png',
                fit: BoxFit.contain, width: 50, height: 50),
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    color: Colors.black)),
          ],
        ),
        content: Text(
            textAlign: TextAlign.center,
            message,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'FontPoppins',
                color: Colors.grey)),
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'FontPoppins',
                        color: Colors.white)),
              ),
              Expanded(child: Container()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'FontPoppins',
                        color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
    if (confirmed == true) {
      onConfirm();
    }
  }

  // Temporary deactivation
  Future<void> _deactivateAccount(BuildContext context) async {
    await _showConfirmationDialog(
      context: context,
      title: "Deactivate Account",
      message: "Are you sure you want to deactivate your account temporarily?",
      onConfirm: () async {
        // Simulate deactivation
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your account has been deactivated."),
          backgroundColor: Colors.orange,
        ));
      },
    );
  }

  // Permanent deletion
  Future<void> _deleteAccount(BuildContext context) async {
    await _showConfirmationDialog(
      context: context,
      title: "Delete Account",
      message: "Are you sure you want to permanently delete your account?"
          "Your profile, appointments, and all personal data will be removed permanently.",
      onConfirm: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
          (_) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your account has been permanently deleted."),
          backgroundColor: Colors.red,
        ));
      },
    );
  }

  int? _selectedReasonIndex;
  String _otherReason = '';

  final List<String> _reasons = [
    'No longer using the app',
    'Joined another health program',
    'Did not find the app helpful',
    'Found the services expensive',
    'Others (please specify)',
    /* 'Too many notifications or messages',
    'App is slow or difficult to use',
    'Technical issues or bugs',
    'Prefer in-person treatment',
    'Others (please specify)',*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Help',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            child: const Text(
              'Close',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'FontPoppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "How do I delete my account?",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'FontPoppins'),
                  )),
              Container(
                height: 150,
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          children: [
                            const TextSpan(
                              text: accountDelete_Txt,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "click here",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  _showFullScreenDeleteDialog(context);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )

              /* const Text(
                  'If you need to delete account and you are prompted to provide a reason',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'FontPoppins',
                      color: Colors.grey),
                ),*/
              /* const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _reasons.length,
                          itemBuilder: (context, index) {
                            return RadioListTile<int>(
                              value: index,
                              groupValue: _selectedReasonIndex,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedReasonIndex = value;
                                });
                              },
                              title: Text(_reasons[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black87)),
                              activeColor: AppColors.primaryColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            );
                          },
                        ),
                        if (_selectedReasonIndex == _reasons.length - 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  maxLength: 150,
                                  maxLines: 3,
                                  onChanged: (value) {
                                    setState(() {
                                      _otherReason = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Write a message here",
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.grey),
                                    fillColor: Colors.grey[100],
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _deactivateAccount(context),
                    icon: const Icon(Icons.pause_circle_filled,
                        color: Colors.white),
                    label: const Text(
                      "Deactivate Account (Temporary)",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'FontPoppins',
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),*/
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenDeleteDialog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true, // ✅ makes it look like a modal
        builder: (context) => const DeleteAccountScreen(),
      ),
    );
  }
}

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Deleting account",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'FontPoppins',
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                              text: "Deleting an account is a ",
                              style: TextStyle(color: Colors.black54)),
                          TextSpan(
                            text: "permanent action and cannot be reversed. ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                color: Colors.black87),
                          ),
                          TextSpan(
                            text:
                                "In case you want to use our services again, you will need to create a new account which will have no previous order history.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "By deleting your account, the following data will be permanently removed:",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FontPoppins',
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildBullet("Erase your appointment history"),
                              _buildBullet(
                                  "Delete your saved health reports and assessments"),
                              _buildBullet(
                                  "Remove your enrolled wellness or treatment plans"),
                              _buildBullet(
                                  "Delete any saved family member or patient profiles"),
                              _buildBullet(
                                  "Remove your saved address and location details"),
                              _buildBullet(
                                  "Clear your chat history with health advisors or doctors"),
                              _buildBullet(
                                  "Delete your stored profile and contact information"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountDelete()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Continue to delete account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'FontPoppins',
                  color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountDelete extends StatefulWidget {
  const AccountDelete({super.key});

  @override
  State<AccountDelete> createState() => _AccountDeleteState();
}

class _AccountDeleteState extends State<AccountDelete> {
  TextEditingController reasonController = TextEditingController();
  int? _selectedReasonIndex;
  String otherReason = '';
  final List<String> _reasons = [
    'No longer using the app',
    'Did not find the app helpful',
    'Found the services expensive',
    'Others (please specify)',
    /* 'Too many notifications or messages',
    'App is slow or difficult to use',
    'Technical issues or bugs',
    'Prefer in-person treatment',
    'Others (please specify)',*/
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_selectedReasonIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Please select a reason."),
                      backgroundColor: Colors.red),
                );
                return;
              }
              if (_selectedReasonIndex == _reasons.length - 1) {
                if (reasonController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter your reason."),
                        backgroundColor: Colors.red),
                  );
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationAccountDelete(
                      reason: reasonController.text.trim(),
                    ),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationAccountDelete(
                      reason: _reasons[_selectedReasonIndex!],
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Continue to delete account",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'FontPoppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("We're sorry to see you go!",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'FontPoppins',
                          color: Colors.black)),
                  const SizedBox(height: 5),
                  const Text(
                    'Tell us the reason for deleting your account',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'FontPoppins',
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _reasons.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<int>(
                            value: index,
                            groupValue: _selectedReasonIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedReasonIndex = value;
                              });
                            },
                            title: Text(_reasons[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black87)),
                            activeColor: AppColors.primaryColor,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                          );
                        },
                      ),
                      if (_selectedReasonIndex == _reasons.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Write your reason",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: reasonController,
                                maxLength: 150,
                                maxLines: 3,
                                onChanged: (value) {
                                  setState(() {
                                    otherReason = value;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Write a message here...",
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF7F7F7),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationAccountDelete extends StatefulWidget {
  final String reason;

  const ConfirmationAccountDelete({super.key, required this.reason});

  @override
  State<ConfirmationAccountDelete> createState() =>
      _ConfirmationAccountDeleteState();
}

class _ConfirmationAccountDeleteState extends State<ConfirmationAccountDelete> {
  late SharedPreferences sharedPreferences;
  String getPatientID = '';
  String saveUserID = '';

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = sharedPreferences.getString('pmId') ?? '';
      saveUserID = sharedPreferences.getString(ApiConstants.USER_ID) ?? '';
    });
  }

  Future<void> _deleteUserAccount() async {
    DialogHelper.showLoadingDialog(context);
    print("Deleting account with reason: ${widget.reason}");
    final response = await ApiService().userAccountDelete(
      reason: widget.reason,
      userID: saveUserID,
    );
    Navigator.of(context, rootNavigator: true).pop();
    if (response != null && response.status == 'success') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AccountDeletedScreen()));
      _showSnackBar('Your account has been permanently deleted.', Colors.green);
    } else {
      _showSnackBar('Failed to delete account. Please try again.', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _deleteUserAccount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Delete account",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'FontPoppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('If you change your mind!',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'FontPoppins',
                          color: Colors.black)),
                  SizedBox(height: 5),
                  Text('Your account will be deleted after 30 days from now',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: 'FontPoppins',
                          color: Colors.black)),
                ],
              ),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                        children: [
                          const TextSpan(
                            text: deleteAccountConfirm_Txt,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "info@saaolinfotech.com",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: 'info@saaolinfotech.com',
                                );

                                if (await canLaunchUrl(emailUri)) {
                                  await launchUrl(emailUri, mode: LaunchMode.externalApplication);
                                } else {
                                  debugPrint('Could not launch email client');
                                }
                              },
                          ),
                          const TextSpan(
                            text: ' within this period to prevent account closure.',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccountDeletedScreen extends StatefulWidget {
  const AccountDeletedScreen({super.key});

  @override
  State<AccountDeletedScreen> createState() => _AccountDeletedScreenState();
}

class _AccountDeletedScreenState extends State<AccountDeletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
                (_) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Your account has been permanently deleted."),
                backgroundColor: Colors.red,
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Close",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'FontPoppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                      'https://as1.ftcdn.net/jpg/04/53/37/22/1000_F_453372225_wf4UFrw3szVaqWJsJhLHDnm8X82doFAi.jpg',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 150),
                  const SizedBox(height: 10),
                  const Text(
                    'Your account has been suspended and will be deleted after 30 days',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'FontPoppins',
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    afterDelete_Txt1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'FontPoppins',
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    afterDelete_Txt2,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'FontPoppins',
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    afterDelete_Txt3,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'FontPoppins',
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
