import 'package:flutter/material.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/FaqsResponse.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  late Future<FaqsResponse> _faqsFuture;
  final Map<int, bool> _expandedItems = {}; // Track expanded state

  @override
  void initState() {
    super.initState();
    _faqsFuture = BaseApiService().getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "FAQs",
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<FaqsResponse>(
        future: _faqsFuture,
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
                const Icon(Icons.question_answer, color: AppColors.primaryColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    faq.title ?? "No title",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily:'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
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
                child: Text(
                  faq.description ?? "No description available",
                  style:  const TextStyle(fontSize: 14, color: Colors.black87,fontWeight:FontWeight.w500,fontFamily:'FontPoppins'),
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
                  _faqsFuture = BaseApiService().getFaqs();
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
        "No FAQs available.",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
