import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:saaolapp/common/app_colors.dart';

class BlogDetailPageScreen extends StatefulWidget {
  final String image;
  final String content;
  const BlogDetailPageScreen({super.key, required this.image,required this.content});

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
              widget.image.toString(),
              width: double.infinity,
              fit: BoxFit.fill,
              height:250,
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
            padding:  const EdgeInsets.only(top:240.0),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(
                  color:Colors.grey.withOpacity(0.4),  // Border color
                  width:1,          // Border width
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Html(
                        data: widget.content,
                        style: {
                          "p": Style(
                            fontSize: FontSize(13.0),
                            fontFamily:'FontPoppins',
                            fontWeight:FontWeight.w500,
                            color: Colors.black87,
                          ),
                          "h2": Style(
                            fontSize: FontSize(16.0),
                            color: AppColors.primaryColor,
                            fontFamily:'FontPoppins',
                            fontWeight:FontWeight.w600,
                            margin: Margins.only(bottom: 10),
                          ),
                          "h3": Style(
                            fontSize: FontSize(16.0),
                            color:AppColors.primaryColor,
                            fontFamily:'FontPoppins',
                            fontWeight:FontWeight.w600,
                          ),
                          "ul": Style(
                            padding: HtmlPaddings.only(left: 20),
                          ),
                          "li": Style(
                            fontSize: FontSize(13),
                            color: Colors.black87,
                            fontFamily:'FontPoppins',
                            fontWeight:FontWeight.w500,
                          ),
                          "strong": Style(
                            fontWeight: FontWeight.bold,
                          ),
                          "a": Style(
                            color:AppColors.primaryDark,
                            textDecoration: TextDecoration.underline,
                          ),
                        },
                      ),
                      /*Text(
                        widget.blogs.content.toString().trim(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          letterSpacing:0.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),*/
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
