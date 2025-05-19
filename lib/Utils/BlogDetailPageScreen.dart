import 'package:flutter/material.dart';
import '../constant/text_strings.dart';
import '../data/model/apiresponsemodel/BlogsResponseData.dart';

class BlogDetailPageScreen extends StatefulWidget {
  final Blogs blogs;

  const BlogDetailPageScreen({super.key, required this.blogs});

  @override
  State<BlogDetailPageScreen> createState() => _BlogDetailPageScreenState();
}

class _BlogDetailPageScreenState extends State<BlogDetailPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.blogs.image.toString(),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5), // manual nudge for visual balance
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size:22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Blog Title
                      Text(
                        widget.blogs.title.toString(),
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        blogTxt1,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          letterSpacing:0.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Understanding Heart Blockages and Coronary Artery Disease',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        widget.blogs.description.toString().trim(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          letterSpacing:0.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
