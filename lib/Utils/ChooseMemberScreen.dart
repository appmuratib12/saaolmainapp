import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaoldemo/Utils/AddFamilyMemberScreen.dart';
import '../common/app_colors.dart';

class SelectMemberScreen extends StatefulWidget {
  const SelectMemberScreen({super.key});

  @override
  State<SelectMemberScreen> createState() => _SelectMemberScreenState();
}

class _SelectMemberScreenState extends State<SelectMemberScreen> {
  final List<Map<String, String>> members = [
    {'name': 'Mohd Muratib', 'relation': 'Self', 'gender': 'Male', 'age': '24'},
    {'name': 'Sahil', 'relation': 'Colleague', 'gender': 'Male', 'age': '24'},
  ];

  void _addNewMember(Map<String, String> newMember) {
    setState(() {
      members.add(newMember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Choose Member',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...members.map(
              (member) => GestureDetector(
                onTap: () {
                  Navigator.pop(context, member['name']);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 4), // Offset in x and y (x, y)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            member['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'FontPoppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            member['relation'] ?? '',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FontPoppins',
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${member['gender']}, ${member['age']}',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'FontPoppins',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const AddFamilyMemberScreen()),
                );

                if (result != null && result is Map<String, String>) {
                  _addNewMember(result);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add new member',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FontPoppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
