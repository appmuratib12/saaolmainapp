import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:saaolapp/Utils/AddFamilyMemberScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';

class SelectMemberScreen extends StatefulWidget {
  const SelectMemberScreen({super.key});

  @override
  State<SelectMemberScreen> createState() => _SelectMemberScreenState();
}

class _SelectMemberScreenState extends State<SelectMemberScreen> {
  List<Map<String, String>> members = [];
  String? selectedMemberName;

  @override
  void initState() {
    super.initState();
    loadMembersFromPrefs();
  }

  Future<void> loadMembersFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> memberList = prefs.getStringList('members') ?? [];
    String? savedSelected = prefs.getString('selected_member_name');

    setState(() {
      members = memberList
          .map((e) => Map<String, String>.from(jsonDecode(e) as Map))
          .toList();
      selectedMemberName = savedSelected;
    });
  }

  Future<void> _deleteMember(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    members.removeAt(index);
    List<String> memberList = members.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('members', memberList);
    setState(() {});
  }

  void _selectMember(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_member_name', name);
    setState(() {
      selectedMemberName = name;
    });
    Navigator.pop(context, name);
  }

  Future<void> _openAddEditMemberScreen(
      {Map<String, String>? member, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFamilyMemberScreen(
          memberToEdit: member,
          editIndex: index,
        ),
      ),
    );

    if (result != null && result is Map) {
      Map<String, dynamic> updatedMember =
      Map<String, dynamic>.from(result['member']);
      int idx = result['index'] ?? -1;

      if (idx != -1) {
        members[idx] = Map<String, String>.from(updatedMember);
      } else {
        members.add(Map<String, String>.from(updatedMember));
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> memberList = members.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList('members', memberList);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Select Family Member',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _openAddEditMemberScreen();
        },
        icon: const Icon(Icons.person_add,size:20,color:Colors.white),
        label: const Text(
          'Add New Member',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize:13,
            color:Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor:AppColors.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:members.isEmpty
          ?  Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.group_outlined,
                size:50,
                color:AppColors.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'No Members Found',
                style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'FontPoppins',
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please add a family member to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:14,
                  fontFamily: 'FontPoppins',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      )
          : ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          final isSelected = member['name'] == selectedMemberName;

          return GestureDetector(
            onTap: () => _selectMember(member['name'] ?? ''),
            child: Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.person_outline,
                      size:25, color: AppColors.primaryDark),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                member['name'] ?? '',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${member['relation'] ?? ''} | ${member['gender'] ?? ''}, ${member['age'] ?? ''}',
                          style: TextStyle(
                            fontSize:12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [

                      IconButton(
                        icon: const Icon(Icons.edit,
                            color: AppColors.primaryDark),
                        onPressed: () => _openAddEditMemberScreen(
                          member: member,
                          index: index,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title:  const Text('Confirm Delete',
                              style:TextStyle(fontWeight:FontWeight.w500,fontSize:20,
                                  fontFamily:'FontPoppins',color:Colors.black),),
                            content: const Text(
                                'Are you sure you want to delete this member?',
                              style:TextStyle(fontWeight:FontWeight.w500,fontSize:13,
                                fontFamily:'FontPoppins',color:Colors.black87),),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(ctx).pop(),
                                child: const Text('Cancel',style:TextStyle(fontWeight:FontWeight.w500,
                                    fontSize:15,
                                    fontFamily:'FontPoppins',color:Colors.black),),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  _deleteMember(index);
                                },
                                child:const Text('Delete',style:TextStyle(fontWeight:FontWeight.w500,fontSize:15,
                                    fontFamily:'FontPoppins',color:AppColors.primaryColor),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle,
                            color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
