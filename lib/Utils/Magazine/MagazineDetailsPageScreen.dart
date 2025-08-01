import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:saaolapp/common/app_colors.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineGalleryResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineSliderResponse.dart';

class MagazineDetailsPageScreen extends StatefulWidget {
  final Gallery gallery;
  const MagazineDetailsPageScreen({super.key,required this.gallery});

  @override
  State<MagazineDetailsPageScreen> createState() => _MagazineDetailsPageScreenState();
}


class _MagazineDetailsPageScreenState extends State<MagazineDetailsPageScreen> {
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
            child: Image.network(widget.gallery.image.toString(),
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
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width:0.5,
                    ),
                    left: BorderSide(
                      color: Colors.grey,
                      width:0.5,
                    ),
                    right: BorderSide(
                      color: Colors.grey,
                      width:0.5,
                    ),
                  ),
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
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.gallery.title.toString(),
                                style: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize:14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height:10,),
                              Row(crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('SAAOL Heart Center',
                                    style:TextStyle(fontWeight:FontWeight.w500,
                                        fontSize:12,fontFamily:'FontPoppins',color:AppColors.primaryColor),),
                                  SizedBox(width:10,),
                                  Text('${widget.gallery.monthName},${widget.gallery.year}',
                                    style:const TextStyle(fontWeight:FontWeight.w500,
                                        fontSize:12,fontFamily:'FontPoppins',color:Colors.black),),
                                ],
                              ),
                              const SizedBox(height: 20),

                              /* Html(
                        data: widget.gallery.content,
                        style: {
                          "p": Style(
                            fontSize: FontSize(13.0),
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                            fontWeight:FontWeight.w500,
                            letterSpacing:0.2,
                            textAlign: TextAlign.justify,
                          ),
                          "h2": Style(
                            fontSize: FontSize(16.0),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: AppColors.primaryColor,
                            margin: Margins.only(top: 20, bottom: 10),
                          ),

                          "strong": Style(
                            fontWeight: FontWeight.w600,
                            fontSize:FontSize(13.0),fontFamily:'FontPoppins',color:Colors.black
                          ),
                        },
                      ),*/

                              Html(
                                data:widget.gallery.content,
                                style: {
                                  "h1": Style(
                                    fontSize: FontSize(15),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: 'FontPoppins',
                                    margin: Margins.only(bottom: 10),
                                  ),
                                  "h2": Style(
                                    fontSize: FontSize(18),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: 'FontPoppins',
                                    margin: Margins.only(bottom: 8),
                                  ),
                                  "p": Style(
                                    fontSize: FontSize(12),
                                    color: Colors.black87,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    margin: Margins.only(bottom: 10),
                                  ),
                                  "li": Style(
                                    fontSize: FontSize(12),
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    padding: HtmlPaddings.only(left: 6),
                                  ),
                                  "strong": Style(
                                    fontWeight: FontWeight.w600,
                                    fontSize:FontSize(14),
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black,
                                  ),
                                },
                              ),
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


class MagazineSliderPageScreen extends StatefulWidget {
  final EmagazineDataSlider sliderData;
  const MagazineSliderPageScreen({super.key,required this.sliderData});
  @override
  State<MagazineSliderPageScreen> createState() => _MagazineSliderPageScreenState();
}

class _MagazineSliderPageScreenState extends State<MagazineSliderPageScreen> {
  final DraggableScrollableController sheetController =
  DraggableScrollableController();
  int? expandedIndex;

  String formatMonthYear(String month, String year) {
    final date = DateTime(int.parse(year), int.parse(month));
    return DateFormat('MMMM, yyyy').format(date); // Output: March, 2025
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(widget.sliderData.image.toString(),
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
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width:0.5,
                    ),
                    left: BorderSide(
                      color: Colors.grey,
                      width:0.5,
                    ),
                    right: BorderSide(
                      color: Colors.grey,
                      width:0.5,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child:SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.sliderData.title.toString(),
                                style: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize:14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height:10,),
                              Row(crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('SAAOL Heart Center',
                                    style:TextStyle(fontWeight:FontWeight.w500,
                                        fontSize:12,fontFamily:'FontPoppins',color:AppColors.primaryColor),),
                                  const SizedBox(width:10,),

                                  Text(
                                    formatMonthYear(widget.sliderData.emagzineMonth.toString(), widget.sliderData.year.toString()),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Html(
                                data: widget.sliderData.content,
                                style: {
                                  "p": Style(
                                    fontSize: FontSize(13.0),
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black,
                                    fontWeight:FontWeight.w500,
                                    letterSpacing:0.2,
                                    textAlign: TextAlign.justify,
                                  ),
                                  "h2": Style(
                                    fontSize: FontSize(16.0),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FontPoppins',
                                    color: AppColors.primaryColor,
                                    margin: Margins.only(top: 20, bottom: 10),
                                  ),
                                  "strong": Style(
                                      fontWeight: FontWeight.w600,
                                      fontSize:FontSize(13.0),fontFamily:'FontPoppins',color:Colors.black
                                  ),
                                },
                              ),
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
