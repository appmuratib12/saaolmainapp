import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saaolapp/Utils/Magazine/MagazineDetailsPageScreen.dart';
import 'package:saaolapp/Utils/VideoPlayerScreen.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineGalleryResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineHeartVideoResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineNewsCategoriesResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineNewsResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazinePostsResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineSliderResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineTalkResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineZeroOilResponse.dart';
import 'package:saaolapp/data/network/BaseApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/app_colors.dart';



class MagazineBlogDetailPage extends StatefulWidget {
  final String month;
  final String year;
  const MagazineBlogDetailPage({super.key,required this.month,required this.year});

  @override
  State<MagazineBlogDetailPage> createState() => _MagazineBlogDetailPageState();
}

class _MagazineBlogDetailPageState extends State<MagazineBlogDetailPage> {

  int selectedIndex = 0;

  String zeroURL = "https://www.youtube.com/results?search_query=saaol+zero+oil";
  String storeID = "1";
  late Future<EmagazineHeartVideoResponse> heartVideoFuture;
  late Future<EmagazineNewsCategoriesResponse> newsCategoriesFuture;
  late Future<EmagazineSliderResponse> emagazineSliderFuture;
  late Future<EmagazinePostsResponse> emagazinePostsFuture;
  late Future<EmagazineTalkResponse> emagazineTalkFuture;
  late Future<EmagazineZeroOilResponse> emagazineZeroOilFuture;

  @override
  void initState() {
    super.initState();
    heartVideoFuture = BaseApiService().getEmagazineHeartVideoData(widget.year, widget.month);
    newsCategoriesFuture = BaseApiService().getNewsCategoriesData();
    emagazineSliderFuture = BaseApiService().getEmagazineSliderData(widget.year,widget.month);
    emagazinePostsFuture = BaseApiService().getEmagazinePostData();
    emagazinePostsFuture = BaseApiService().getEmagazinePostData();
    emagazineTalkFuture = BaseApiService().getEmagazineTalkData(widget.year, widget.month);
    emagazineZeroOilFuture = BaseApiService().getEmagazineZeroOilData(widget.year,widget.month);
  }

  String formatMonthYear(String rawMonth, String year) {
    try {
      int monthNumber;
      try {
        monthNumber = DateFormat.MMMM().parse(rawMonth).month;
      } catch (_) {
        monthNumber = int.parse(rawMonth);
      }

      final date = DateTime(int.parse(year), monthNumber);
      return DateFormat('MMMM, yyyy').format(date); // e.g., "December, 2025"
    } catch (e) {
      return "$rawMonth, $year";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL E-Magzine Detail',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
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
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              FutureBuilder<EmagazineGalleryResponse>(
                future: BaseApiService().getEmagazineGalleryData(widget.year, widget.month),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                            SizedBox(height: 12),
                            Text(
                              'Emagazine Data is not available at the moment.',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Please try again later. We are working to resolve the issue.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.gallery != null) {
                    final gallery = snapshot.data!.gallery!;
                    return GestureDetector(
                      onTap: (){
                        print('Year:${widget.year},${widget.month}');
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => MagazineDetailsPageScreen(
                              gallery:gallery
                          ),
                        ));
                      },
                      child:Stack(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(gallery.image.toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height:55,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(1),
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(
                                    gallery.title.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'FontPoppins',
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book_outlined, size: 48, color: AppColors.primaryDark),
                            SizedBox(height: 12),
                            Text(
                              'No Emagazine available.',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Please check back later. New content will be available soon!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'FontPoppins',
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),

               Divider(
                height:30,
                thickness:3,
                color: Colors.blue[200],
              ),
               SizedBox(
                height:270,
                child: FutureBuilder<EmagazineSliderResponse>(
                  future:emagazineSliderFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching Emagazine: ${snapshot.error}');
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                              SizedBox(height: 12),
                              Text(
                                'Emagazine Data is not available at the moment.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please try again later. We are working to resolve the issue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu_book_outlined, size: 48, color: AppColors.primaryDark),
                              SizedBox(height: 12),
                              Text(
                                'No Emagazine available.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New content will be available soon!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.data!.length - 1,
                        itemBuilder: (context, index) {
                          final item = snapshot.data!.data![index + 1];
                          final monthName = DateFormat.MMMM().format(DateTime(0, int.parse(item.month.toString())));
                          final displayDate = '$monthName, ${item.year}';
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                  builder: (context) => MagazineSliderPageScreen(
                                    sliderData:item
                                  ),
                                ));
                              },
                              child: Container(
                                width: 260,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                      child: Image.network(
                                        item.image.toString(),
                                        height:150,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title ?? 'Untitled',
                                            style: const TextStyle(
                                              fontSize:13,
                                              fontFamily:'FontPoppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines:4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height:10),
                                          Row(crossAxisAlignment:CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Text('SAAOL Heart Center',
                                                style:TextStyle(fontWeight:FontWeight.w500,
                                                    fontSize:12,fontFamily:'FontPoppins',color:AppColors.primaryColor),),
                                              const SizedBox(width:10,),

                                              Text(
                                                '$monthName,${item.year}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: 'FontPoppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),

            /*  const Text(
                "Popular Posts",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(height:10,),
              SizedBox(
                height:210,
                child: FutureBuilder<EmagazinePostsResponse>(
                  future:emagazinePostsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching Post: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const Center(child: Text('No Post Available.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.data![index];
                          return InkWell(
                            onTap: () {
                              // Add your onTap action here
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color:Colors.white,
                                      image: DecorationImage(
                                        image: NetworkImage(post.image.toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.9),
                                                ],
                                              ),
                                              borderRadius: const BorderRadius.vertical(
                                                bottom: Radius.circular(16.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          right: 10,
                                          child: Column(
                                            children: [
                                              Text(
                                                post.title.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: 'FontPoppins',
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                   const Text(
                                                    'by SAAOL',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:FontWeight.w600,
                                                      fontFamily: 'FontPoppins',
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    post.month.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:11,
                                                      fontWeight:FontWeight.w500,
                                                      fontFamily: 'FontPoppins',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
*/
              Visibility(
                visible: widget.year == null &&
                    widget.year.isEmpty &&
                    widget.month == null &&
                    widget.month.isEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height:20,
                      thickness: 0.5,
                      color: Colors.blue[200],
                    ),
                    const Text(
                      "Dr. Bimal Chhajer Talk's",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 280,
                      child: FutureBuilder<EmagazineTalkResponse>(
                        future: emagazineTalkFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.data == null ||
                              snapshot.data!.data!.isEmpty) {
                            return  const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.menu_book_outlined, size: 48, color: AppColors.primaryDark),
                                    SizedBox(height: 12),
                                    Text(
                                      "No Dr. Bimal Chhajer Talk's Available",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please check back later. New content will be available soon!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            final talks = snapshot.data!.data!;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: talks.length,
                              itemBuilder: (context, index) {
                                final talkItem = talks[index];
                                return InkWell(
                                  onTap: () {

                                  },
                                  child: Padding(padding:
                                  const EdgeInsets.symmetric(horizontal:6),
                                    child:Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(16)),
                                            child: Image.network(
                                              talkItem.image ?? '',
                                              height: 140,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) =>
                                                  Container(
                                                    height: 140,
                                                    color: Colors.grey[300],
                                                    child: const Center(
                                                        child: Icon(Icons.broken_image,
                                                            size: 40)),
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color:AppColors.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    talkItem.type ?? '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  talkItem.content?.trim() ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                    fontFamily: 'FontPoppins',
                                                  ),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  'by SAAOL',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    fontFamily: 'FontPoppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

               Divider(
                height: 30,
                thickness:3,
                color: Colors.blue[200],
              ),
              const Text(
                "SAAOL Zero oil Recipe of the month",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height:250,
                child: FutureBuilder<EmagazineZeroOilResponse>(
                  future: BaseApiService().getEmagazineZeroOilData(widget.year,widget.month), // Make sure this matches your actual method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching YouTube video: ${snapshot.error}');
                      return  const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                              SizedBox(height: 12),
                              Text(
                                'Youtube Data is not available at the moment.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please try again later. We are working to resolve the issue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.youtube_searched_for, size: 48, color: AppColors.primaryDark),
                              SizedBox(height: 12),
                              Text('No YouTube Video Available.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New content will be available soon!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final videos = snapshot.data!.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          final formattedDate = DateFormat('dd MMMM, yyyy').format(DateTime.parse(video.date.toString()));
                          final uri = Uri.parse(video.youtubeLink.toString());
                          String videoId = '';
                          if (uri.host.contains('youtu.be')) {
                            videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
                          } else {
                            videoId = uri.queryParameters['v'] ?? '';
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(videoId: videoId,title:video.contentCard.toString()),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 320,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            'https://img.youtube.com/vi/$videoId/0.jpg',
                                            width: double.infinity,
                                            height:140,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned.fill(
                                            child: Center(
                                              child: Icon(
                                                Icons.play_circle_fill,
                                                size: 60,
                                                color: Colors.white.withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        video.contentCard.toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:10,),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "BY ZERO OIL COOKING",
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url = Uri.parse(zeroURL);
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                                }
                                              },
                                          ),
                                          const TextSpan(text: "  "), // space between spans
                                          TextSpan(text: formattedDate,
                                              style:const TextStyle(fontWeight:FontWeight.w500,
                                                  fontSize:12,fontFamily:'FontPoppins',
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
               Divider(
                height:30,
                thickness: 3,
                color: Colors.blue[200],
              ),
              const Text(
                "Saaol heart center youtube channel",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height:260,
                child: FutureBuilder<EmagazineHeartVideoResponse>(
                  future: heartVideoFuture, // Make sure this matches your actual method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching YouTube video: ${snapshot.error}');
                      return  const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                              SizedBox(height: 12),
                              Text(
                                'Youtube Data is not available at the moment.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please try again later. We are working to resolve the issue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const  Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.youtube_searched_for, size: 48, color: AppColors.primaryDark),
                              SizedBox(height: 12),
                              Text(
                                'No YouTube Video Available',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New content will be available soon!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final videos = snapshot.data!.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          final formattedDate = DateFormat('dd MMMM, yyyy').format(DateTime.parse(video.date.toString()));
                          final uri = Uri.parse(video.youtubeLink.toString());
                          String videoId = '';
                          if (uri.host.contains('youtu.be')) {
                            videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
                          } else {
                            videoId = uri.queryParameters['v'] ?? '';
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(videoId: videoId,title:video.tag.toString(),),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 320,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            'https://img.youtube.com/vi/$videoId/0.jpg',
                                            width: double.infinity,
                                            height:150,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned.fill(
                                            child: Center(
                                              child: Icon(
                                                Icons.play_circle_fill,
                                                size: 60,
                                                color: Colors.white.withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        video.contentCard.toString(),
                                        maxLines:3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize:13,
                                          fontFamily:'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:8,),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "BY ZERO OIL COOKING",
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url = Uri.parse(zeroURL);
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                                }
                                              },
                                          ),
                                          const TextSpan(text: "  "), // space between spans
                                          TextSpan(text: formattedDate,
                                              style:const TextStyle(fontWeight:FontWeight.w500,
                                                  fontSize:12,fontFamily:'FontPoppins',
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),

               Divider(
                height:30,
                thickness:3,
                color: Colors.blue[200],
              ),


              const Text(
                'SAAOL News',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'FontPoppins',
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height:40,
                child:FutureBuilder<EmagazineNewsCategoriesResponse>(
                  future:newsCategoriesFuture, // Make sure this matches your actual method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching news video: ${snapshot.error}');
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                              SizedBox(height: 12),
                              Text(
                                'Data is not available at the moment.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please try again later. We are working to resolve the issue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const  Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu_book_outlined, size: 48, color: AppColors.primaryDark),
                              SizedBox(height: 12),
                              Text(
                                'No News Available',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New content will be available soon!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final news = snapshot.data!.data!;
                      return  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          final item = news[index];
                          final isSelected = selectedIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  storeID = item.id.toString();
                                });
                                print('StoreNewsID:$storeID');

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: isSelected
                                      ? [
                                    BoxShadow(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                      : [
                                    BoxShadow(
                                      color:
                                      Colors.grey.withOpacity(0.15),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(item.category.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:12,
                                      fontFamily: 'FontPoppins',
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height:15,),

              SizedBox(
                height:330,
                child: FutureBuilder<EmagazineNewsResponse>(
                  future: BaseApiService().getEmagazineNews(storeID), // Make sure this matches your actual method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching news video: ${snapshot.error}');
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                              SizedBox(height: 12),
                              Text(
                                'Data is not available at the moment.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please try again later. We are working to resolve the issue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu_book_outlined, size: 48, color: AppColors.primaryDark),
                              SizedBox(height: 12),
                              Text(
                                'No News Available',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New content will be available soon!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final newsList = snapshot.data!.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          final item = newsList[index];
                          return InkWell(
                            onTap: () {

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 320,
                                padding:const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Image.network(item.image.toString(),
                                            width:MediaQuery.of(context).size.width,
                                            height:160,
                                            fit: BoxFit.fill,
                                          ),
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: Image.asset(
                                              'assets/images/saool_logo.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.tag ?? 'News',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize:10,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        item.title.toString(),
                                        maxLines:3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize:13,
                                          fontFamily:'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:6),
                                    Expanded(
                                      child: Text(
                                        item.content.toString(),
                                        maxLines:8,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize:11,
                                          fontFamily:'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:10,),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "BY SAAOL",
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url = Uri.parse('https://saaol.com/emagzine/2025/jan#');
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                                }
                                              },
                                          ),
                                          const TextSpan(text: "  "), // space between spans
                                          TextSpan(
                                            text: formatMonthYear(item.month.toString(), item.year.toString()),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              fontFamily: 'FontPoppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),


              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
