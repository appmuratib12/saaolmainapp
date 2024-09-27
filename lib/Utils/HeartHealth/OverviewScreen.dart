import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  List<String> overviewArray = [
    "The Risk Factor",
    "Healthier Lifestyle",
    "Non-Modifiable Risk Factor",
    "Modifiable Risk Factor",
    "What to do after heart Attack",
    "Parameter for Reversal",
    "Prevent Heart Attacks"
  ];
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Overview',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: overviewArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedIndex;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Update the selected index
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                height: 40,
                                constraints: const BoxConstraints(
                                  minWidth: 200,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(padding: EdgeInsets.all(10),child:Center(
                                  child: Text(
                                    overviewArray[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),)
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (selectedIndex ==0)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'The Risk Factor',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            riskFactorTxt,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'TO GIVE YOU A ROUGH IDEA, THE DISTRIBUTION OF THESE RISK FACTORS IS MENTIONED BELOW',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          buildRiskFactorItem(
                              'Habits and Lifestyle, Psychosocial', '54'),
                          buildRiskFactorItem('Physical and Biochemical', '16'),
                          buildRiskFactorItem('Serum / Blood Measurements', '44'),
                          buildRiskFactorItem('Medical conditions or Diseases', '45'),
                          buildRiskFactorItem('Dietary deficiency (inverse association)', '23'),
                          buildRiskFactorItem('Dietary excess (negative association)', '21'),
                          buildRiskFactorItem('Constitutional, demographic', '16'),
                          buildRiskFactorItem('Blood Clotting (Platelet) Disorders', '16'),
                          buildRiskFactorItem('Environmental', '5'),
                          buildRiskFactorItem('Drugs', '6'),
                        ],
                      ),
                    ),
                  ),
                ),
              if (selectedIndex ==1)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Healthier Lifestyle',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            textAlign: TextAlign.justify,
                            healthierTxt,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Here are the steps to take',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildHealthierSteps('Quit smoking.'),
                          buildHealthierSteps('Watch your eating habits.'),
                          buildHealthierSteps('Be more active.'),
                          buildHealthierSteps(
                              'Take your medicine to control your blood pressure.'),
                          const Text(
                            'How do I stop smoking?',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildHealthierSmoking(
                              'Be conscious of the repercussions and have a strong will power.'),
                          buildHealthierSmoking(
                              'Ask your health care professional for information and programs that may help.'),
                          buildHealthierSmoking(
                              "Fight the urge by going where smoking isn't allowed and staying around people who don't smoke."),
                          buildHealthierSmoking(
                              'Reward yourself when you quit.'),
                          buildHealthierSmoking(
                              'keep busy doing things that make it hard to smoke.'),
                          buildHealthierSmoking(
                              'Remind yourself that smoking causes many diseases can harm others and is deadly.'),
                          buildHealthierSmoking(
                              'Ask your family and friends to support you.'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'How do I change my eating habits?',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildHealthierEatingHabits(
                              'Ask your doctor, nurse or licensed nutritionist for help.'),
                          buildHealthierEatingHabits(
                              'Avoid foods like egg yolks, fatty meats, skin-on chicken, butter and cream.'),
                          buildHealthierEatingHabits(
                              'Cut down on saturated fat, sugar and salt.'),
                          buildHealthierEatingHabits(
                              'Substitute skimmed or low-fat milk for whole milk.'),
                          buildHealthierEatingHabits(
                              "Bake, broil, roast and boil - don't fry foods."),
                          buildHealthierEatingHabits(
                              'Eat fruit, vegetables, cereals, dried peas and beans, pasta, fish, skinless poultry and lean meats.'),
                          buildHealthierEatingHabits(
                              "Limit alcohol to one drink a day, and if you don't drink, don't start."),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'What about physical activity?',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(height:10,),
                          buildHealthierPhysicalActivity('Check with your doctor before you start.'),
                          buildHealthierPhysicalActivity('Start slow and build up to 30 minutes, 3 to 4 times a week.'),
                          buildHealthierPhysicalActivity('Physical activity reduces your risk of heart attack and makes your heart stronger.'),
                          buildHealthierPhysicalActivity('Staying active controls your weight and blood pressure; helps you relax, and can improve your mood!'),
                          buildHealthierPhysicalActivity("Bake, broil, roast and boil - don't fry foods"),
                          buildHealthierPhysicalActivity("Look for chances to be more active. Take 10–15-minute walking breaks during the day or after meals."),
                        ],
                      ),
                    ),
                  ),
                ),
              if (selectedIndex ==2)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Non-Modifiable Risk Factor',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'AGE',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            ageTxt,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          SizedBox(height:10,),
                          Text(
                            'SEX',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            sexTxt,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          SizedBox(height:10,),
                          Text(
                            'HEREDITY',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            heredityTxt,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              if (selectedIndex ==3)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Modifiable Risk Factor',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color:AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Content List
                        buildModifiedRiskFactor(
                          'HIGH BLOOD CHOLESTEROL - ',
                          'is recognized as one of the first three risk factors leading to heart disease. A fat particle with a complex structure, if present in more than adequate quantity in blood gets deposited to create blockages. A diet rich in cholesterol source is a major threat to the heart health.',
                        ),
                        buildModifiedRiskFactor(
                          'HIGH BLOOD TRIGLYCERIDES - ',
                          'Increased level of Triglycerides or fat in food is another factor for heart disease. A level of 160 mg/100ml is associated with increased incidence.',
                        ),
                        buildModifiedRiskFactor(
                          'HIGH BLOOD PRESSURE - ',
                          'A ‘silent killer’, as High Blood pressure puts an extra strain on the heart and is also a major cause for deposition of cholesterol and fat in the coronary arteries.',
                        ),
                        buildModifiedRiskFactor(
                          'OBESITY - ',
                          'Lack of physical exercise & wrong food habits will make a person obese and make them prone to heart diseases.',
                        ),
                        buildModifiedRiskFactor(
                          'STRESS AND MENTAL TENSION - ',
                          'Psychological stress is recognized as most important risk factor for heart disease. In absence of other risk factors people can still have angina, if stress is not controlled, it leads to contraction of coronary arteries.',
                        ),
                        buildModifiedRiskFactor(
                          'SEDENTARY LIFE STYLE - ',
                          'Modern mechanization makes everything available easily, as a result physical activity of people is almost nil which predisposes them to many diseases.',
                        ),
                        buildModifiedRiskFactor(
                          'INTAKE OF ALCOHOL - ',
                          'Alcohol owing to its structural similarity with glycerol is associated with major risk. It is a source of empty calories and leads to diseases of liver, gastritis etc.',
                        ),
                        buildModifiedRiskFactor(
                          'LOW HDL CHOLESTEROL - ',
                          'HDL also called ‘good cholesterol’ can be another factor for CHD as it binds cholesterol and removes it from blockages.',
                        ),
                        buildModifiedRiskFactor(
                          'SMOKING OR TOBACCO CONSUMPTION - ',
                          'Studies have proved that smoking substantially increases the risk of heart attack. Consuming tobacco in any form is equally hazardous as both are bad for health.',
                        ),
                        buildModifiedRiskFactor(
                          'DIABETES MELLITUS - ',
                          'Uncontrolled blood sugar levels is associated with obesity, high blood pressure and high cholesterol levels responsible for CHD.',
                        ),
                      ],
                    ),
                  ),
                ),
              if (selectedIndex ==4)
                 Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'What to do after heart Attack',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'FontPoppins',
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        buildHeartAttackRiskFactor(
                            'CHEST PAIN NOT RELIEVED BY REST OR SUB LINGUAL SORBITRATE -',
                            chestPainTxt),
                        buildHeartAttackRiskFactor(
                            'SWEATING -',
                            'pain is often accompanied by a profuse sweating. Even in a cold atmosphere the patient perspires.'),
                        buildHeartAttackRiskFactor(
                            'FEELING OF INTENSE WEAKNESS -',
                            intenseFeelingTxt),
                        buildHeartAttackRiskFactor(
                            'SUFFOCATION -',
                            suffocationTxt),
                        buildHeartAttackRiskFactor(
                            'BURNING SENSATION IN THE CHEST -',
                            burningSensationTxt),
                      ],
                    ),
                  ),
                ),
              ),
              if (selectedIndex ==5)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Table(
                            border:
                            TableBorder.all(color: Colors.grey, width: 0.6),
                            columnWidths: const {
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              // Ensure consistent column count
                            },
                            children: [
                              // Header Row
                              TableRow(
                                decoration:
                                const BoxDecoration(color: AppColors.primaryDark),
                                children: [
                                  buildHeaderCell('No'),
                                  buildHeaderCell('Causative Factors'),
                                  buildHeaderCell(
                                      'Usual Cardiology Recommendation'),
                                  buildHeaderCell('SAAOL Recommendation'),
                                ],
                              ),
                              // Data Rows
                              buildDataRow('1', 'Serum Cholesterol',
                                  '130 - 200 mg/dl', 'Less than 130mg/dl'),
                              buildDataRow('2', 'Serum Triglycerides',
                                  '60 - 160 mg/dl', 'Less than 100 mg/dl'),
                              buildDataRow('3', 'Serum HDL Cholesterol',
                                  '30 - 60 mg/dl', 'More than 40 mg/dl'),
                              buildDataRow('4', 'Cholesterol: HDL', '4 - 5',
                                  'Below 4 Ratio'),
                              buildDataRow('5', 'Serum LDL Cholesterol',
                                  '30 - 130 mg/dl', 'Less than 70 mg/dl'),
                              buildDataRow('6', 'Blood Pressure (systolic)',
                                  '120 - 140 mmHg', '120 mmHg or less'),
                              buildDataRow('7', 'Blood Pressure (diastolic)',
                                  '70 - 90 mmHg', '80 mmHg or less'),
                              buildDataRow('8', 'Blood Glucose (Fasting)',
                                  '80 - 110 mg/dl', '70 - 100 mg/dl'),
                              buildDataRow('9', 'Blood Glucose (PP)',
                                  '120 - 160 mg/dl', 'Less than 140 mg/dl'),
                              buildDataRow('10', 'Smoking/Tobacco',
                                  'To be reduced', 'Banned'),
                              buildDataRow(
                                  '11',
                                  'Exercise/Walk',
                                  'Should be done',
                                  'Must do, at least one hour'),
                              buildDataRow(
                                  '12',
                                  'Weight',
                                  '20 - 30% extra (from any chart)',
                                  'Only 2 - 3 Kg extra allowed permitted from Indian Chart'),
                              buildDataRow('13', 'Fiber intake',
                                  'Not specified', 'Plenty everyday'),
                              buildDataRow(
                                  '14',
                                  'Stress',
                                  'Not defined, Not available',
                                  'Clearly defined, optimal'),
                              buildDataRow('15', 'Total fat intake',
                                  '10 - 30% Calories', '10% of total Calories'),
                              buildDataRow('16', 'Visible-fat intake',
                                  'PUFA, MUFA etc.', 'Banned'),
                              buildDataRow('17', 'Cholesterol intake/day',
                                  'Not defined', '10 mg/day'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              if (selectedIndex ==6)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Prevent Heart Attacks',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            textAlign: TextAlign.justify,
                            preventAttackTxt,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buildPreventAttackFactor(
                              'Cholesterol below 130 mg/dl.'),
                          buildPreventAttackFactor(
                              'Triglycerides 60 to 100 mg/dl.'),
                          buildPreventAttackFactor(
                              'HDL Cholesterol 40 to 60 mg/dl.'),
                          buildPreventAttackFactor(
                              'Blood glucose (Fasting) 70 to 100 mg/dl.'),
                          buildPreventAttackFactor(
                              'Blood Glucose(PP) below 140 mg/dl.'),
                          buildPreventAttackFactor(
                              'Blood Pressure 120/80 mmHg.'),
                          buildPreventAttackFactor(
                              'Maximum permissible exercises.'),
                          buildPreventAttackFactor(
                              'Body weight in proportion to height.'),
                          buildPreventAttackFactor('Stop smoking completely.'),
                          buildPreventAttackFactor('Control stress.'),
                          buildPreventAttackFactor(
                              'Oil/Ghee in food is banned completely.'),
                          buildPreventAttackFactor(
                              'Consume salads and fruits in plenty.'),
                          buildPreventAttackFactor(
                              'Restrict consumption of milk and milk products.'),
                          buildPreventAttackFactor('Avoid meat of any kind.'),
                        ],
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  TableRow buildDataRow(
      String number, String factor, String usual, String saaol) {
    return TableRow(
      children: [
        buildDataCell(number),
        buildDataCell(factor),
        buildDataCell(usual),
        buildDataCell(saaol),
      ],
    );
  }

  Widget buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'FontPoppins',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 13,
            fontFamily: 'FontPoppins',
            fontWeight: FontWeight.w500,
            color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }
}

Widget buildRiskFactorItem(String title, String count) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'FontPoppins',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget buildHealthierSteps(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildHealthierSmoking(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildHealthierEatingHabits(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildHealthierPhysicalActivity(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildPreventAttackFactor(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildModifiedRiskFactor(String title, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          TextSpan(
            text: description,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'FontPoppins',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildHeartAttackRiskFactor(String title, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          TextSpan(
            text: description,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'FontPoppins',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}
