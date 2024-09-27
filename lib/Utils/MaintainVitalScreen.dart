import 'package:flutter/material.dart';

class MaintainVitalScreen extends StatefulWidget {
  const MaintainVitalScreen({super.key});

  @override
  State<MaintainVitalScreen> createState() => _MaintainVitalScreenState();
}

class _MaintainVitalScreenState extends State<MaintainVitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
           margin:EdgeInsets.all(10),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


            ],
          ),
        ),
      ),
    );
  }
}
