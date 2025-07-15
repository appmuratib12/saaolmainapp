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
  final DraggableScrollableController sheetController =
  DraggableScrollableController();
  int? expandedIndex;

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
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 0.9,
            expand: true,
            controller: sheetController,
            builder: (BuildContext context, scrollController) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        physics:const BouncingScrollPhysics(),
                        child: Container(
                          padding:const EdgeInsets.only(top:10,left:15,right:15),
                            decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              border: Border.all(
                                color:Colors.grey.withOpacity(0.4),  // Border color
                                width:1,          // Border width
                              ),
                              color: Colors.white,
                            ),
                            child:Column(
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
                                const SizedBox(height: 15),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
