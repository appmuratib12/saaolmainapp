import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/TermsAndConditionResponse.dart';
import '../data/network/BaseApiService.dart';


class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}


class _TermConditionScreenState extends State<TermConditionScreen> {
  late Future<TermsAndConditionResponse> _termsFuture;
  final Map<int, bool> _expandedItems = {}; // Track expanded state

  @override
  void initState() {
    super.initState();
    _termsFuture = BaseApiService().getTermsAndCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Terms And Conditions',
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
      body: FutureBuilder<TermsAndConditionResponse>(
        future: _termsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _buildErrorUI();
          } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
            return _buildEmptyUI();
          }

          final faqs = snapshot.data!.data!; // List of FAQ data

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              return _buildFaqItem(faqs[index], index);
            },
          );
        },
      ),
    );
  }


  Widget _buildFaqItem(Data faq, int index) {
    bool isExpanded = _expandedItems[index] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedItems[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Smooth transition
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
                 const Icon(Icons.assignment, color:Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(textAlign:TextAlign.start,
                    faq.title?.toUpperCase() ?? "No title".trim(),
                    style:  const TextStyle(
                      fontSize: 14,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color:AppColors.primaryColor,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0, // Smooth icon rotation
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(), // Empty space when collapsed
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/icons/checked.png', width: 20, height: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        faq.content ?? "No content available".trim(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'FontPoppins',
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
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
              "Failed to load FAQs. Please try again.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _termsFuture = BaseApiService().getTermsAndCondition();
                });
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildEmptyUI() {
    return const Center(
      child: Text(
        "No Terms & Conditions available.",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
