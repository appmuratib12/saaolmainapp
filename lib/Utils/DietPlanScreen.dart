import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class DietPlanScreen extends StatefulWidget {
  const DietPlanScreen({super.key});

  @override
  State<DietPlanScreen> createState() => _DietPlanScreenState();
}


class _DietPlanScreenState extends State<DietPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Beige background color
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Welcome to\nDiet Plan',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Optional space between text and image
                      Image.asset(
                        'assets/images/diet_plan_image.png',
                        fit: BoxFit.cover,
                        height: 180,
                        width: 180,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Complete your daily\nnutrition",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 10),
                            Icon(Icons.download),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Ingredient List
                    Expanded(
                      child: ListView(
                        children: [
                          _buildIngredientItem(
                            'How to balance weight?',
                            'Eat smaller meals more often, adding healthy snacks between meals.',
                            'https://diabesmart.in/cdn/shop/articles/how-to-gain-weight-with-diabetes.png?v=1712124083&width=1100',
                          ),
                          _buildIngredientItem(
                            'Diet for heart patients',
                            'To make your dish balanced, include natural sugar from this fruit.',
                            'https://www.eatingwell.com/thmb/088YHsNmHkUQ7iNGP4375MiAXOY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_7866255_foods-you-should-eat-every-week-to-lose-weight_-04-d58e9c481bce4a29b47295baade4072d.jpg',
                          ),
                          _buildIngredientItem(
                            'Healthy diet lifestyle',
                            'Vegetables rich in nutrients that contain minerals and antioxidants.',
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYQz4YUF07_QpGFGyYclRYvsBerfQyRBy07Q&s',
                          ),
                          // Add more ingredients with different images as needed
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientItem(
      String name, String description, String imageUrl) {
    return GestureDetector(
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PDFScreen(),  // No URL, load from assets
          ),
        );

        Fluttertoast.showToast(msg:'Click');*/
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl, // Different image for each item
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Limit to 2 lines
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_circle_right,
                    color: AppColors.primaryDark, size: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
