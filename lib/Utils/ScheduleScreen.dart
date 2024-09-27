import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedDateIndex = 0; // Default selected date index (first date)
  int selectedTimeIndex = 0; // Default selected time index (08:00 AM)

  List<DateTime> dateList = [];
  List<String> times = ['08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM'];

  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  // Generate 5 dates starting from the current date
  void _generateDateList() {
    dateList.clear();
    for (int i = 0; i < 5; i++) {
      dateList.add(selectedDate.add(Duration(days: i)));
    }
  }

  // Function to show the date picker and update the date list
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // Disable dates before today
      lastDate: DateTime.now()
          .add(const Duration(days: 4)), // Disable dates after 4 days from now
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _generateDateList();
        selectedDateIndex = 0; // Reset the selected date to the first one
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('E\nd').format(date); // Formats the date like 'Wed\n20'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Date & Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Schedule Date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd').format(selectedDate),
                        // Display selected date
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      width: 70,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedDateIndex == index
                            ? Colors.blue
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          formatDate(dateList[index]),
                          style: TextStyle(
                            color: selectedDateIndex == index
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: times.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedTimeIndex == index
                            ? Colors.blue
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          times[index],
                          style: TextStyle(
                            color: selectedTimeIndex == index
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
