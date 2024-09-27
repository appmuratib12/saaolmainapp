import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';


class SAAOLlEMagazineDetailScreen extends StatefulWidget {
  const SAAOLlEMagazineDetailScreen({super.key});

  @override
  State<SAAOLlEMagazineDetailScreen> createState() => _SAAOLlEMagazineDetailScreenState();
}

class _SAAOLlEMagazineDetailScreenState extends State<SAAOLlEMagazineDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300, // Adjust this height value as needed
          width: MediaQuery.of(context).size.width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/images/surgeon_Image.jpg'),
                fit: BoxFit.cover,
                width: double.infinity,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 250.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Unlocking the Importance of a Heart-Nourishing Lifestyle for Cardiovascular Wellness',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      magaZineTxt1,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Understanding Cardiovascular Health',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    buildSectionTitle('What is Cardiovascular Health ?'),
                    buildBodyText(
                        'Cardiovascular health refers to the proper functioning of the heart and blood vessels. '
                            'It encompasses maintaining healthy blood pressure and cholesterol levels and ensuring that the heart pumps efficiently.'),
                    buildSectionTitle('Common Cardiovascular Diseases'),
                    buildBodyText(
                        'Cardiovascular diseases include conditions like coronary artery disease, heart attacks, and strokes. '
                            'These diseases are often the result of a combination of genetic and lifestyle factors.'),
                    buildSectionTitle('Diet and Nutrition for a Healthy Heart'),
                    buildBulletPoint(
                        '1. Essential Nutrients:',
                        'Your heart thrives on a diet rich in essential nutrients such as omega-3 fatty acids, fiber, antioxidants, and vitamins. '
                            'These nutrients help reduce inflammation, lower cholesterol, and improve overall heart function.'),
                    buildBulletPoint('2. Foods to Include:',
                        'Incorporate foods like whole grains, fruits, and vegetables into your diet. These foods are packed with heart-healthy nutrients that can make a significant difference.'),
                    buildBulletPoint('3. Foods to Avoid:',
                        'Avoid foods high in saturated fats, trans fats, and excessive salt. Processed foods, sugary snacks, and red meat can contribute to heart disease by clogging arteries and raising blood pressure.'),
                    buildBulletPoint('4. Benefits of a Balanced Diet:',
                        'A balanced diet keeps your heart healthy, aids in weight management, reduces the risk of diabetes, and boosts energy levels.'),
                    buildBulletPoint('5. Zero Oil Cooking and Oil-Free Food:',
                        'Adopting a zero-oil cooking approach can significantly benefit heart health. Cooking without oil reduces the intake of unhealthy fats, lowering cholesterol levels and preventing artery blockages.'),
                    buildBulletPoint('6. Detox for Cardiovascular Health:',
                        'Engage in regular detox routines to eliminate toxins from the body. Detoxifying helps in reducing inflammation and improving overall cardiovascular function.'),
                    buildSectionTitle('Exercise and Physical Activity'),
                    buildBulletPoint('1. Importance of Regular Exercise:',
                        'Exercise is a cornerstone of cardiovascular health. It helps in maintaining a healthy weight, reducing blood pressure, and improving blood circulation.'),
                    buildBulletPoint('2. Types of Heart-Healthy Exercises:',
                        'Engage in aerobic exercises like walking, running, cycling, and swimming. These activities strengthen the heart muscle and enhance its efficiency.'),
                    buildBulletPoint(
                        '3. Creating a Sustainable Exercise Routine:',
                        'Find activities you enjoy and incorporate them into your daily routine. Consistency is key, so aim for at least 150 minutes of moderate weekly exercise.'),
                    buildBulletPoint('4. Yoga for Heart Health:',
                        'Yoga is an excellent way to enhance cardiovascular wellness. It combines physical postures, breathing exercises, and meditation, improving heart function and reducing stress.'),
                    buildSectionTitle('Mental Health and Stress Management'),
                    buildBulletPoint(
                        '1. Connection Between Stress and Heart Health:',
                        'Chronic stress can lead to high blood pressure and other heart-related issues. It\'s essential to manage stress effectively to maintain cardiovascular health.'),
                    buildBulletPoint('2. Techniques for Stress Reduction:',
                        'Practice mindfulness, meditation, and deep breathing exercises. These techniques can help calm your mind and reduce stress levels.'),
                    buildBulletPoint(
                        '3. Role of Sleep in Cardiovascular Wellness:',
                        'Quality sleep is vital for heart health. Aim for 7-9 hours of sleep per night to allow your body to recover and rejuvenate.'),
                    buildSectionTitle('Avoiding Harmful Habits'),
                    buildBulletPoint(
                        '1.Importance of Routine Medical Check-Ups',
                        'Regular check-ups can help detect early signs of heart disease and other health issues. Early detection allows for timely intervention and better management'),
                    buildBulletPoint('2. Key Health Metrics to Monitor : ',
                        'Keep track of your blood pressure, cholesterol, and blood sugar levels. These metrics provide valuable insights into your heart health.'),
                    buildBulletPoint('3. How to Prepare for a Health Check-Up:',
                        'Prepare a list of symptoms, medications, and questions for your doctor. This will ensure a comprehensive evaluation and effective consultation'),
                    buildSectionTitle(
                        'Social Connections and Community Support'),
                    buildBulletPoint(
                        '1. Impact of Social Relationships on Heart Health:',
                        'Prepare a list of symptoms, medications, and questions for your doctor. This will ensure a comprehensive evaluation and effective consultation'),
                    buildBulletPoint('2. Building a Supportive Network:',
                        ' Cultivate relationships with family, friends, and support groups. A strong network provides emotional support and motivation.'),
                    buildBulletPoint('3. Engaging in Community Activities: ',
                        'Participate in community events and volunteer work. These activities enhance social connections and contribute to a positive outlook on life.'),
                    buildSectionTitle('Innovative Approaches to Heart Health'),
                    buildBulletPoint('1.Advances in Medical Technology:',
                        'Modern technology offers advanced tools for monitoring and improving heart health. Wearable devices and mobile apps can track your heart rate, activity levels, and more.'),
                    buildBulletPoint(
                        '2. Integrating Technology with Lifestyle Changes:',
                        'Use technology to stay motivated and informed about your heart health. Fitness apps and online resources can provide valuable guidance and support.'),
                    buildBulletPoint(
                        '3. Future Trends in Cardiovascular Wellness: ',
                        'tay updated with the latest research and trends in cardiovascular health. Innovations in medical science continue to offer new ways to protect and enhance heart health.'),
                    const Text(
                      'Conclusion',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    buildBodyText(conclusionTxt)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
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
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'FontPoppins',
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildBulletPoint(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'FontPoppins',
            color: Colors.black54,
          ),
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: const TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' $content',
            ),
          ],
        ),
      ),
    );
  }
}
