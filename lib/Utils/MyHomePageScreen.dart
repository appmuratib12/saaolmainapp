import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../responsemodel/HomePageScreen1.dart';
import 'AppointmentsScreen.dart';
import 'MyProfileScreen.dart';
import 'NavBarScreens/OurCenterScreen.dart';
import 'NavBarScreens/TreatmentScreen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialIndex});

  final int initialIndex;
  static List<NavigationDestination> navigation = <NavigationDestination>[
     const NavigationDestination(
      selectedIcon: Icon(
        Icons.home,
        color: AppColors.primaryColor,
      ),
      icon: Icon(
        Icons.home_outlined,
        color: Colors.white,
      ),
      label: 'Home',
    ),
    const NavigationDestination(
      selectedIcon: Icon(
        Icons.calendar_month,
        color: AppColors.primaryColor,
      ),
      icon: Icon(
        Icons.calendar_month,
        color: Colors.white,
      ),
      label: 'Appointments',
    ),
    const NavigationDestination(
      selectedIcon: Image(
        image: AssetImage('assets/icons/stethscope_icon.png'),
        width: 20,
        height: 20,
        color: AppColors.primaryColor,
      ),
      icon: Image(
        image: AssetImage('assets/icons/stethscope_icon.png'),
        width: 20,
        height: 20,
        color: Colors.white,
        fit: BoxFit.cover,
      ),
      label: 'Treatments',
    ),
    const NavigationDestination(
      selectedIcon: Image(
        image: AssetImage('assets/icons/residential.png'),
        width: 25,
        height: 25,
        fit: BoxFit.cover,
        color: AppColors.primaryColor,
      ),
      icon: Image(
        image: AssetImage('assets/icons/residential.png'),
        width: 25,
        height: 25,
        fit: BoxFit.cover,
        color: Colors.white,
      ),
      label: 'Our Centers',
    ),
    const NavigationDestination(
      selectedIcon: Icon(
        Icons.account_circle,
        color: AppColors.primaryColor,
      ),
      icon: Icon(
        Icons.account_circle_outlined,
        color: Colors.white,
      ),
      label: 'My Profile',
    ),
  ];

  @override
  State<HomePage> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<HomePage> {
  late int currentIndex;

  final pages = [
    const HomPageScreen1(),
    const MyAppointmentsScreen(),
    const ExpandableListView(),
    const OurCenterScreen(),
    const MyProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: currentIndex,
          height: 60,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: HomePage.navigation,
        ),
      ),
    );
  }
}
