import 'package:flutter/material.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/PrivacyPoliciesResponse.dart';
import '../common/app_colors.dart';
import '../data/network/BaseApiService.dart';

class PrivacyPoliciesScreen extends StatefulWidget {
  const PrivacyPoliciesScreen({super.key});

  @override
  State<PrivacyPoliciesScreen> createState() => _PrivacyPoliciesScreenState();
}

class _PrivacyPoliciesScreenState extends State<PrivacyPoliciesScreen> {
  late Future<PrivacyPoliciesResponse> _privacyFuture;
  final Map<int, bool> _expandedItems = {}; // Track expanded state

  @override
  void initState() {
    super.initState();
    _privacyFuture = BaseApiService().getPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Privacy Policy',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<PrivacyPoliciesResponse>(
              future: _privacyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return _buildErrorUI();
                } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                  return _buildEmptyUI();
                }

                final privacy = snapshot.data!.data!; // List of FAQ data

                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: privacy.length,
                  shrinkWrap: true,
                  clipBehavior: Clip.hardEdge,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildPrivacyItem(privacy[index], index);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Agree & Continue",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildPrivacyItem(Data privacy, int index) {
    bool isExpanded = _expandedItems[index] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedItems[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // Smooth transition
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.privacy_tip, color: AppColors.primaryColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    privacy.title?.toUpperCase() ?? "No title",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0, // Smooth icon rotation
                  duration: const Duration(milliseconds: 300),
                  child:
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(), // Empty space when collapsed
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  privacy.description ?? "No description available",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FontPoppins'),
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  /// UI when API fails
  Widget _buildErrorUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            const Text(
              "Failed to load Privacy Policy. Please try again.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _privacyFuture = BaseApiService().getPrivacyPolicy();
                });
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  /// UI when no FAQs are available
  Widget _buildEmptyUI() {
    return const Center(
      child: Text(
        "No Privacy Policy available.",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'FontPoppins',
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildBodyText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'FontPoppins',
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
}
