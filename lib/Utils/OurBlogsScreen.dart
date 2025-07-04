import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaolapp/data/model/apiresponsemodel/BlogCategoriesResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/BlogsFilterResponseData.dart';
import 'package:saaolapp/data/model/apiresponsemodel/BlogsResponseData.dart';
import 'package:shimmer/shimmer.dart';
import '../common/app_colors.dart';
import '../data/network/BaseApiService.dart';
import 'BlogDetailPageScreen.dart';

class OurBlogsScreen extends StatefulWidget {
  const OurBlogsScreen({super.key});

  @override
  State<OurBlogsScreen> createState() => _OurBlogsScreenState();
}

class _OurBlogsScreenState extends State<OurBlogsScreen> {
  String selectedCategory = '';
  String? selectedCategoryID;
  int selectedIndex = 0;
  bool isInitialCategorySelected = false;

  Future<BlogCategoriesResponse>? _categoriesFuture;
  Future<BlogsFilterResponseData>? _blogsFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = BaseApiService().blogCategoriesData();
    _categoriesFuture!.then((response) {
      final categories = response.data;
      if (categories != null && categories.isNotEmpty) {
        selectedCategory = categories[0].title!;
        selectedCategoryID = categories[0].id.toString();
        selectedIndex = 0;
        isInitialCategorySelected = true;
        _blogsFuture = BaseApiService().blogsFilterData(selectedCategoryID!);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {});
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Our Blogs',
            style: TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 17,
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
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height:15),
              SizedBox(
                height: 40,
                child: FutureBuilder<BlogCategoriesResponse>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 7),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 230,
                                width: 260,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      final errorMessage = snapshot.error.toString();
                      if (errorMessage.contains('No internet connection')) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_rounded,
                                  size: 30,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'No Internet Connection',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Please check your network settings and try again.',
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
                        return Center(child: Text('Error: $errorMessage'));
                      }
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data == null ||
                        snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'No blogs available.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New data will be available soon!',
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
                      final categories = snapshot.data!.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.data!.length,
                        padding:EdgeInsets.symmetric(horizontal:10),
                        itemBuilder: (context, index) {
                          final category = categories[index].title!;
                          final categoryID = categories[index].id.toString();
                          final isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                                selectedCategoryID = categoryID;
                                selectedIndex = index;
                                _blogsFuture = BaseApiService().blogsFilterData(selectedCategoryID!);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  width: 0.6,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  category.toString(),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
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
              const SizedBox(
                height:15,
              ),
              SizedBox(
                height: 260,
                child:_blogsFuture == null
                    ? _buildBlogShimmer() :
                FutureBuilder<BlogsFilterResponseData>(
                  future:_blogsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 7),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 230,
                                width: 260,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      final errorMessage = snapshot.error.toString();
                      if (errorMessage.contains('No internet connection')) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_rounded,
                                  size: 30,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'No Internet Connection',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Please check your network settings and try again.',
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
                        return Center(child: Text('Error: $errorMessage'));
                      }
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data == null ||
                        snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'No blogs available.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later.New data will be available as soon!',
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
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.data!.length,
                        scrollDirection: Axis.horizontal,
                        padding:const EdgeInsets.symmetric(horizontal:10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(CupertinoPageRoute(
                                builder: (context) => BlogDetailPageScreen(content:snapshot.data!.data![index].content.toString(),
                                    image:snapshot.data!.data![index].image.toString()),
                              ));
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 250,
                                    width: 260,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                                child: Image.network(
                                                  snapshot.data!.data![index]
                                                      .image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  height: 140,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8.0),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.3),
                                                        Colors.transparent,
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end:
                                                      Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              snapshot
                                                  .data!.data![index].title
                                                  .toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'FontPoppins',
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context,
                                                    rootNavigator: true)
                                                    .push(CupertinoPageRoute(
                                                  builder: (context) =>
                                                      BlogDetailPageScreen(content:snapshot.data!.data![index].content.toString(),
                                                          image:snapshot.data!.data![index].image.toString()),
                                                ));
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color:
                                                  AppColors.primaryDark,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Read more',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 11,
                                                      fontFamily:
                                                      'FontPoppins',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                        },
                      );
                    }
                  },
                ),
              ),
            const Padding(padding: EdgeInsets.only(left:15),child:  Text(
              'Recommended for you',
              style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )),
              /*SizedBox(
                height: 260,
                child: Consumer<BlogProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 230,
                                width: 260,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (provider.errorMessage != null) {
                      if (provider.errorMessage!.contains('No internet connection')) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_rounded,
                                  size:30,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(height:8),
                                Text(
                                  'No Internet Connection',
                                  style: TextStyle(
                                    fontSize:14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Please check your network settings and try again.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:12,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(child: Text('Error: ${provider.errorMessage}'));
                      }
                    } else if (provider.blogsResponseData?.blogs == null || provider.blogsResponseData!.blogs!.isEmpty) {
                      return const  Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height:10),
                              Text(
                                'No blogs available.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please check back later. New data will be available soon!',
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
                      final blogs = provider.blogsResponseData!.blogs!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: blogs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(CupertinoPageRoute(
                                builder: (context) => BlogDetailPageScreen(
                                    blogs:blogs[index]),
                              ));
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 250,
                                    width: 260,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  blogs[index].image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  height: 140,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8.0),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.3),
                                                        Colors.transparent,
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              blogs[index].title
                                                  .toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'FontPoppins',
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Align(alignment:Alignment.centerRight,
                                            child:GestureDetector(
                                              onTap: () {
                                                Navigator.of(context, rootNavigator: true)
                                                    .push(CupertinoPageRoute(
                                                  builder: (context) => BlogDetailPageScreen(
                                                      blogs: blogs[index]),
                                                ));
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryDark,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Read more',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 11,
                                                      fontFamily: 'FontPoppins',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                        },
                      );
                    }
                  },
                ),
              ),*/
              const SizedBox(
                height:15,
              ),
              FutureBuilder<BlogsResponseData>(
                future: BaseApiService().blogsAllData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    final errorMessage = snapshot.error.toString();
                    if (errorMessage.contains('No internet connection')) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wifi_off_rounded,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'No Internet Connection',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Please check your network settings and try again.',
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
                      return Center(child: Text('Error: $errorMessage'));
                    }
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data == null ||
                      snapshot.data!.data!.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              'No blogs available.',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Please check back later. New data will be available soon!',
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
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      padding:const EdgeInsets.symmetric(horizontal:12),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(CupertinoPageRoute(
                              builder: (context) => BlogDetailPageScreen(
                                content:snapshot.data!.data![index].content.toString(),
                                image:snapshot.data!.data![index].image.toString(),
                              ),
                            ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 130,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: SizedBox(
                                            height: 110,
                                            width: 130,
                                            child: Image(
                                              image: NetworkImage(snapshot
                                                  .data!.data![index].image
                                                  .toString()),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!.data![index].title
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 12,
                                                  color: Colors.black87,
                                                ),
                                                maxLines: 3,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context,
                                                        rootNavigator: true)
                                                        .push(CupertinoPageRoute(
                                                      builder: (context) =>
                                                          BlogDetailPageScreen(content:snapshot.data!.data![index].content.toString(),
                                                              image:snapshot.data!.data![index].image.toString()),
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryDark,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(15),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Read more',
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 11,
                                                          fontFamily:
                                                          'FontPoppins',
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
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
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
    );
  }
  Widget _buildBlogShimmer() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 230,
              width: 260,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
