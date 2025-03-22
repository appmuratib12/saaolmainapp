import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../common/app_colors.dart';


class StepCounterScreen extends StatefulWidget {
  const StepCounterScreen({super.key});

  @override
  State<StepCounterScreen> createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _steps = 0; // Updated to an integer for easier calculations
  final int _goal = 2000; // Define a goal for the steps
  List<int> weeklySteps = [4000, 5000, 3000, 7000, 6000, 2000, 4500]; // Example data for weekly steps

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps; // Update steps dynamically
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 0; // Reset steps to zero on error
    });
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;

    if (!granted) {
      granted = await Permission.activityRecognition.request() ==
          PermissionStatus.granted;
    }

    return granted;
  }

  Future<void> initPlatformState() async {
    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) {
      // Inform user that the app will not work without permission
    }

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    (await _pedestrianStatusStream.listen(onPedestrianStatusChanged))
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_steps / _goal).clamp(0.0, 1.0); // Calculate progress
    double caloriesBurnt = (_steps * 0.04).toPrecision(1); // Calculate calories
    double distance = (_steps * 0.8 / 1000).toPrecision(2); // Calculate distance
    double activeTimeMinutes = (_steps / 100).toPrecision(1); // Calculate active time
    int activeHours = (activeTimeMinutes ~/ 60); // Convert to hours
    int remainingMinutes = (activeTimeMinutes % 60).toInt(); // Get remaining minutes

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Step Counter',
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
        physics: const ScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Circular Progress Indicator
              CircularPercentIndicator(
                radius: 130.0,
                lineWidth: 20.0,
                percent: progress, // Dynamically update progress
                center: Container(
                  height: 205,
                  width: 205,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$_steps",
                        style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FontPoppins',
                            color: AppColors.primaryDark),
                      ),
                      const Text(
                        "Steps",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        height: 5,
                        thickness: 0.6,
                        indent: 25,
                        endIndent: 25,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Goal: $_goal Steps",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor.withOpacity(0.8),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                progressColor:AppColors.primaryDark,
                backgroundColor: Colors.grey.withOpacity(0.2),
              ),

              const SizedBox(height: 30),
              // Statistics Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Calories Burnt
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.local_fire_department,
                            color: Colors.orange, size: 36),
                        const SizedBox(height: 4),
                        Text(
                          "${caloriesBurnt.toInt()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,fontFamily:'FontPoppins'),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Kcal burnt",
                          style: TextStyle(fontSize: 16, color: Colors.grey,fontFamily:'FontPoppins',fontWeight:FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // Divider Line
                  Container(
                    height: 100, // Adjust the height as needed
                    width: 2, // Line thickness
                    color: Colors.grey.shade400, // Line color
                  ),
                  // Active Time
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.access_time, color:AppColors.primaryDark, size: 36),
                        const SizedBox(height: 4),
                        Text(
                          "${activeHours}h ${remainingMinutes}m",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,fontFamily:'FontPoppins'),
                        ),
                        SizedBox(height: 4),
                        const Text(
                          "Active time",
                          style: TextStyle(fontSize: 16, color: Colors.grey,fontFamily:'FontPoppins',fontWeight:FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // Divider Line
                  Container(
                    height: 100, // Adjust the height as needed
                    width: 2, // Line thickness
                    color: Colors.grey.shade400, // Line color
                  ),
                  // Distance
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 36),
                        const SizedBox(height: 4),
                        Text(
                          "${distance.toPrecision(1)} km",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'FontPoppins'),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Distance",
                          style: TextStyle(fontSize: 16, color: Colors.grey,fontFamily:'FontPoppins',fontWeight:FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const Divider(
                height: 50,
                thickness: 1,
              ),


              AspectRatio(
                aspectRatio: 1.4,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 8000, // Define max value for Y-axis
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            return Text(days[value.toInt()],
                                style:  const TextStyle(fontSize: 12,fontFamily:'FontPoppins',fontWeight:FontWeight.w500));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(weeklySteps.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: weeklySteps[index].toDouble(),
                            color: AppColors.primaryDark,
                            width: 16,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Divider(
                height: 50,
                thickness: 1,
              ),

               const Text(
                'Pedestrian Status',
                style: TextStyle(fontSize: 25,
                    fontFamily:'FontPoppins',
                    fontWeight:FontWeight.w700,color:Colors.black),
              ),
              Icon(
                _status == 'walking'
                    ? Icons.directions_walk
                    : _status == 'stopped'
                    ? Icons.accessibility_new
                    : Icons.error,
                size: 100,
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'stopped'
                      ?  const TextStyle(fontSize: 30)
                      :  const TextStyle(fontSize: 20, color: Colors.red,fontFamily:'FontPoppins',fontWeight:FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension Precision on num {
  double toPrecision(int fractionDigits) =>
      double.parse(toStringAsFixed(fractionDigits));
}
